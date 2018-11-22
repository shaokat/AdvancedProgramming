

--testTree = ( Node (Node (Leaf 1) (Leaf 2)) (Leaf 3))
--testTree = ( Node ( Node ( Node ( Leaf 1) (Leaf 3)) (Node (Leaf 7) (Leaf 9) )) (Node (Node (Leaf 5) (Leaf 11)) (Node (Leaf 13) (Node (Leaf 1) (Leaf 2)))))

data IntTree = Leaf Int | Node IntTree IntTree deriving (Show)

--Using Recursion
sumTree :: IntTree -> Int
sumTree (Leaf x) = x
sumTree (Node leftTree rightTree) = (sumTree leftTree) + (sumTree rightTree)

--Using accomulator function like fibonacci
sumTree2 :: IntTree -> Int
sumTree2 (Leaf x) = x
sumTree2 (Node leftTree rightTree) = sumTree2' (Node leftTree rightTree) 0

sumTree2' :: IntTree -> Int -> Int
sumTree2' (Leaf x) sum = sum + x
sumTree2' (Node leftTree rightTree) sum = sum + (sumTree2' leftTree sum) + (sumTree2' rightTree sum)
{-
Here, it's not working like fib function. No repetative recursive calls. 
So, I think complexity for both algorithms are same. 	
-}

mirrorTree :: IntTree -> IntTree
mirrorTree (Leaf x) = (Leaf x)
mirrorTree (Node leftTree rightTree) = (Node (mirrorTree rightTree)  (mirrorTree leftTree))



calculateLabel :: IntTree -> [Int]
calculateLabel (Leaf x) = [x]
calculateLabel (Node leftTree rightTree) = [((calculateNodeSum leftTree) + (calculateNodeSum rightTree))] ++ (calculateLabel leftTree) ++ (calculateLabel rightTree)

calculateNodeSum :: IntTree -> Int
calculateNodeSum (Leaf x) = x
calculateNodeSum (Node leftTree rightTree) = calculateNodeSum leftTree + calculateNodeSum rightTree

--( Node ( Node ( Node ( Leaf 1) (Leaf 3)) (Node (Leaf 7) (Leaf 9) )) (Node (Node (Leaf 5) (Leaf 11)) (Node (Leaf 13) (Node (Leaf 1) (Leaf 2)))))
{-
Runtime Analysis:
Complexity of concatenation = O(n)
Compleity of Calculating Sum = O(n)
Complexity of Caclulating each label = O(n) 

So, The overall complexity of this solution  is O(n^3) 

-}

