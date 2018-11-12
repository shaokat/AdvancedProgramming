count :: Int -> [Int] -> Int
count n [] = 0;
count n (x:xs) = if n == x then 1 + (count n xs) else (count n xs)


remove :: Int -> [Int] -> [Int]
remove n [] = []
remove n (x:xs) = if n == x then remove n xs else [x] ++ (remove n xs)


sublist :: Int -> Int -> [Int] -> [Int]
sublist a b (x:xs) = if b < 0 then [] else
                      if a > 0 then sublist (a-1) (b-1) xs else
                      [x] ++ sublist a (b-1) xs


reversed :: [Int] -> [Int]
reversed [] = []
reversed (x:xs) = reversed xs ++ [x]
{-
reversed [5,9,2,4] => reversed [9,2,4] ++ [5]
				   => reversed [2, 4] ++ [9] ++ [5]
				   => reversed [4] ++ [2] ++ [9] ++ [5]
				   => reversed [] ++ [4] ++ [2] ++ [9] ++ [5]
				   => [] ++ [4] ++ [2] ++ [9] ++ [5]

It seems like the complexity for this solution is =  O(n), 
But we have to consider the complexity of (++) operation which is = O(n). 
So the overall complexity of this solution is O(n*n) 
That's why it works slow in bigger inputs. 
-}

reversed2 :: [Int] -> [Int]
reversed2 xs = reversed2' xs []


reversed2' :: [Int] -> [Int] -> [Int]
reversed2' [] a =  a
reversed2' (x:xs) a = reversed2' xs (x:a)

{-
The complexity for this solution is =  O(n), because complexity of (:) is O(1) 
That's why it works faster in bigger inputs. 
-}

indexOf :: Int -> [Int] -> Int
indexOf n (x:xs) = indexOf' n (x:xs) 0

indexOf' n [] cur = -1
indexOf' n (x:xs) cur = if(n==x) then cur else
                             indexOf' n xs (cur+1)

