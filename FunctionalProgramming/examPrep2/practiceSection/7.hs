import Data.Maybe
--getNonEmptyLine :: IO String
--getNonEmptyLine = do
--  input  <- getLine
--  result <- if null input
--              then do
--                putStrLn "Please enter a non-empty string."
--                getNonEmptyLine
--              else return input
--  return result

getNonEmptyLine :: IO String
getNonEmptyLine = getLine >>= \input -> if null input then
                               putStrLn "H" >> getNonEmptyLine else
                               return input >>= \result -> return result


{-
Define the following lists as list comprehensions. 
Each comprehension should have the exact form [ ... | i <- [1 .. 5], ...].

[[3],[5],[7],[9],[11]]
[(5,False),(20,True),(25,False)]
[Just 1,Just 9,Just 25]
[(1,5),(1,4),(1,3),(1,2),(2,5),(2,4),(2,3),(3,5),(3,4),(4,5)]
-}

list1 :: [[Int]]
list1 = [ [i*2+1] | i <- [1 .. 5]]

list2 :: [(Int, Bool)]
list2 = [ (i*5, even i) | i <- [1 .. 5], i /= 2, i /= 3]

list3 :: [Maybe Int]
list3 = [ (Just (i*i)) | i <- [1 .. 5], i /= 2, i /= 4]

list4 :: [(Int, Int)]
list4 = [ (i,j) | i <- [1 .. 5], j <- [5,4..2], i < j ]

--Define the functions 
--i) map, 
--ii) lookup (Link), 
--iii) replicate (Link) and 
--iv) filter 
--using list comprehensions. If necessary, use the (predefined) function 
--listToMaybe from Data.Maybe (Link).



myMap :: (a->b) -> [a] -> [b]
myMap f xs = [f x | x <- xs]

myLookup :: (Eq a) =>  a -> [(a,b)] -> Maybe b 
myLookup x ys = listToMaybe [q | (p,q) <- ys, p == x]

myReplicate :: (Enum a) => Int -> a -> [a]
myReplicate n x = [x | y <- [1..n]]
--myReplicate n x = take n [p | p <- [x,x..] ]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [x | x <- xs, f x]

