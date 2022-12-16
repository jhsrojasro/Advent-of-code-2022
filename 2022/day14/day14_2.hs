import System.IO
import Data.List.Split
import qualified Data.Set as Set

data Pos = Pos Int Int deriving(Show)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let input = map ( map (map (\x -> read x :: Int) . splitOn ",") . splitOn " -> ") $ lines contents
    let rocks = foldl insertRockPath Set.empty input
    let limit_y = (maximum $ [snd p | p <- Set.toList rocks]) + 2
    --print rocks
    print $ processSand rocks Set.empty limit_y (Pos 500 0)
    --print $ minimum $ [snd p | p <- Set.toList $ Set.union (Set.filter (\(x,y) -> y > 0 && x == 500) rocks) Set.empty]

processSand :: Set.Set (Int, Int) -> Set.Set (Int, Int) -> Int -> Pos -> Int
processSand rocks sands y_limit (Pos x y)
    | Set.null stops = processSand rocks (Set.insert (x, y_limit-1) sands) y_limit (Pos 500 0)
    | not leftStop = processSand rocks sands y_limit (Pos (x-1) (y'+1))
    | not rightStop = processSand rocks sands y_limit (Pos (x+1) (y'+1))
    | y' == 500 && x==0 = (Set.size sands) + 1
    | Set.size sands == 100 = Set.size sands
    | otherwise = processSand rocks sands' y_limit (Pos 500 0)
    where stops = Set.union (Set.filter filterRocks rocks) (Set.filter filterRocks sands)
          y' = (minimum [snd p | p <- Set.toList stops]) - 1
          leftStop = (Set.member ((x-1), (y'+1)) rocks) || (Set.member ((x-1), (y'+1)) sands || (y'+1) == y_limit)
          rightStop = (Set.member ((x+1), (y'+1)) rocks) || (Set.member ((x+1), (y'+1)) sands || (y'+1) == y_limit)
          sands' = Set.insert (x, y') sands
          filterRocks = (\(x_, y_) -> y_ > y && x_ == x)

insertRockPath :: Set.Set (Int, Int) -> [[Int]] -> Set.Set (Int, Int)
insertRockPath rocks path = foldl insertRockStructure rocks [((head (path !! i), last (path !! i)), (head (path !! (i+1)), last (path !! (i+1))))  | i <- [0..(length $ path) - 2 ]]

insertRockStructure :: Set.Set (Int, Int) -> ((Int, Int), (Int, Int)) -> Set.Set(Int, Int)
insertRockStructure rocks ((x0, y0), (x1, y1))
    | x1 - x0 /= 0 = foldl insertRock rocks [(i,y0) | i <-[minx..maxx]]
    | otherwise = foldl insertRock rocks [(x0,i) | i <-[miny..maxy]]
    where (minx, maxx) = ((min x0 x1) , (max x0 x1))
          (miny, maxy) = ((min y0 y1) , (max y0 y1))

insertRock :: Set.Set (Int, Int) -> (Int, Int) -> Set.Set (Int, Int)
insertRock rocks rock = Set.insert rock rocks 