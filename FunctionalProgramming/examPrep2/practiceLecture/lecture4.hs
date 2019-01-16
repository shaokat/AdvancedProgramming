type Array a = Int -> a

putArray :: Array a -> Int -> a -> Array a
putArray arr indx val = \x -> if x == indx then val else arr indx

getArray :: Array a -> Int -> a 
getArray arr i = arr i


data T a = L a | (T a) :+: (T a)

foldrImpl :: (a -> b -> b) -> b -> [a] -> b
foldrImpl f b [] = b
foldrImpl f b (x:xs) = f x (foldrImpl f b xs)


myZip :: [a] -> [b] -> [(a,b)]
myZip [] [] = []
myZip []  _ = []
myZip  _ [] = []
myZip (x:xs) (y:ys) = (x,y) : (myZip xs ys)


myUnzip :: [(a,b)] -> ([a], [b])
myUnzip [] = ([], [])
myUnzip ((x,y):xys) = let 
                         (fs, sn) = myUnzip xys
                       in ( x : fs, y : sn )
