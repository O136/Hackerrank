-- idea  : with [1,2,3,4] as example
-- map []: with subs [1,2,3,4]= [1,2,3,4]
-- map  1: with subs [2,3,4]  = 1:[], 1:2:3, 1:2:4, 1:3:4
-- map  2: with subs [3, 4]   = 2:[], 2:3, 2:4,
-- map  3: with subs [4]      = 3:[], 3:4
-- map  4: with subs []       = 4:[]

--subs (x:xs) = map (x:) (subs xs) ++ subs xs, ++ in order to collect the previous results
--but xs could be precomputed

--dwt : user -> dwt18 , pw -> laplace

subs [] = [[]]
subs (x:xs) = map (x:) subs' ++ subs' where subs' = subs xs

--idea : with x [1,2,3,4]
-- [x,1,2,3,4]
-- [1,x,2,3,4] ...
-- [1,2,3,4,x1]
interleave el [] = [[el]]
interleave el (x:xs) = (el:x:xs) : map (x:) (interleave el xs)

--idead : with [1,2,3]
-- interleave 1 subs [2,3 ]
  -- interleave 2 subs [3]
   -- interleave 3 subs [[]]
  -- interleave 2 [[3]] = [[2,3], [3,2]]
-- interleave 1 [[2,3], [3,2]] = [[1,2,3],[2,1,3],[2,3,1], [[1,3,2],[3,1,2],[3,2,1]]]
perms [] = [[]]
perms (x:xs) = concatMap (interleave x) (perms xs)

selOrder0OrMore = concatMap perms . subs
