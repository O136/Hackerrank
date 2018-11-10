import Data.List (partition, delete, sort, sortBy)
import Data.Function (on)
import Text.Printf
--problem with this algorithm is that it returns the points not in order
data Orientation = RTurn | LTurn | CLin deriving (Show, Eq)

solve :: [(Double,Double)] -> Double
solve = hullPerimeter . quickH

main :: IO ()
main = do
  n <- readLn :: IO Int
  content <- getContents
  let
    points = map (\[x, y] -> (x, y)). map (map (read::String->Double)). map words. lines $ content
    ans = solve points
  printf "%.1f\n" ans

orientation p1 p2 p3 | dir > 0 = LTurn
                     | dir < 0 = RTurn
                     | otherwise = CLin where
                        dir = (fst p2 -  fst p1)*(snd p3 - snd p1) - (snd p2 - snd p1)*(fst p3 - fst p1)

minMax [] = error "Empty List"
minMax (x:xs) = mm' x x xs where
  mm' a b [] = (a,b)
  mm' a b (y:ys) = mm' (min a y) (max b y) ys

hullPerimeter [] = 0
hullPerimeter ps = helper ps (head ps) where
  helper [p] h = euclidDist h p --computes dist between first and last point in hull
  helper (p:p':ps) h = euclidDist p p' + helper (p':ps) h


euclidDist p1 p2 = sqrt $ (fst p2 - fst p1)^2 + (snd p2 - snd p1)^2
distPL (x0, y0) (x1,y1) (x2,y2) = abs $ ((x2-x1)*(y1-y0) - (x1-x0)*(y2-y1)) / euclidDist (x1,y1) (x2,y2)

maxDistPL ps p1 p2 = helper ps p1 p2 p1 where
 helper [] _ _ maxP = maxP
 helper (p0:ps) p1 p2 maxP | (distPL p0 p1 p2) > (distPL maxP p1 p2) = helper ps p1 p2 p0
                           | otherwise = helper ps p1 p2 maxP

quickH ps = rests a (a : b: (findH' s1 a b ++ findH' s2 b a)) where
  (a, b)  = minMax ps
  cleanPs = delete a $ delete b ps --maybe don't delete?
  --s1 = points from right side of a b, s2 = points right side of b a
  (s1, s2)= partition ((RTurn==) . orientation a b) cleanPs

findH' [] _ _ = []
findH' sk p q = if distPL c p q < 0.0001 then curRes else c:curRes where
  curRes = findH' s1 p c ++ findH' s2 c q
  c = maxDistPL sk p q
  (s1,s2') = partition ((RTurn==) . orientation p c) sk
  s2 = filter ((RTurn==) . orientation c q) s2'

rests pt0 ps = sortBy (compare `on` compkey pt0) ps where
        compkey (x0, y0) (x, y) = (atan2 (y - y0) (x - x0), abs (x - x0))
