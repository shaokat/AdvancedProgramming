

myZip :: [a] -> [b] -> [(a, b)]
myZip xs [] = []
myZip [] ys = []
myZip (x:xs) (y:ys) = (x,y) : (myZip xs ys)



myUnzip :: [(a,b)] -> ([a],[b])
myUnzip ((x,y):[]) = ([x],[y])
myUnzip ((x,y):others) = let
                        retPair = (myUnzip others)
                      in (x: fst retPair, y: snd retPair)



data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Eq, Show)
tree1 :: Tree Int
tree1 = Node 
            (Node 
                (Leaf 7) 
                (Leaf 3)
            )
            (Node 
                (Node 
                    (Node 
                        (Leaf 4) 
                        (Leaf 5) 
                    )
                    (Node 
                        (Leaf 5)
                        (Leaf 4)
                    )
                )
                (Leaf 4)
            )

height :: Tree Int -> Int
height (Leaf x)  = 1
height (Node t1 tr) = 1 + (max (height t1) (height tr))