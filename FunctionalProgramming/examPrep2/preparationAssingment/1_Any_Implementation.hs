
--i) An implementation with recursion
anyRecursion :: (a -> Bool) -> [a] -> Bool
anyRecursion p []                 = False
anyRecursion p (x:xs) = p x || (anyRecursion p xs)

--ii) An implementation with a fold function.
--foldr :: (a -> Bool -> Bool) -> Bool -> [a] -> Bool

anyFold :: (a -> Bool) -> [a] -> Bool
anyFold p xs = foldr (\x y -> p x || y) False xs



--iii) An implementation using a list comprehension and not, null and ()
anyListComprehension :: (a -> Bool) -> [a] -> Bool
anyListComprehension p xs = not (null [y | y <- xs, p y])

--iv) Type Signature
--any :: (a -> Bool) -> [a] -> Bool 


isSquare :: Integer -> Bool
isSquare n = anyRecursion (< (n `div` 2)) [x | x <- [2..(n`div`2)], x*x == n]



