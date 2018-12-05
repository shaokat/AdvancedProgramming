type Set a = a -> Bool

contains :: Set Int -> Int -> Bool
contains s n = s n

lostSet :: Set Int
lostSet = \x -> elem x [4, 8, 15, 16, 23, 42]

tempSet :: Set Int
tempSet = \x -> elem x [10,20,30]

universalSet :: Set Int
universalSet = \x -> elem x [0..100]

empty :: Set Int
empty = \x -> elem x []


insert :: Int -> Set Int -> Set Int
insert x s | contains s x = s
           | otherwise = \y -> elem y (x : (setToList s))

remove :: Int -> Set Int -> Set Int
remove x s | contains s x = \y -> elem y (filter (/=x) (setToList s))
           | otherwise    = s

isElem :: Int -> Set Int -> Bool
isElem n s = s n

union :: Set Int -> Set Int -> Set Int
union s1 s2 = \y -> elem y ((setToList s1) ++ (setToList s2))

intersection :: Set Int -> Set Int -> Set Int
intersection s1 s2 = \y -> elem y (getCommonList (setToList s1))
                    where
                        getCommonList [] = []
                        getCommonList (x:xs) | contains s2 x = x : getCommonList xs
                                             | otherwise = getCommonList xs

difference :: Set Int -> Set Int -> Set Int
difference s1 s2 = \y -> elem y (getDiffList (setToList s1))
                    where
                        getDiffList [] = []
                        getDiffList (x:xs) | contains s2 x = getDiffList xs
                                           | otherwise = x : getDiffList xs

complement :: Set Int -> Set Int
complement s = difference universalSet s

setToList :: Set Int -> [Int]
setToList s = [x | x <- [0..100], contains s x]

listToSet :: [Int] -> Set Int
listToSet xs = \y -> elem y xs