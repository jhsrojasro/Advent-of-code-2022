import System.IO
import Data.List.Split
import Data.List
import Data.String.Utils

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let initial_state = map (map (chunksOf 4) . splitOn "\n") (init $ splitOn "\n"  $ head $ splitOn "\n\n" contents)
    let stacks = map strip $ transpose [ [selectIdentifier chunk |  chunks <- stack, chunk <- chunks] | stack <- initial_state ]
    let moves =  [ [read (move!!1) :: Int , (read (move!!3) :: Int) -1 , (read (move!!5) :: Int) -1] | move <- map (splitOn " ") $ splitOn "\n" $ last $ splitOn "\n\n" contents]
    print $ head $ transpose $ foldl updateStacks stacks moves

selectIdentifier :: String -> Char
selectIdentifier string = if head string == '[' then head $ tail string else ' '

updateStacks :: [String] -> [Int] -> [String]
updateStacks stacks move = [ selectStack stacks move i | i <- [0..length stacks-1]]

selectStack :: [String] -> [Int] -> Int -> String
selectStack stacks move i
    | i == (move !! 1) = head stacksMoved
    | i == (move !! 2) = last stacksMoved
    | otherwise = stacks !! i
    where stacksMoved = processMove (stacks !! (move !! 1)) (stacks !! (move !! 2)) (head move)

processMove :: String -> String ->  Int -> [String]
processMove stack1 stack2 n = [drop n stack1, reverse (take n stack1) ++ stack2]