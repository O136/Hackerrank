import Data.List (sortBy, minimumBy)
import Data.Function (on)
import Control.Monad

main = do
  t <- readLn :: IO Int
  forM_ [1..t] (\_ -> do
    [_, f] <- readInts
    ns <- readInts
    putStrLn $ list2String $ (takeByFreq f $ groupSorted $ processInput ns))

list2String = unwords . map show
readInts = (map read . words) `liftM` getLine :: IO [Int]

processInput x = sortBy (compare `on` fst) $ zip x [1..length x]

groupSorted [] = []
groupSorted (x:xs) = (fst $ head m, length m, snd $ minimumBy (compare `on` snd) m) :
  groupSorted r where (m, r) = span ((fst x ==) . fst) (x:xs)

check x = if x == [] then [-1] else x

fst' (x,_,_) = x --(el, elFreq, elInitPos)
snd' (_,x,_) = x
thd' (_,_,x) = x

takeByFreq n x = check $ map fst' (sortBy (compare `on` thd') $ filter ((n <=) . snd') x)
