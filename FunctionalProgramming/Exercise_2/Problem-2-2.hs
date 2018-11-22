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
height (Leaf x) = 1
height (Node tl tr) = 1 + (max (height tl) (height tr))


leafNumber :: Tree Int -> Int
leafNumber (Leaf x) = 1
leafNumber (Node tl tr) = (leafNumber tl) + (leafNumber tr)


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
              
flatTree   :: Tree (Tree Int) -> Tree Int

flatTree (Leaf (Leaf x))= (Leaf x)
flatTree (Leaf (Node tl tr)) = (Node tl tr)
flatTree (Node tL tR) =  Node (flatTree tL) (flatTree tR) 


treeToList :: Tree Int -> [Int]
treeToList (Leaf x) = [x]
treeToList (Node tl tr) = treeToList tl ++ treeToList tr


labelTree  :: Tree Int -> Tree (Int,Int)
labelTree (Node tl tr) = snd (labelTreehelper (Node tl tr) 0)

labelTreehelper :: Tree Int -> Int -> (Int, Tree (Int, Int))
labelTreehelper (Leaf x) sum = ((sum+1) , (Leaf ((sum+1), x)))
labelTreehelper (Node tl tr) sum = let 
                                      (s1 , x) = (labelTreehelper tl sum)
                                      (s2 , y) = (labelTreehelper tr s1)
                                   in (s2, (Node x y))


data TreeZip a = LastBox a | InnerBox a (TreeZip a) (TreeZip a) deriving (Eq, Show)

treeZip1 :: TreeZip Int
treeZip1 = InnerBox 10000
            (InnerBox 1000
                (LastBox 7) 
                (LastBox 3)
            )
            (InnerBox 2000
                (InnerBox 100
                    (InnerBox 10 
                        (LastBox 4) 
                        (LastBox 5) 
                    )
                    (InnerBox 20
                        (LastBox 5)
                        (LastBox 4)
                    )
                )
                (LastBox 4)
            )


treeZip2 :: TreeZip Int
treeZip2 = InnerBox 99999
            (InnerBox 9999
                (LastBox 11) 
                (LastBox 19)
            )
            (InnerBox 8888
                (InnerBox 999
                    (InnerBox 99
                        (LastBox 37) 
                        (LastBox 23) 
                    )
                    (InnerBox 88
                        (LastBox 31)
                        (LastBox 41)
                    )
                )
                (LastBox 29)
            )


zipTree :: TreeZip Int -> TreeZip Int -> TreeZip (Int,Int)
zipTree (LastBox x) (LastBox y) = LastBox (x,y)
zipTree (InnerBox x txl txr) (LastBox y) = LastBox (x,y)
zipTree (LastBox x) (InnerBox y tyl tyr) = LastBox (x,y)
zipTree (InnerBox x txl txr) (InnerBox y tyl tyr) = (InnerBox (x,y) (zipTree txl tyl) (zipTree txr tyr))


unzipTree  :: TreeZip (Int,Int) -> (TreeZip Int, TreeZip Int)
unzipTree (LastBox (x, y)) = ((LastBox x), (LastBox y))
unzipTree (InnerBox (x,y) tl tr) = let 
                                     (treeOneLeft, treeTwoLeft) = unzipTree tl
                                     (treeOneRight, treeTwoRight) = unzipTree tr
                                    in ((InnerBox x  treeOneLeft treeOneRight) , (InnerBox y treeTwoLeft treeTwoRight))