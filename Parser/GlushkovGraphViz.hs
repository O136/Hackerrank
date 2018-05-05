module GlushkovGraphViz where
import Glushkov

-- first transitions from the -1 start state to its first reachable states
-- either map next (allLeaves), but if a leave is unreachable from -1(start state) ?
-- another signature would be Node -> Node -> [Node] meaning that we return all transitions
-- for a given node/state
transitions :: Node -> [(Node, [Node])]
transitions t =
  let fst  = first t
      fst' = (initial, fst) in
    fst' : map (\leaf -> (leaf, next t leaf)) fst

--transitions' :: Node -> Node -> [Node]
--transitions' t leaf = lookup leaf $ concatMap (next t) (first t)

{-
--with the Berry-Sethi approach, we always have 1 starting state
automaton :: Node -> String -> Bool
automaton _   []   = True
automaton reg (l:ls) =
  let t = transitions s
      next = filter (\Letter(_, l') -> l' == l) t
      last = foldl (\acc s -> automaton reg ls && acc) True next in
    isJust $ lookup last (accept reg)
-}

tran2String :: (Node, [Node]) -> [String]
tran2String (s, s') = case s of
  Letter(i, l) -> map f s' where
    f = \(Letter(i', l')) -> show i ++ "->" ++ show i' ++ " [label=" ++ show l' ++ "];"
  _ -> [""]

--(a|b)*a(a|b)
--later I'll use a zip to index the letters
reg2 = Concat(Star(Or(Letter (0,'a'), Letter (1, 'b'))),
             Concat(Letter (2, 'a'), Or(Letter (3, 'a'), Letter (4, 'b'))))

{-
rankdir=LR;
size="8,5"
node [shape=none,width=0,height=0,margin=0]; start [label=""];
node [shape=doublecircle];
4;5;
node [shape=circle];
-}
