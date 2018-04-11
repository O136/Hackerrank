import qualified Data.IntMap.Strict as M
import Control.Monad

main = do
  t <- readLn :: IO Int
  forM_ [1..t] (\_ -> do
    p <- readLn :: IO Int
    pLs <- replicateM p readInts
    putStrLn $ isFunction (list2Tuple pLs) M.empty)

readInts = (map read . words) `liftM` getLine :: IO [Int]
list2Tuple = concatMap (\(a:a':_) -> [(a, a')])

isFunction [] _ = "YES"
isFunction ((i, o):xs) m = case (M.lookup i m) of
  Just o' -> if o' == o then isFunction xs m else "NO"
  Nothing -> isFunction xs (M.insert i o m)

