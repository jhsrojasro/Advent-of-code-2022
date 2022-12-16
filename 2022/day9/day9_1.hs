import System.IO
import qualified Data.Set as Set
import Data.List.Unique

data Pos = Pos Int Int deriving (Show, Ord, Eq)
data State = State (Set.Set Pos) Pos Pos deriving(Show)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let moves = foldl (\s [dir, steps] -> s ++ (replicate (read steps :: Int) (head dir))) "" $ map words $ lines contents
    print $ Set.size $ (\(State set pos1 pos2) -> set) $ foldl processMove (State Set.empty (Pos 0 0) (Pos 0 0)) moves

processMove :: State -> Char -> State
processMove (State visited posHead posTail) direction = let posHead' = moveInDirection posHead direction
                                                            posTail' = followHead posHead' posTail
                                                        in State (Set.insert posTail' visited) posHead' posTail'

moveInDirection :: Pos -> Char -> Pos
moveInDirection (Pos x y) c = case c of 'U' -> Pos x (y+1)
                                        'D' -> Pos x (y-1)
                                        'R' -> Pos (x+1) y
                                        'L' -> Pos (x-1) y

followHead :: Pos -> Pos -> Pos
followHead (Pos head_x head_y) (Pos tail_x tail_y)
    | x_diff + y_diff == 3 = Pos (tail_x + x_dir) (tail_y + y_dir)
    | x_diff == 2 = Pos (tail_x + x_dir) tail_y
    | y_diff == 2 = Pos tail_x (tail_y + y_dir)
    | otherwise = Pos tail_x tail_y
    where (x_diff, y_diff) = (abs (head_x - tail_x), abs (head_y - tail_y))
          x_dir = if (head_x - tail_x > 0) then 1 else -1
          y_dir = if (head_y - tail_y > 0) then 1 else -1