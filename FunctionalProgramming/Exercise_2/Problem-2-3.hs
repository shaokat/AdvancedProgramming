merge :: [a] -> [a] -> [a]

merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) =  x : y : merge xs ys


intersperse :: a -> [a] -> [a]
intersperse n [] = error "It's not possible to Intersperse"
intersperse n (x:[]) = [x] 
intersperse n (x:xs) = x:n:intersperse n xs


splitAt2 :: Int -> [a] -> ([a], [a])
splitAt2 0 xs = ([], xs)
splitAt2 n [] = ([], [])
splitAt2 n (x:xs) = 
    let
      gotPair = splitAt2 (n-1) xs
    in
    (x:fst gotPair, snd gotPair)


--data Either a b = Left a | Right b

extractLefts :: [Either Int Bool] -> [Int]
extractLefts [] = []
extractLefts (Right x : others) = extractLefts others
extractLefts (Left x : others) = [x] ++ extractLefts others   
