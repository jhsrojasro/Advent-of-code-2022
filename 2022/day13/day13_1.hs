import System.IO
import Data.List.Split


main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let primerPar = head $ map lines $ splitOn "\n\n" contents
    print $ compareList' "1" (last primerPar)

compareList :: String -> String -> Bool
compareList [] [] = True 
compareList [] (y:ys) = True
compareList (x:xs) [] = False
compareList ('[':xs) ('[':ys) = compareList (init xs) (init ys) 
compareList ('[':xs) (y:ys) = compareList ('[':xs) ("["++(y:ys)++"]")
compareList (x:xs) ('[':ys) = compareList ("["++(x:xs)++"]") ('[':ys)
-- compareList (x:xs) (x:xs) = if 

compareList' :: String -> String -> String
compareList' [] s2 = "True"
compareList' [x] s2 = "["++[x]++"]"
compareList' ('[':x:',':xs) s2 = xs
compareList' (x:xs) s2 = xs