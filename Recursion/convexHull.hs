import Data.List (sortBy, minimumBy)
import Data.Function (on)
import Text.Printf

solve :: [Pt] -> Double
solve = hullPerimeter . gScan

main :: IO ()
main = do
  n <- readLn :: IO Int
  content <- getContents
  let
    points = map (\[x, y] -> (x, y)). map (map (read::String->Double)). map words. lines $ content
    ans = solve points
  printf "%.1f\n" ans

type Pt = (Double, Double)
data Orientation = RTurn | LTurn | CLin deriving (Show, Eq)

orientation p1 p2 p3 | dir > 0 = LTurn
                     | dir < 0 = RTurn
                     | otherwise = CLin where
                        dir = (fst p2 -  fst p1)*(snd p3 - snd p1) - (snd p2 - snd p1)*(fst p3 - fst p1)

euclidDist p1 p2 = sqrt $ (fst p2 - fst p1)^2 + (snd p2 - snd p1)^2

hullPerimeter [] = 0
hullPerimeter ps = helper ps (head ps) where
  helper [p] h = euclidDist h p --computes dist between first and last point in hull
  helper (p:p':ps) h = euclidDist p p' + helper (p':ps) h

gScan :: [Pt] -> [Pt]
gScan pts | length pts >= 3 = scan [pt0] rests
          | otherwise       = pts
  where
        -- Find the most bottom-left point pt0
        pt0 =  minimumBy (\p p' -> if (compare (snd p) (snd p')) == EQ then compare (fst p) (fst p') else compare (snd p) (snd p')) pts
          
          {-foldr bottomLeft (1/0, 1/0) pts where --min pts
            bottomLeft pa pb = case ord of
                               LT -> pa
                               GT -> pb
                               EQ -> pa
                       where ord = (compare `on` (\(x, y) -> (y, x))) pa pb
           -}
        -- Sort other points based on angle
        rests = tail (sortBy (compare `on` compkey pt0) pts) where
            compkey (x0, y0) (x, y) = (atan2 (y - y0) (x - x0), abs (x - x0))

        -- Scan the points to find out convex
        -- -- handle the case that all points are collinear
        scan [p0] (p1:ps) | orientation pz p0 p1 == CLin = [pz, p0] where pz = last ps

        scan (x:xs) (y:z:rsts) = case orientation x y z of
            RTurn -> scan xs (x:z:rsts)
            CLin  -> scan (x:xs) (z:rsts) -- skip collinear points
            LTurn -> scan (y:x:xs) (z:rsts)

        scan xs [z] = z : xs


ls = [(1, 1),(2, 5),(3, 3),(5, 3),(3, 2),(2, 2)]
toDouble ls = map (\(a,b) -> (fromInteger a ::Double,fromInteger b :: Double)) ls
square = toDouble [(1,1),(1,10),(5,10),(5,1),(5,7),(5,8),(5,9),(2,10),(4,1)]
