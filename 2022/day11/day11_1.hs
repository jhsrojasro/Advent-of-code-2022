import System.IO
import Data.List.Split
import Data.String.Utils
import Data.Char

data MonkeyInfo = MonkeyInfo Int String Int Int Int deriving(Show) --(Id of Monkey) (test: divisible by) (index of monkey to throw if true) (index of monkey throw if false)
data Monkey = Monkey [Int] MonkeyInfo Int deriving(Show)-- (List of current items) (MonkeyInfo readed from input) (Count of inspectioned items)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let monkeys = map getMonkey $ splitOn "\n\n" contents
    print $ monkeyRound monkeys

monkeyRound :: [Monkey] -> [Monkey]
monkeyRound monkeys = foldl monkeyTurn monkeys monkeys

monkeyTurn :: [Monkey] -> Monkey -> [Monkey]
monkeyTurn monkeys (Monkey curList mInfo count)  = 
    let monkey' = Monkey [] mInfo count
        MonkeyInfo curMonkeyIndex _ _ _ _ = mInfo
        monkeys' = replaceMonkey monkeys monkey' curMonkeyIndex  
    in foldl monkeyTurnItem monkeys' [(monkey', item) | item <- curList]  

monkeyTurnItem :: [Monkey] -> (Monkey, Int) -> [Monkey]
monkeyTurnItem monkeys ((Monkey curList (MonkeyInfo monkeyIndex exp test ifTrue ifFalse) count), item) =
    let item' = (monkeyExpression exp item ) `div` 3
        currentMonkey = Monkey curList (MonkeyInfo monkeyIndex exp test ifTrue ifFalse) (count+1)
        testResultIndex = (if (mod item' test) == 0 then ifTrue else ifFalse)
        (oldList, receptorInfo, receptorCount) = (\(Monkey list mInfo mCount) -> (list, mInfo, mCount)) $ monkeys !! testResultIndex
        monkeyReceptor = Monkey (oldList ++ [item'])  receptorInfo receptorCount
        monkeys' = replaceMonkey monkeys currentMonkey monkeyIndex
    in replaceMonkey monkeys' monkeyReceptor testResultIndex

monkeyExpression :: String -> Int -> Int
monkeyExpression exp x
    | op == "+" = firstOperand + secondOperand
    | otherwise = firstOperand * secondOperand
    where f = head $ words exp
          s = last $ words exp 
          op = (words exp) !! 1
          firstOperand = if (f) == "old" then x else read f :: Int
          secondOperand = if (s) == "old" then x else read s :: Int

replaceMonkey :: [Monkey] -> Monkey -> Int -> [Monkey]
replaceMonkey monkeys newMonkey index = [if i == index then newMonkey else monkeys !! i | i <- [0..(length monkeys -1)]]

getMonkey :: String -> Monkey
getMonkey monkeyString = 
    let l = lines $ monkeyString
        items = [read x :: Int | x <- (map strip $ splitOn "," $ last $ splitOn":" $ l !! 1)]
        test = read (last $ words $ (l) !! 3) :: Int
        throwIfTrue = digitToInt $ last $ l !! 4
        throwIfFalse = digitToInt $ last $ l !! 5
        id = digitToInt $ last $ head $ splitOn ":" monkeyString
        exp = strip $ last $ splitOn "=" $ l !! 2
    in Monkey items (MonkeyInfo id exp test throwIfTrue throwIfFalse) 0