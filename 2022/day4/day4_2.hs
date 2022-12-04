import System.IO
import Data.List.Split
import Data.List

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ length $ filter rangeOverlap ((map (map (splitOn "-") . splitOn ",") . splitOn "\n") contents)

rangeOverlap ranges =  x1 `elem` [y1.. y2] || x2 `elem` [y1..y2] || y1 `elem` [x1..x2] || y2 `elem` [x1..x2]
    where x1 = read (head $ head ranges) :: Int
          x2 = read (last $ head ranges) :: Int
          y1 = read (head $ last ranges) :: Int
          y2 = read (last $ last ranges) :: Int