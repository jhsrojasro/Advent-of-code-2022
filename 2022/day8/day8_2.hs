import System.IO
import Data.Matrix
import Data.Char
import qualified Data.Vector as Vector

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let input = lines contents
    let n = length input
    let m = length (head input)
    let inputMatrix = matrix n m (\(i,j) -> digitToInt ((input !! (i-1)) !! (j-1)))
    print $ maxScenicScore inputMatrix 1 1 0

maxScenicScore :: Matrix Int -> Int -> Int -> Int -> Int
maxScenicScore inputMatrix i j maxS
    | i == n - 1 && j == m - 1 = max maxS scenic 
    | j == m - 1 = maxScenicScore inputMatrix (i+1) 2 (max maxS scenic)
    | i == 2 || i == n - 1|| j == 2 = maxScenicScore inputMatrix i (j+1) (max maxS scenic)
    | otherwise = maxScenicScore inputMatrix i (j+1) (max maxS scenic)
    where n = nrows inputMatrix
          m = ncols inputMatrix
          scenic = getScenic inputMatrix i j

getScenic :: Matrix Int -> Int -> Int -> Int
getScenic mat i j = 
    let center = getElem i j mat
        up =  countScenic (Vector.reverse $ Vector.take (i-1) $ getCol j mat) center
        down = countScenic (Vector.drop i $ getCol j mat) center
        left =  countScenic (Vector.reverse $ Vector.take (j-1) $ getRow i mat) center
        right =  countScenic (Vector.drop j $ getRow i mat) center
    in up * down * left * right

countScenic :: Vector.Vector Int -> Int -> Int
countScenic vec height =
    let countLower = Vector.length $ Vector.takeWhile (< height) vec
        countLeq = Vector.length $ Vector.takeWhile (<= height) vec
    in countLower + if countLeq /= countLower then 1 else 0
    