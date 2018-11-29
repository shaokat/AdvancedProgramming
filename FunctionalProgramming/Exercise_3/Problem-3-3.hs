 --i) flatTree   :: Tree (Tree a) -> Tree a
-------------------------------------------------------------------
data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Eq, Show)
treeS :: Tree Int
treeS =  Node 
        ( 
            Node 
                (Leaf 2) 
                (Leaf 1) 
        ) 
        (Leaf 7) 

treeR :: Tree Int
treeR =  Leaf 6

treeM :: Tree Int
treeM = Node (Leaf 5) (Leaf 6)
       


complexTree :: Tree (Tree Int)
complexTree = Node 
             ( 
                Node  
                   (Leaf treeS) 
                   (Leaf treeR) 
             ) 
             (Leaf treeM)
              
flatTree   :: Tree (Tree a) -> Tree a
flatTree (Leaf x)= x
flatTree (Node tL tR) =  Node (flatTree tL) (flatTree tR) 


--ii) mapTree    :: (a -> b) -> Tree a -> Tree b

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf x) = Leaf (f x)
mapTree f (Node leftTree rightTree) = Node (mapTree f leftTree) (mapTree f rightTree)




--iii) foldTree   :: (a -> b) -> (b -> b -> b) -> Tree a -> b
--foldTree should fold a tree to a single value.


foldTree :: (a -> b) -> (b -> b -> b) -> Tree a -> b
foldTree f g (Leaf x) = f x
foldTree f g (Node tl tr) = g (foldTree f g tl) (foldTree f g tr) 

{-

Input
i) foldTree (*2) (\x y -> x + y) treeR

Output
i) 12

-}