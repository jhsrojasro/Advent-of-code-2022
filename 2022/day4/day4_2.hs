import System.IO
import Data.List.Split
import Data.List

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let ranges = [ [[(read . head . head) ranges :: Int, (read . last . head) ranges :: Int] ,[(read . head . last) ranges :: Int, (read . last . last) ranges :: Int]] | ranges <- (map (map (splitOn "-") . splitOn ",") . splitOn "\n") contents]
    (print . length) [ range | range <- ranges, rangeOverlap ((head . head) range) ((last . head) range) ((head . last) range) ((last . last) range) ]

rangeOverlap x1 x2 y1 y2 =  x1 `elem` [y1.. y2] || x2 `elem` [y1..y2] || y1 `elem` [x1..x2] || y2 `elem` [x1..x2]