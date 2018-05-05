module GlushkovGraphViz where
import Glushkov
import Data.Maybe (isJust)
import Data.List (find)

--given a regex tree and a word, returns whether word is accepted or not
--it builds the automaton on the fly as needed
automaton :: Node -> String -> Bool
automaton reg word = automaton' reg word [initial] where
  automaton' reg []     acc     = or $ map (\s-> isJust $ find (==s) acc) (accept reg)
  automaton' reg (l:ls) nstates = automaton' reg ls nstates' where
    nstates' = filter (\(Letter(_, l')) -> l' == l)
               (concatMap (\s -> if s == initial then first reg
                                 else next reg s) nstates)

--(a|b)*a(a|b)
reg2 = Concat(Star(Or(Letter (0,'a'), Letter (1, 'b'))),
             Concat(Letter (2, 'a'), Or(Letter (3, 'a'), Letter (4, 'b'))))

tran2String :: (Node, [Node]) -> [String]
tran2String (s, s') = case s of
  Letter(i, l) -> map f s' where
    f = \(Letter(i', l')) -> show i ++ "->" ++ show i' ++ " [label=" ++ show l' ++ "];"
  _ -> [""]

{-
rankdir=LR;
size="8,5"
node [shape=none,width=0,height=0,margin=0]; start [label=""];
node [shape=doublecircle];
4;5;
node [shape=circle];
-}

{-
--with the Berry-Sethi approach, we always have 1 starting state
automaton2 :: Node -> String -> Bool
automaton2 reg word = automaton' reg word (first reg) where
  cmpLetter l = filter (\(Letter(_, l')) -> l' == l) --acc
  automaton' reg []     acc = or $ map (\s-> isJust $ find (==s) acc) (accept reg)
  automaton' reg (l:[]) acc = automaton' reg [] (cmpLetter l acc)
  automaton' reg (l:ls) nstates =
      let nstates' = concatMap (next reg) (cmpLetter l nstates) in
        automaton' reg ls nstates'
-}
