import System.IO
import Data.Matrix
import Data.Maybe


data Pos = Pos Int Int deriving(Show)
data State = State (Matrix Char) Pos deriving(Show)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let input = lines contents
    let n = length input
    let m = length (head input)
    let inputMatrix = matrix n m (\(i,j) ->  (input !! (i-1)) !! (j-1))
    let startPos = fromMaybe (Pos (-1) (-1) ) (findInMatrix inputMatrix 'S' (Pos 1 1))
    let endPos = fromMaybe (Pos (-1) (-1) ) (findInMatrix inputMatrix 'E' (Pos 1 1))
    print $ endPos

findCharInMatrix :: Matrix Char -> Char-> Pos -> Maybe Pos
findCharInMatrix matrix c (Pos i j)
    | element == c = Just (Pos i j)
    | i == n && j == m = Nothing
    | j == m = findInMatrix matrix c (Pos (i+1) 1)
    | otherwise = findInMatrix matrix c (Pos i (j+1))
    where n = nrows matrix
          m = ncols matrix
          element = getElem i j matrix



