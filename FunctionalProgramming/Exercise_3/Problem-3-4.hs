--1. Use of foldr and foldl
------------------------------------------

--foldr (:) []
func1 :: [a] -> [a]
func1 [] = []
func1 (x:xs) = x : (func1 xs)


--foldl (*) 1
func2 :: [Int] -> Int
func2 xs = func2' 1 xs
           where
           	  func2' v [] = v
           	  func2' v (y:ys) = func2' (v * y) ys 


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



--2. Define map and reverse using fold functions.
--------------------------------------------------

--myMap :: (a -> b) -> [a] -> [b]
--myMap f [] = []
--myMap f xs = [f x | x <- xs]

myMap :: (a -> b) -> [a] -> [b]
myMap f = foldr (\y ys -> (f y):ys) []


--myReverse :: [a] -> [a]
--myReverse xs = myReverse' [] xs
--               where
--               	  myReverse' ys [] = ys
--               	  myReverse' ys (x:xs) = myReverse' (x:ys) xs



myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) [] 

--foldr is used when we find pure recursive pattern
--foldl is used when we need some accumulator functionto solve the problem
--Other fold functions like foldt, foldi

--3. Then define the functions unzip and nub
--------------------------------------------------
--myUnzip :: [(a, b)] -> ([a], [b])
--myUnzip ((x,y) : []) = ([x],[y])
--myUnzip ((x,y):xys) = (x : (fst (myUnzip xys)), y : (snd (myUnzip xys)))

myUnzip :: [(a,b)] -> ([a], [b])
myUnzip = foldr (\(x,y) xys -> (x : (fst xys), y : (snd xys))) ([],[])

myNub :: Eq a => [a] -> [a]
myNub = foldr (\y ys -> y : (filter (/=y) ys)) []

--In both cases I needed to use foldr because.... I needed calculations something
--like f y1 (f y2 (... (f yk x) ...)) 

