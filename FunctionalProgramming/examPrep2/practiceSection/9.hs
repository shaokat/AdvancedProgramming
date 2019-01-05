--1. Using a list comprehension, give an expression that calculates the sum
--12 + 22 +
--1002 of the first one hundred integer square

--foldr (+) 0 [x*x |x <- [1..100]]

myReplecate :: Int -> a -> [a]
myReplecate n m = [ m | y <-[1..n]]


pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], (x*x) + (y*y) == (z*z)]


myFac :: Int -> [Int]
myFac x = [y | y <- [1..(x -1)], x `mod` y == 0 ]

myPerfect :: Int -> [Int]
myPerfect n = [x |x <- [1..n], foldr (+) 0 (myFac x) == x ]