myMerge :: [Int] -> [Bool] -> [(Maybe Int, Maybe Bool)]
myMerge [] [] = []
myMerge [x] [] = [(Just x , Nothing)]
myMerge [] [y] = [(Nothing , Just y)]
myMerge (x:xs) [] = [(Just x,Nothing)] ++ myMerge xs []
myMerge [] (y:ys) = [(Nothing, Just y)] ++ myMerge [] ys
myMerge (x:xs) (y:ys) = [(Just x, Just y)] ++ myMerge xs ys