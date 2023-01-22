import System.IO
import Data.List.Split
import Data.List
import Data.Maybe
import Data.HashMap

data Info = Info [Int] [[Int]] -- Flow values for each valve and Transitions between valsves.
data State = State Int Int Int [Int] deriving(Hashable)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let input = map words $ lines contents
    let flows = map (read::String->Int) (map (head . (map init) . tail . splitOn "=" . last . take 5) input)
    let valves_name =  map (last . take 2) input
    let get_ind str = fromJust $ findIndex (== str)  valves_name
    let transitions = map (map (get_ind . (\x -> if last x == ',' then init x else x )) . drop 9) input
    -- print $ booleanMaskSum [1,2] [True, True]
    -- [0,13,2,20,3,0,0,22,0,21]
    print $ completeSearch (Info flows transitions) 1 0 [] 0
    
completeSearch :: Info -> Int -> Int -> [Int] -> Int -> Int
completeSearch (Info flows _)  5 _ opened sum = sum + openedValvesSum flows opened
completeSearch (Info flows transitions) minute current opened sum =
    let currentIsNotOpened = not (current `elem` opened)
        flowIsNotZero = (flows !! current) /= 0
        minute' = minute + 1
        sum' = sum + openedValvesSum flows opened
        info = (Info flows transitions)
        openCurrentValve = if currentIsNotOpened && flowIsNotZero then completeSearch info minute' current (opened++[current]) sum' else -1
        moveToValves = maximum ([completeSearch info minute' nextValve opened sum' | nextValve <- (transitions !! current)])
    in max openCurrentValve moveToValves

openedValvesSum::[Int] -> [Int] -> Int
openedValvesSum flows [] = 0
openedValvesSum flows (valve_opened : valves_opened) = (flows !! valve_opened) + openedValvesSum flows valves_opened