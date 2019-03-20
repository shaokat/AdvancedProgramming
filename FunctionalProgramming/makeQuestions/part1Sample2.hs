


data SearchTree a = Empty | Node a (SearchTree a) (SearchTree a) deriving (Show, Eq, Ord)
data Tree a = Free | TreeNode a (Tree a) (Tree a) deriving (Show, Eq, Ord)

tree1 :: SearchTree Int
tree1 = Node 15 
        (
            Node 10 
            (
                Node 8
                   Empty
                   Empty
            ) 
            (
                Node 14
                   Empty
                   Empty
            )
        ) 
        (
            Node 25 
            (
                Node 20
                   Empty
                   Empty
            ) 
            Empty
        )
--1
printSequentially :: (SearchTree Int) -> String
printSequentially Empty = "" 
printSequentially (Node x left right) = (printSequentially left) ++ " "++(show x) ++ (printSequentially right)

--1
printSequentiallyDesc :: (SearchTree Int) -> String
printSequentiallyDesc Empty = "" 
printSequentiallyDesc (Node x left right) = (printSequentiallyDesc right) ++ " "++(show x) ++ (printSequentiallyDesc left) 

--2
maximumPathSum :: (SearchTree Int) -> Int
maximumPathSum input = doIt 0 input
    where
        doIt curSum Empty = curSum
        doIt curSum (Node x lt rt) = let
                                       leftSum = doIt (curSum + x) lt
                                       rightSum = doIt (curSum + x) rt
                                    in if leftSum > rightSum then leftSum else rightSum

tree2 :: Tree Int
tree2 = TreeNode 20 
        (
            TreeNode 5 
            (
                TreeNode 113
                  Free
                  Free
            ) 
            (
                TreeNode 40
                  Free
                  Free
            )
        ) 
        (
            TreeNode 55
            (
                TreeNode 26
                  Free
                  Free
            ) 
            (
                TreeNode 14
                  Free
                  Free
            )
        )
--4
convertTreeToBST :: (Tree Int) -> (SearchTree Int)
convertTreeToBST input = convertListToBST (convertTreeToList input)

convertTreeToList :: (Tree Int) -> [Int]
convertTreeToList Free = []
convertTreeToList (TreeNode x lt rt) = [x] ++ (convertTreeToList lt) ++ (convertTreeToList rt)

convertListToBST :: [Int] -> (SearchTree Int)
convertListToBST list = doIt list Empty
    where
        doIt [] result = result
        doIt (x:xs) result = doIt xs (insertIntoBST x result)

insertIntoBST :: Int -> (SearchTree Int) -> (SearchTree Int)
insertIntoBST x Empty = (Node x Empty Empty)
insertIntoBST x (Node val lt rt) | x < val   = (Node val (insertIntoBST x lt) rt)
                                 | otherwise = (Node val lt (insertIntoBST x rt))



--4
func :: [[Int]] -> [Bool] -> [Int]
func [] [] = []
func (x:xs) (y:ys) | y         = let 
                                   m = foldr (\p q -> p + q) 0 x
                                   n = m : x
                                 in  n ++ (func xs ys)
                   | otherwise = x ++ (func xs ys)
                   
{-
[[1,2,3], [2,3,4], [3,4,5]]
[[1,2,2], [2,3,4], [3,4,5]]

i) Write type of this function. 
ii) Describe this function. 
iii) Write sample input and output.
iv) Fix bug if you find any. 
-}
{-
1. Detect type Error? 
i) "Deutschland" ++ ['c', 's', 'e']
ii) [1,2,3,4] : [3,4] :  [[1],[2,3]] 
iii) [1,2,3,4] : ([3,4] :  [[1],[2,3]])
iv) [[]] ++ [[]]
v) [] : [[[]]]

Answer: i

2. Which of them are valid as type of this function: funcTest p q r = p (q r)
i) funcTest :: (Int -> Bool) -> (Float -> Int) -> Float -> Bool
ii) funcTest :: (a -> b) -> (b -> c) -> b -> c
iii) funcTest :: (c -> a) -> (b -> c) -> b -> a
iv) funcTest :: (b -> a) -> (a -> b) -> a -> b
v) funcTest :: (String -> [Int]) -> (Int -> String) -> Int -> [Int] 

Answer: i, iii, v
funcTest :: (Int -> Bool) -> (Float -> Int) -> Float -> Bool
funcTest p q r = p (q r)

3. Which is valid for this statement: map (\x -> replicate x 3) [1,2,3]
[Hint: replicate :: Int -> a -> [a]]
i)  [[3],[3,3],[3,3,3]]
ii) [[1,1,1], [2,2,2], [3,3,3]]
iii)[3,3,3,3,3,3]
iv) [1,1,1,2,2,2,3,3,3]
iv) yields an error

Answer: i

4. Which of them are valid: 
i) foldr (\x y -> x * 2 - y) 4 [1,2,3] = -1
ii) foldl (\x y -> x * 2 - y) 4 [1,2,3] = 21
iii) foldr (\x y -> y) 5 [1,2,3] = 5
iv) foldl (\x y -> y) 5 [1,2,3] = 5
v) foldr (-) 1 [1,2,3] = 1

Answer: ii, iii, v

5. Which of the following types are correct? 
i) map :: (a->b) -> [a] -> [b]
ii) map :: (a -> b) -> ([a] -> [b])
iii) map (+) :: [Int] -> [Int -> Int]
iv) map (\s -> '!') :: String -> String
v) flip map [1..10] :: (Int -> a) -> [a]

Answer: i, ii, iii, iv, v
--
-}




addDigits :: Int -> Int 
addDigits 0 = 0
addDigits n = (n `mod` 10) + (addDigits (n `div` 10))


rotateList :: Int -> [Int] -> [Int]
rotateList n xs = doIt n xs
    where
        doIt 0 (x:xs) = (x:xs)
        doIt n (x:xs) = doIt (n-1) (xs ++ [x])