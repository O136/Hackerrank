module GlushkovGraphViz where

import Data.List (find)
import Data.Maybe (isJust)
import Glushkov

--TODO : create a new structure for automaton
--given a regex tree and a word, returns whether word is accepted or not
isValid :: RegT -> String -> Bool
isValid t word = isValid' t word [initS]
  where
    isValid' t [] fin = or $ map (\s -> isJust $ find (== s) fin) (acceptS t)
    isValid' t (l:ls) nsts = isValid' t ls nsts'
      where
        nsts' =
          filter
            (\(Letter (_, l')) -> l' == l)
            (concatMap
               (\s ->
                  if s == initS
                    then firstS t
                    else nextS t s)
               nsts)

--(a|b)*a(a|b)
regEx :: RegT
regEx =
  Concat
    ( Star (Or (Letter (0, 'a'), Letter (1, 'b')))
    , Concat (Letter (2, 'a'), Or (Letter (3, 'a'), Letter (4, 'b'))))

--(a)*
regEx2 :: RegT
regEx2 = Star (Letter (0, 'a'))

tran2String :: (RegT, [RegT]) -> [String]
tran2String (s, s') =
  case s of
    Letter (i, _) -> map f s'
      where f =
              \(Letter (i', l')) ->
                show i ++ "->" ++ show i' ++ " [label=" ++ show l' ++ "];"
    _ -> [""]
{-
rankdir=LR;
size="8,5"
node [shape=none,width=0,height=0,margin=0]; start [label=""];
node [shape=doublecircle];
4;5;
node [shape=circle];
-}
