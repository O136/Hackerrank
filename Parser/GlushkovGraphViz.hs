module GlushkovGraphViz where

import Data.List (find, nub)
import Glushkov

type StateOfStates = [RegT]

--TODO: maybe check first if the word is valid and only then return a path ?
--returns the path travelled by the word in the automaton as a list of states
automatonPath :: RegT -> String -> [StateOfStates]
automatonPath t word = [initS] : path t word [initS]
  where
    path t [] _ = []
    path t (l:ls) nextStates = nextStates' : (path t ls nextStates')
      where
        nextStates' =
          filter
            (\(Letter (_, l')) -> l' == l)
            (concatMap
               (\s ->
                  if s == initS
                    then firstS t
                    else nextS t s)
               nextStates)

--returns itself if the StateOfStates is qualified as an accept state
--TODO: returning a Maybe StateOfStates only made code uglier
maybeAcceptS :: RegT -> StateOfStates -> StateOfStates
maybeAcceptS t sOfs =
  if or (map (\trueAcceptS -> elem trueAcceptS sOfs) $ acceptS t)
    then sOfs
    else []

--identifier of a state/(letter leaf)
state2Str :: StateOfStates -> String
state2Str state =
  "\"{" ++ tail $ concatMap (\(Letter (i, _)) -> ',' : show i ++ "}\"") state

trans2Str :: (StateOfStates, StateOfStates) -> String
trans2Str (s, s'@(Letter (_, l):_)) =
  state2Str s ++ "->" ++ state2Str s' ++ " [label=\"" ++ show l ++ "\"]"
trans2Str _ = ""

--given a word it creates the repr. for a graphViz automaton
graphVizAutomaton :: RegT -> String -> String
graphVizAutomaton t word =
  let path = automatonPath t word
      trans = nub $ zip path (tail path) --extract unique "edges"
  in "\ndigraph nfa {\n\
      \rankdir=LR; node [shape=none,width=0,height=0,margin=0]; start [label=\"\"];\n\
      \node [shape=doublecircle];\n" ++
     concatMap ((++ "\n") . state2Str) (nub (maybeAcceptS t <$> path)) ++
     "node [shape=circle];\n" ++
     concatMap ((++ "\n") . trans2Str) trans ++
     "start->" ++ state2Str [initS] ++ "\n}"

--(a|b)*a(a|b)
regEx :: RegT
regEx =
  Concat
    ( Star (Or (Letter (0, 'a'), Letter (1, 'b')))
    , Concat (Letter (2, 'a'), Or (Letter (3, 'a'), Letter (4, 'b'))))

--(a)*
regEx2 :: RegT
regEx2 = Star (Letter (0, 'a'))
