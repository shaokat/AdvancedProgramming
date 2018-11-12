

--testTree = Node (Node (Leaf 1) (Leaf 2)) (Leaf 3)

data IntTree = Leaf Int | Node IntTree IntTree deriving (Show)

sumTree :: IntTree -> Int
sumTree (Leaf x) = x
sumTree (Node leftTree rightTree) = (sumTree leftTree) + (sumTree rightTree)


mirrorTree :: IntTree -> IntTree
mirrorTree (Leaf x) = (Leaf x)
mirrorTree (Node leftTree rightTree) = (Node (mirrorTree rightTree)  (mirrorTree leftTree))


