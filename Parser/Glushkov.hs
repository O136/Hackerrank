module Glushkov where
import Prelude hiding (last)

--If we see epsilon in regex pattern it will be Letter (_, 'eps')
data Node = Epsilon | Letter (Int, Char) | Star Node | Concat(Node, Node) | Or(Node, Node) deriving (Show, Eq)
initial = Letter (-1, '&')

empty :: Node -> Bool
empty e = case e of
  Concat(l, r) -> empty l && empty r
  Or(l, r) -> empty l || empty r
  Letter _ -> False
  _ -> True

--returns all the states that can be reached from the initial state
first :: Node -> [Node]
first e = case e of
  Or(r1, r2) -> first r1 ++ first r2
  Concat(r1, r2) -> if empty r1 then first r1 ++ first r2 else first r1
  x@(Letter _) -> [x]
  Star r1 -> first r1
  Epsilon -> []

--returns the next possible states for a particular leaf
next :: Node -> Node -> [Node]
next e leaf = next e leaf [] where
  next e leaf acc = case e of
    Concat(r1, r2) -> next r1 leaf (r1') ++ next r2 leaf acc where
      r1' = if empty r2 then first r2 ++ acc else first r2
    Or(r1, r2) -> next r1 leaf acc ++ next r2 leaf acc
    Star r1 -> next r1 leaf (first r1 ++ acc)
    x@(Letter _) -> if leaf == x then acc else []
    Epsilon -> []

--returns all the states which are accept states
last :: Node -> [Node]
last e = case e of
  Concat(r1, r2) -> if empty r2 then last r1 ++ last r2 else last r2
  Or(r1, r2) -> last r1 ++ last r2
  Star r1 -> last r1
  x@(Letter _) -> [x]
  Epsilon -> []

accept :: Node -> [Node]
accept t = if not (empty t) then last t else initial : last t

--2 possibilites for the signature of next
--next :: Node -> (Letter Char) -> [Node] or next :: Node -> [(Node, [Node])] (generally more efficient)
--1st one will take the tree and the leaf for which the next states/nodes will be returned
--2nd one will take the tree and will return (stateX, [states reachable from stateX])
