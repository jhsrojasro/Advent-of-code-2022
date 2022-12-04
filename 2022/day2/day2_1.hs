import System.IO 
import Data.List.Split

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ sum [roundValue round | round <- splitOn "\n" contents ]

roundValue :: String -> Integer
roundValue round = winner (head round) (last round) + selection (last round)

winner :: Char ->  Char -> Integer
winner opponent me 
    | (opponent == 'A' && me == 'Z') || (opponent == 'B' && me == 'X') || (opponent == 'C' && me == 'Y') = 0
    | (opponent == 'A' && me == 'X' ) || (opponent == 'B' && me == 'Y') || (opponent == 'C' && me == 'Z') = 3
    | otherwise = 6

selection :: Char -> Integer
selection me
    | me == 'X' = 1
    | me == 'Y' = 2
    | otherwise = 3 