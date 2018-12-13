
myLast :: [a] -> a
myLast []     = error "No Value"
myLast [x]    = x
myLast (x:xs) = myLast xs



myLastbut :: [a] -> a
myLastbut []     = error "No Value"
myLastbut [x]    = error "No suff value"
myLastbut [x,y]  = x
myLastbut (x:xs) = myLastbut xs

findVal :: [a] -> Int -> a
findVal [] _ = error "No value in the list"
findVal (x:xs) z | z == 0 = x
                 | otherwise = findVal xs (z-1)

compress :: (Eq a) => [a] -> [a]
compress [x]    = [x]
compress [x,y]  = [x,y]
compress (x:y:xs) | x == y    = x:compress xs
                  | otherwise = x:y:compress xs

comp :: (Eq a) => [a] -> [a] 
comp [] = []
comp (x:xs) = x : comp (dropWhile (==x) xs)

func :: [Char] -> [String]

func [] = []
func (x:xs) = ([x] ++ (getAll xs)) : func (dropWhile (==x) xs)
            where
                getAll [] = []
                getAll (y:ys) | y == x = y : (getAll ys)
                              | otherwise = []


encode :: String -> [(Int, Char)]
encode [] = []
encode (x:xs) = (count (x:xs), x) : encode (dropWhile (==x) xs)
                where
                    count [] = 0
                    count (y:ys) | y == x = 1 + count ys
                                | otherwise = 0
--['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']

fullWords :: Int -> String
fullWords 0 = ""
fullWords x = fullWords (x `div` 10) ++ "-" ++  getWord (x `mod` 10) 

getWord :: Int -> String 
getWord 0 = "zero"
getWord 1 = "one"
getWord 2 = "two"
getWord 3 = "three"
getWord 4 = "four"
getWord 5 = "five"
getWord 6 = "six"
getWord 7 = "seven"
getWord 8 = "eight"
getWord 9 = "nine"


n = a `div` length xs
   where
    a = 10
    xs = [1, 2, 3, 4, 5]
