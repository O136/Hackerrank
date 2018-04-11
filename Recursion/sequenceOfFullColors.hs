import Data.Array
import Control.Monad

main = do
  t <- readLn :: IO Int
  forM_ [1..t] (\_ -> do
    b <- getLine :: IO [Char]
    print $ collect b (array (1, 4) $ zip [1..4] $ replicate 4 0))

ch2Int 'R' = 1; ch2Int 'G' = 2; ch2Int 'Y' = 3; ch2Int 'B' = 4

maxDiff b b' n arr = abs ((!) arr (ch2Int b) - (!) arr (ch2Int b')) <= n

collect [] arr = maxDiff 'R' 'G' 0 arr && maxDiff 'B' 'Y' 0 arr
collect (x:xs) arr = if not (maxDiff 'R' 'G' 1 arr || maxDiff 'B' 'Y' 1 arr) then False else collect xs arr'
  where inc  = 1 + (!) arr pos
        pos  = ch2Int x
        arr' = (//) arr [(pos, inc)]
