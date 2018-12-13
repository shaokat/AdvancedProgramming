--Write a function rotabc that changes a's to b's, b's to c's and c's to a's 
--in a string. Only lowercase letters are affected.

rotabc :: String -> String 
rotabc [] = []
rotabc (x:xs) | x == 'a'  = 'b' : rotabc xs
              | x == 'b'  = 'c' : rotabc xs
              | x == 'c'  = 'a' : rotabc xs
              | otherwise = x : rotabc xs
fml :: [a] -> (a,a,a)
fml xs | length xs < 3 = error "Not enough values"
       | otherwise = ( (head xs), (xs !! (length xs `div` 2) ),  (last xs)) 


separate :: String -> (String, String)
separate sen = doIt sen ([],[])
            where
                doIt [] (str1, str2) = (str1, str2)
                doIt (x:xs) (str1, str2) | isDigit x = doIt xs (str1 ++ [x], str2) 
                                         | otherwise = doIt xs (str1, str2 ++ [x]) 
isDigit :: Char -> Bool
isDigit x = x >= '0' && x <= '9'

--Implement map in terms of a fold.

myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = f x : myMap f xs

myMap2 :: (a -> b) -> [a] -> [b]
myMap2 f xs = foldr (\p q -> f p : q) [] xs

mySum :: [Int] -> Int 
mySum [] = 0
mySum (x:xs) = x + mySum xs 

mySum2 :: [Int] -> Int 
mySum2 xs = foldr (\p q -> p + q) 0 xs

--foldr :: (a -> b -> b) -> b -> [a] -> b

--count how many True is available in e [Bool]
--folr (Bool -> Int -> Int) -> Int -> [Bool] -> Int 

--foldr :: (a -> b -> b) -> b -> [a] -> b

countBools :: [Bool] -> Int 
countBools xs = foldr (\x y -> if x == True then 1 + y else y) 0 xs


 composit:: (b -> c) -> (a -> b) -> a -> c 
 composit f g x = f ( g x )




