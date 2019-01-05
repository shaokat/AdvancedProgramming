type Set a = a -> Bool

lostSet :: Set Int
lostSet = \x -> elem x [4, 8, 15, 16, 23, 42]

empty :: Set a
empty = \x -> False

insert :: Eq a => a -> Set a -> Set a
insert x s = \y -> if x == y then True else s y

remove :: Eq a => a -> Set a -> Set a
remove x s = \y -> if x == y then False else s y

isElem :: a -> Set a -> Bool
isElem x s = s x

union :: Set a -> Set a -> Set a
union s1 s2 = \y -> (s1 y || s2 y)

intersection :: Set a -> Set a -> Set a
intersection s1 s2 = \y -> (s1 y && s2 y)

--Suppose, A = {1, 2, 3, 4, 5} and B = {3, 4, 5, 6, 7, 8}
--Difference,  A - B = {1, 2}

--Suppose A = {1, 2, 3} and U = {1, 2 ,3, 4, 5}, 
-- Complement A = U - A = {1,2,3,4,5} - {1,2,3} = {4,5}

difference :: Set a -> Set a -> Set a
difference s1 s2 = intersection s1 (complement s2)

complement :: Set a -> Set a
complement s = \y -> not (s y)
