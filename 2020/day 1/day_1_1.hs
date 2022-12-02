import System.IO
import Control.Monad

f :: [String] -> [Int]
f = map read


readInput path = do 
    let input = []
    handle <- openFile path ReadMode
    contents <- hGetContents handle
    let singlewords = words contents
        input = f singlewords
    print input
    hClose handle
    return input

day1_1 input = do
    --let input = readInput "../input_1.txt"
    print [x * y | x <- input, y <- input , x + y == 2020 ]