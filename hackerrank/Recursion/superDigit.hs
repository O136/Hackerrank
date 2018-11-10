import Control.Monad

main = do
  [dig, k] <- (map read . words) `liftM` getLine :: IO [Integer]
  print $ superDig (k * (sum $ explode dig))

explode n | n < 10 = [n]
          | otherwise = n `mod` 10 : explode (n `div` 10)

superDig n | n < 10 = n
           | otherwise = superDig (sum $ explode n)


