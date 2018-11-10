-- n >= 2, if n == 1 it won't work
powerSum :: Int -> Int -> Int
powerSum x n = power x n 1 where
  power x n cur | cur^n < x = power x n (cur+1) + power (x-cur^n) n (cur+1)
                | cur^n == x = 1
                | otherwise = 0

