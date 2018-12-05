sumList :: [Int] -> Int 
sumList [] = 0
sumList (x:xs) = x + sumList xs


sumList2 :: [Int] -> Int
sumList2 = foldr (+) 0


sumList3 :: [Int] -> Int
sumList3 xs = sumList3' xs 0
  where 
    sumList3' [] sum = sum
    sumList3' (y:ys) sum = sumList3' ys (sum+y)


sumList4 :: [Int] -> Int 
sumList4 = foldl (+) 0

--foldr = f x1 + (f x2 + (f x3 + (f x4)))

--foldl = (((f x1) + f x2) + f x3) + f x4)

--foldr (:) [] 

f1 :: [a] -> [a]
f1 [] = []
f1 (x:xs) = x : (f1 xs)

--foldl (*) 1
--foldr (-) 1
func3 :: [Int] -> Int
func3 [] = 1
func3 (x:xs) = x - func3 xs

--foldl (-) 1
func4 :: [Int] -> Int
func4 xs = func4' 1 xs
           where
              func4' v [] = v
              func4' v (y:ys) = func4' (v - y) ys  

myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = (f x) : (myMap f xs)

myMap2 :: (a -> b) -> [a] -> [b]
myMap2 f = foldr (\x xs -> f x : xs) []