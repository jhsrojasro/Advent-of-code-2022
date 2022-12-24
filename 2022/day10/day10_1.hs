import System.IO

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ processCycle 0 1 False 1 $ lines contents

processCycle :: Int -> Int -> Bool -> Int -> [String] -> Int
processCycle cur_sum cur_value addx i [] = cur_sum
processCycle cur_sum cur_value addx i (x:xs)
    | i == 220 = cur_sum' 
    | op == "addx" = processCycle cur_sum' cur_value' addx' (i+1) remaining
    | otherwise = processCycle cur_sum' cur_value addx (i+1) xs
    where op = head $ words x
          val = read (last $ words x) :: Int
          addx' = (if addx then False else True) 
          remaining = if addx then xs else (x:xs)
          cur_sum' =  (if (i - 20) `mod` 40 == 0 then cur_sum + i * cur_value else cur_sum) 
          cur_value' = if addx then cur_value + val else cur_value