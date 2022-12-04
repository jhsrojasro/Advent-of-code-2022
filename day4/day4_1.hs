import System.IO
import Data.List.Split
import Data.List

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let ranges = [ [[(read . head . head) ranges :: Int, (read . last . head) ranges :: Int] ,[(read . head . last) ranges :: Int, (read . last . last) ranges :: Int]] | ranges <- (map (map (splitOn "-") . splitOn ",") . splitOn "\n") contents]
    (print . length) [ range | range <- ranges, rangeOverlap range]

rangeOverlap ranges = (head . head) ranges `elem` [(head . last) ranges .. (last . last) ranges] || (last . head) ranges `elem` [(head . last) ranges .. (last . last) ranges]
                    || (head . last) ranges `elem` [(head . head) ranges .. (last . head) ranges] || (last . last) ranges `elem` [(head . head) ranges .. (last . head) ranges]