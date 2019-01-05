import Data.Maybe

vals1 = [[x] | x <- [1..11], odd x, x>=3]
vals2 = [(x, even x) | x <- [5,20,25]]
vals3 = [Just x | x <- [1,9,25]]
vals4 = [(x,y) | x <- [1,2,3,4], y <- [5,4,3,2], y > x ]

--Corrected
list1 :: [[Int]]
list1 = [ [i*2+1] | i <- [1 .. 5]]

list2 :: [(Int, Bool)]
list2 = [ (i*5, even i) | i <- [1 .. 5], i /= 2, i /= 3]

list3 :: [Maybe Int]
list3 = [ (Just (i*i)) | i <- [1 .. 5], i /= 2, i /= 4]

list4 :: [(Int, Int)]
list4 = [ (i,j) | i <- [1 .. 5], j <- [5,4..2], i < j ]



--[[3],[5],[7],[9],[11]]
--[(5,False),(20,True),(25,False)]
--[Just 1,Just 9,Just 25]
--[(1,5),(1,4),(1,3),(1,2),(2,5),(2,4),(2,3),(3,5),(3,4),(4,5)]

{-
Define the functions using list comprehensions. 
i) map, 
ii) lookup (Link), 
iii) replicate (Link) and 
iv) filter 

If necessary, use the (predefined) function listToMaybe from Data.Maybe (Link).
-}



myMap :: (a -> b) -> [a] -> [b]
myMap f xs = [f y | y <- xs]

myLookup :: (Eq a) => a -> [(a,b)] -> Maybe b
myLookup key values = listToMaybe [y | (x,y) <- values, x == key]

myReplicate :: Int -> a -> [a]
myReplicate n x = [x | y <- [1..n]]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [y | y <- xs , f y]

