data Tree a = Node a [Tree a] deriving (Eq, Show)

{-

       2
    /  |  \
   7   3   1
       |  / \
       0 3   2
-}
tree1 :: Tree Int
tree1 = Node 2 [Node 7 [], Node 3 [Node 0 []], Node 1 [Node 3 [], Node 2 []]]


tree2 :: Tree Int
tree2 = Node 5000 [Node 500 [Node 50 [Node 5 []]], Node 400 [Node 40 [Node 4 []]]]


maxBranching :: Tree Int -> Int
maxBranching (Node x []) = 1
maxBranching (Node x xs) =  maximum ( (length xs) : (map maxBranching xs) )

data LTree a = Leaf a | Branch [LTree a] deriving (Eq, Show)

{-

       *
    /  |  \
   7   *   *
       |  / \
       8 3   2
-}

ltree1 :: LTree Int
ltree1 = Branch [Leaf 7, Branch [Leaf 8], Branch [Leaf 3, Leaf 2]]


sumLTree :: LTree Int -> Int
sumLTree (Leaf x) = x
sumLTree (Branch xs) = sum (map sumLTree xs)

lTreeToTree :: LTree Int -> Tree (Maybe Int)
lTreeToTree (Leaf x) = (Node (Just x) [])
lTreeToTree (Branch xs) = Node Nothing (map lTreeToTree xs)

