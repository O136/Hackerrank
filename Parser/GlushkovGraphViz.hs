module GlushkovGraphViz where
import Glushkov

--actually this fucker should return list of triples (state, char ,state')
-- first transitions from the -1 start state to its first reachable states
-- either map next (allLeaves), but if a leave is unreachable from -1(start state) ?
transitions :: Node -> [[Node]]
transitions t =
  let fst = first t
      start = initial : fst in
    start : map (next t) fst

--(a|b)*a(a|b)
reg2 = Concat(Star(Or(Letter (0,'a'), Letter (1, 'b'))),
             Concat(Letter (2, 'a'), Or(Letter (3, 'a'), Letter (4, 'b'))))
