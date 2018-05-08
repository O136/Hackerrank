module GlushkovGraphViz where

import Data.List (find, nub)
import Glushkov

--returns the path travelled by the word in the automaton as a list of states
automaton :: RegT -> String -> [[RegT]]
automaton t word = auto' t word [initS]
  where
    auto' t [] _ = []
    auto' t (l:ls) nsts = nsts' : auto' t ls nsts'
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


--need new name
acceptSDFA :: RegT -> [RegT] -> [RegT]
acceptSDFA t states =
  if foldl (\acc s -> acc || any (== s) states) False (lastS t)
    then states
    else []


--print identifier of a state
printS :: [RegT] -> String
printS []                 = ""
printS [Letter (i, _)]    = show i
printS (Letter (i, _):ss) = show i ++ "," ++ printS ss


--print transition between 2 states, how about empty lists ?
printT :: ([RegT], [RegT]) -> String
printT (s, s'@(Letter (_, l):_)) =
  "\"{" ++ printS s ++ "}\"->\"{" ++ printS s' ++ "}\" [label=\"" ++ show l ++ "\"]"
printT _ = ""


--print transitions created by the word
printAutomaton :: RegT -> String -> String
printAutomaton t word =
  let a = automaton t word
      trans = zip ([initS] : a) a
  in "digraph nfa {\n\
     \rankdir=LR; node [shape=none,width=0,height=0,margin=0]; start [label=\"\"];\n\
     \node [shape=doublecircle];"  ++
      show (nub $ (foldl (\acc n -> let x = acceptSDFA t n in
                            if null x
                            then []
                            else (x:acc)) [] a)) ++
     "node [shape=circle];\n" ++
     (foldl (\acc s -> acc ++ printT s ++ "\n") "" trans) ++
     "start->\"{" ++ printS [initS] ++ "}\"\n" ++
     "}"


--(a|b)*a(a|b)
regEx :: RegT
regEx =
  Concat
    ( Star (Or (Letter (0, 'a'), Letter (1, 'b')))
    , Concat (Letter (2, 'a'), Or (Letter (3, 'a'), Letter (4, 'b'))))

--(a)*
regEx2 :: RegT
regEx2 = Star (Letter (0, 'a'))
