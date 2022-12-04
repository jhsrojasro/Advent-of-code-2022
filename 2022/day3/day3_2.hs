import System.IO
import Data.List.Split
import Data.List
import Data.Maybe
main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ sum $ map priorityRuckSack $ chunksOf 3 $ splitOn "\n" contents

priorityRuckSack rucksack = priority (head ([ x | x <- head rucksack, y <- rucksack !! 1 , z <- rucksack !! 2 , x == y && x == z]))

priority letter =  fromMaybe (-1) (elemIndex letter (['a'..'z'] ++ ['A'..'Z'])) + 1