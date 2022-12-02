import System.IO 
import Data.List.Split

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    (print . sum) [roundValue round | round <- splitOn "\n" contents ]

roundValue :: String -> Integer
roundValue round = winner (head round) (last round) + resultValue (last round)

winner :: Char ->  Char -> Integer
winner op re
    | (op == 'A' && re == 'X') || (op == 'B' && re == 'Z') || (op == 'C' && re == 'Y') =  3
    | (op == 'A' && re == 'Y') || (op == 'B' && re == 'X') || (op == 'C' && re == 'Z') =  1
    | otherwise = 2

resultValue :: Char -> Integer
resultValue result
    | result == 'X' = 0
    | result == 'Y' = 3
    | otherwise = 6