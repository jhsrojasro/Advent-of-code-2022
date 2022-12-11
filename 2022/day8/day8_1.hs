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
    print $ visibleTrees inputMatrix 1 1 0

visibleTrees :: Matrix Int -> Int -> Int -> Int -> Int
visibleTrees inputMatrix i j sum
    | i == n && j == m = sum + 1
    | j == m = visibleTrees inputMatrix (i+1) 1 (sum+1)
    | i == 1 || i == n || j == 1 = visibleTrees inputMatrix i (j+1) (sum+1)
    | otherwise = visibleTrees inputMatrix i (j+1) (sum + visible)
    where n = nrows inputMatrix
          m = ncols inputMatrix
          visible = if isVisible inputMatrix i j then 1 else 0

isVisible :: Matrix Int -> Int -> Int -> Bool
isVisible mat i j = 
    let up =  Vector.all (< center) $ Vector.take (i-1) $ getCol j mat
        down = Vector.all (< center) $ Vector.drop i $ getCol j mat
        center = getElem i j mat
        left = Vector.all (< center) $ Vector.take (j-1) $ getRow i mat
        right = Vector.all (< center) $ Vector.drop j $ getRow i mat
    in up || down || left || right