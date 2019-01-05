--Structure: [ ... | i <- [1 .. 5], ...]

-- 01. [[3],[5],[7],[9],[11]]
list1 :: [[Int]]
list1 = [ [i*2+1] | i <- [1 .. 5]]

--02. [(5,False),(20,True),(25,False)]
list2 :: [(Int, Bool)]
list2 = [ (i*5, even i) | i <- [1 .. 5], i /= 2, i /= 3]

--03. [Just 1,Just 9,Just 25]
list3 :: [Maybe Int]
list3 = [ (Just (i*i)) | i <- [1 .. 5], i /= 2, i /= 4]

--04. [(1,5),(1,4),(1,3),(1,2),(2,5),(2,4),(2,3),(3,5),(3,4),(4,5)]
list4 :: [(Int, Int)]
list4 = [ (i,j) | i <- [1 .. 5], j <- [5,4..2], i < j ]
----------------------------------------------------------------------

--More Examples: 
--05. find sum 1^2 + 2^2 + 3^2 + ... + n^2
calculateSquareSum :: Int -> Int
calculateSquareSum n = foldr (+) 0 [ x*x | x <- [1..n]]

--06. given max length of side, find all triangles that is right angle
--pyths 10
--[(3,4,5),(4,3,5),(6,8,10),(8,6,10)]
pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], (x*x) + (y*y) == (z*z)]


-- 07. find Perfect Number where .. sum(divisors of n except n) == n
--perfectNum 500
--[6,28,496]

divisors :: Int -> [Int]
divisors x = [y | y <- [1..(x -1)], x `mod` y == 0 ]

perfectNum :: Int -> [Int]
perfectNum n = [x |x <- [1..n], foldr (+) 0 (divisors x) == x ]


{-
-- ** 
take 5 [ (x,y,z) | x <- [2..], y <- [x+1..],z <- [y+1..]]
[(2,3,4),(2,3,5),(2,3,6),(2,3,7),(2,3,8)]

-- ** 
take 5 [ (x,y,z) | x <- [2..], y <- [x+1],z <- [y+1]]
[(2,3,4),(3,4,5),(4,5,6),(5,6,7),(6,7,8)]

-- **
take 5 [ 2*x | x <- [0..], x^2 > 3 ]
[4,6,8,10,12]
-}



--http://www2.cs.arizona.edu/~collberg/Teaching/372/2005/Html/Html-13/index.html