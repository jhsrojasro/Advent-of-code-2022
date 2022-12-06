import System.IO
import Data.List.Split
import Data.List
import qualified Data.Set as Set
import Data.IntMap (fromList)

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    print $ findIndex (\i -> Set.size (Set.fromList $ drop (i - 14) $ take i contents) == 14) [1..length contents-1]
