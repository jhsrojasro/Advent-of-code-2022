import System.IO
import Data.List.Split
import Data.List

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ length $ filter rangeContained ((map (map (splitOn "-") . splitOn ",") . splitOn "\n") contents)

rangeContained :: [[String]] -> Bool
rangeContained ranges = x1 >= y1 && x2 <= y2 || y1 >= x1 && y2 <= x2 
    where x1 = read (head $ head ranges) :: Int
          x2 = read (last $ head ranges) :: Int
          y1 = read (head $ last ranges) :: Int
          y2 = read (last $ last ranges) :: Int