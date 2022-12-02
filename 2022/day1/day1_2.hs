import System.IO 
import Data.List.Split
import Data.List

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    (print . sum . take 3 . reverse . sort ) [sum [read x :: Int | x <- elve] | elve <- map (splitOn "\n") (splitOn "\n\n" contents)]
    hClose handle