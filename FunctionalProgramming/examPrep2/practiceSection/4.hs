data Set a = Set ( a -> Bool )

empty :: Set Int
empty = Set (\_ -> False)


insert :: (Eq a) => a -> Set a -> Set a
insert x (Set s) = Set (\y -> if y == x then True else s y)


isElem :: a -> Set a -> Bool
isElem x (Set s) = s x

union :: Eq a => Set a -> Set a -> Set a
union (Set s1) (Set s2) = Set (\y -> (s1 y) || (s2 y)) 

--s1 = Set (if 99 then True else (if 7 then True else (if 3 then True else (\_ -> False))))
--s2 = Set (if 99 then True else (if 5 then True else (if 9 then True else (\_ -> False))))

