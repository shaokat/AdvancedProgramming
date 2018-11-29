import Prelude hiding (Ordering, LT, EQ, GT)
data Ordering = LT | EQ | GT deriving (Show, Eq, Ord)
data SearchTree a = Empty | Node a (SearchTree a) (SearchTree a) deriving (Show, Eq, Ord)

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
        	(
        		Node 30
        		   Empty
        		   Empty
        	)
        )

compareVal :: Ord a => a -> a -> Ordering
compareVal x y | x == y     = EQ
               | x > y      = GT
               | otherwise  = LT

isElem :: Int -> SearchTree Int -> Bool
isElem n Empty = False
isElem n (Node x leftTree rightTree) | compareVal x n == EQ  = True
                                     | compareVal x n == GT  = isElem n leftTree
                                     | otherwise             = isElem n rightTree

insertElem :: Int -> SearchTree Int -> SearchTree Int
insertElem n Empty = Node n Empty Empty
insertElem n (Node x leftTree rightTree) | compareVal x n == EQ  = Node x leftTree (insertElem n rightTree)
                                         | compareVal x n == GT  = Node x (insertElem n leftTree) rightTree 
                                         | otherwise             = Node x leftTree (insertElem n rightTree)

deleteElem :: Int -> SearchTree Int -> SearchTree Int 
deleteElem n Empty = Empty
deleteElem n (Node x leftTree rightTree) | compareVal x n == EQ = if      leftTree == Empty then rightTree 
	                                                              else if rightTree == Empty then leftTree
	                                                              else let
	                                                                      y = getMinimumVal rightTree
	                                                                   in Node y leftTree (deleteElem y rightTree)
	                                     | compareVal x n == GT = Node x (deleteElem n leftTree) rightTree
	                                     | otherwise            = Node x leftTree (deleteElem n rightTree)

getMinimumVal :: SearchTree Int -> Int
getMinimumVal Empty = 2^30
getMinimumVal (Node x leftTree rightTree) = min x (getMinimumVal leftTree)


