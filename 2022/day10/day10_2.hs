import System.IO

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ processCycle [] "" 1 1 False $ lines contents

processCycle :: [String] -> String -> Int -> Int -> Bool -> [String] -> [String]
processCycle answer curString spritePos cycle addx [] = answer
processCycle answer curString spritePos cycle addx (x:xs)
    | cycle >= 240 = answer'
    | op == "addx" && mod40 == 0 = processCycle answer' "" spritePos' (cycle+1) addx' remaining
    | mod40 == 0 = processCycle answer' "" spritePos' (cycle+1) False xs
    | op == "addx" = processCycle answer' curString' spritePos' (cycle+1) addx' remaining
    | otherwise = processCycle answer' curString' spritePos' (cycle+1) False xs  
    where mod40 = cycle `mod` 40
          op = head $ words x
          val = read (last $ words x) :: Int
          addx' = (if addx then False else True)
          curString' = curString ++ [character]
          remaining = if addx then xs else (x:xs)
          character =  if abs (mod40 - 1  - spritePos) <= 1 then '#' else '.'
          answer' = if mod40 == 0 then answer ++ [curString'] else answer
          spritePos' = if addx then spritePos + val else spritePos