import System.IO
import Data.List.Split
import Data.List
import Data.List.Unique
import qualified Data.Set as Set
import qualified Data.Map as Map
import Data.List.Utils (replace)
import Data.Maybe

type Tree = Map.Map String ([String], Int)
data State = State Tree String

main = do 
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let mapita = (\(State mapita _) -> mapita)$ foldl buildTree (State Map.empty "") (lines contents)
    let total_size = getSize (State mapita "/")
    print $ minimum $ [ x | x <- [getSize (State mapita dir) | dir <- (Map.keys mapita), fst (fromMaybe ([],-1) $ Map.lookup dir mapita) /= [] ], (70000000 - total_size) + x >= 30000000]

buildTree :: State -> String -> State
buildTree (State children path) line
    | command7 == "$ cd .." = State children parent
    | command == "$ cd" = State children path'
    | command == "$ ls" = State (Map.insert path ([], -1) children) path
    | command == "dir " = State children' path
    | otherwise = State (Map.insert (path++optionalSlash++fileName) ([], size) children') path
    where command7 = take 7 line
          command = take 4 line
          dirName = drop 5 $ line
          parent = ("/"++ intercalate "/" (tail $ init $ splitOn "/" path))
          currentChildren = fst (fromMaybe ([],-1) $ Map.lookup path children)
          currentChildren' = currentChildren ++ [path_s ++ last (words $ line)]
          optionalSlash = (if dirName == "/" || last path == '/' then "" else "/")
          path_s = path ++ optionalSlash
          path' = path_s++ dirName
          children' = (Map.insert path (currentChildren', -1) children)
          size = read (head $ words $ line) :: Int
          fileName = last $ words $ line

getSize :: State -> Int
getSize (State tree node)
    | size == -1 = sum [getSize (State tree child) | child <- children]
    | otherwise = size
    where (children, size) =  (fromMaybe ([],-1) $ Map.lookup node tree)