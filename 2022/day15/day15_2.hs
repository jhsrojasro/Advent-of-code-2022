import System.IO
import Data.List.Split
import qualified Data.Set as Set


data Pos = Pos Int Int deriving(Show)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let input = map ( map (map ((\x -> read x:: Int) . tail . dropWhile (/='='))) . map (splitOn ",") . splitOn ":") $ lines contents
    let beacons = [(Pos (head $ last line) (last $ last line)) | line <- input ]
    let sensors = [(Pos (head $ head line) (last $ head line)) | line <- input ]
    let tuples = [((Pos (head $ head line) (last $ head line)), manhattanDistance (Pos (head $ head line) (last $ head line)) (Pos (head $ last line) (last $ last line))) | line <- input ]
    let y_ = 0
    let n = 20
    print $ getX n 0 tuples

getX :: Int -> Int -> [(Pos, Int)] -> Int
getX n y' tuples
    | (Set.size set') < n = Set.difference (Set.fromList [0..n]) set'
    | otherwise = getX n (y'+1) tuples
    where set' = foldl1 Set.union [intersectionInY y' n (pos , mDist) | (pos, mDist) <- tuples ]

manhattanDistance :: Pos -> Pos -> Int
manhattanDistance (Pos x1 y1) (Pos x2 y2) = (abs (x2 - x1)) + (abs (y2 - y1))

pruneSet :: Int -> Set.Set Int ->  Pos -> Set.Set Int
pruneSet y' curSet (Pos x y) = if y' == y then Set.delete x curSet else curSet

intersectionInY :: Int -> Int -> (Pos , Int) -> Set.Set Int
intersectionInY y' n ((Pos x y), mDist)
    | y' >= y - mDist && y' <= y + mDist = set'
    | otherwise = Set.empty
    where dist = if y' <= y then y' - (y-mDist) else (y+mDist) - y'
          set' = Set.fromList [max 0 (x-dist)..min n (x+dist)]

updateSet :: Set.Set Int -> Int -> Set.Set Int
updateSet curSet x = Set.insert x curSet
