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
    let y_ = 2000000
    print $ Set.size $ foldl (pruneSet y_) (foldl (intersectionInRadix y_) Set.empty tuples) (beacons)

manhattanDistance :: Pos -> Pos -> Int
manhattanDistance (Pos x1 y1) (Pos x2 y2) = (abs (x2 - x1)) + (abs (y2 - y1))

pruneSet :: Int -> Set.Set Int ->  Pos -> Set.Set Int
pruneSet y' curSet (Pos x y) = if y' == y then Set.delete x curSet else curSet

intersectionInRadix :: Int -> Set.Set Int -> (Pos , Int) -> Set.Set Int
intersectionInRadix y' curSet ((Pos x y), mDist)
    | y' >= y - mDist && y' <= y + mDist = if y' <= y then setUp else setDown   
    | otherwise = curSet
    where distUp = y' - (y-mDist)
          distDown = (y+mDist) - y'
          setUp = foldl updateSet curSet [x-distUp..x+distUp]
          setDown = foldl updateSet curSet [x-distDown..x+distDown]

updateSet :: Set.Set Int -> Int -> Set.Set Int
updateSet curSet x = Set.insert x curSet
