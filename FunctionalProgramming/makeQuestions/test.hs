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