import System.IO
import Data.List.Split
import Data.List
import Data.Maybe
main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ sum $ map (priorityRuckSack . splitAtHalf) $ splitOn "\n" contents

splitAtHalf rucksack = splitAt (length rucksack `div` 2) rucksack

priorityRuckSack rucksack = priority (head ([ x | x <- fst rucksack, y <- snd rucksack , x == y]))

priority letter =  fromMaybe (-1) (elemIndex letter (['a'..'z'] ++ ['A'..'Z'])) + 1