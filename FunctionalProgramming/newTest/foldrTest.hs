myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myLength2 :: [a] -> Int
myLength2 xs = foldr(\_ ys -> 1 + ys) 0 xs
--myLength2 xs = foldl(\ys _ -> ys + 1) 0 xs

--myLength2 = foldl(1 + const) 0