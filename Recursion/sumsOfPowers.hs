main = do
  x <- readLn :: IO Int --number as a sum of unique digits^n
  n <- readLn :: IO Int
  print $ countSolGiven x n

--finds all solutions for an int x and its pow repr.
find' x pow sol | x < 0 = [] 
                | x == 0 = [sol]
                | otherwise = concatMap helper $ takeWhile (<=x) pow
                   where helper k = find' (x-k) (filter (>k) pow) (k:sol)

countSolGiven x n = length $ find' x (takeWhile (<= x) [p^n | p <- [1..]]) []
