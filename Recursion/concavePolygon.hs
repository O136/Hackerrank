import Data.Function (on)
import Data.List (sortBy, minimumBy)

main = do
  _ <- readLn :: IO Int
  content <- getContents
  let points = map (\[x, y] -> (x, y)). map (map (read::String->Double)). map words. lines $ content
  putStrLn $ isConcave points

data Orientation = LTurn | RTurn | CLin deriving (Show, Eq)

orientation p1 p2 p3 | dir > 0   = LTurn
                     | dir < 0   = RTurn
                     | otherwise = CLin where
                        dir = (fst p2 -  fst p1)*(snd p3 - snd p1) - (snd p2 - snd p1)*(fst p3 - fst p1)

sortPointsGiven pt0 ps = sortBy (compare `on` compkey pt0) ps where
  compkey (x0, y0) (x, y) = (atan2 (y - y0) (x - x0), abs (x - x0))

isConcave ps = helper $ tail (sortPointsGiven lowP ps)  where
  --take lowest by y and by x point
  lowP = minimumBy (\p p'-> if ord p p' == EQ then compare (fst p) (fst p') else ord p p') ps where
    ord = (compare `on` (\(x,y) -> (y,x)))

  helper (p0:p1:p2:ps) = if orientation p0 p1 p2 == RTurn then "YES" else isConcave (p1:p2:ps)
  helper _ = "NO"
 
