data Set a = Set [a] deriving Show

empty :: Set a
empty = Set []

insert :: Eq a => a -> Set a -> Set a
insert x (Set s) = Set (if x `elem` s then s else x:s)

isElem :: Eq a => a -> Set a -> Bool
isElem x (Set xs) = x `elem` xs

union ::  Eq a => Set a -> Set a -> Set a
union (Set xs) (Set []) = Set xs
union (Set xs) (Set (y:ys)) | elem y xs = union (Set xs) (Set ys)
                            | otherwise = union (Set (y:xs)) (Set ys)








