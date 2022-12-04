import System.IO 
import Data.List.Split

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ maximum [sum [read x :: Int | x <- elve] | elve <- map (splitOn "\n") $ splitOn "\n\n" contents]
    hClose handle