--1. The function "indexOf"
data MyMayBe a = NotFound | FoundIn a  deriving (Show)
myIndexOf :: Ord a => a -> [a] -> MyMayBe Int
myIndexOf n xs = myIndexOf' n xs 0
                 where
                    myIndexOf' n [] indx = NotFound
                    myIndexOf' n (y:ys) indx | n == y    = FoundIn indx
                                             | otherwise = myIndexOf' n ys (indx + 1) 


--2. The functions inits, tails :: [a] -> [[a]]

inits :: [a] -> [[a]]
inits xs = helperInits xs []

helperInits :: [a] -> [a] -> [[a]]
helperInits [] zs = [zs]
helperInits (y:ys) zs = zs : (helperInits ys (zs ++ [y]))


tails :: [a] -> [[a]]
tails [] = [[]]
tails (x:xs) = (x:xs) : tails xs 



--3. The function insert :: a -> [a] -> [[a]] should insert a given element at every position of a list.
insertValue :: a -> [a] -> [[a]]
insertValue a xs = helperInsert a xs 0

helperInsert :: a -> [a] -> Int -> [[a]]
helperInsert y xs indx | (length xs) == (indx - 1) = []
                       | otherwise           = [(fst (splitAt indx xs)) ++ [y] ++ (snd (splitAt indx xs))] ++ (helperInsert y xs (indx+1))




--4. The function perms :: [a] -> [[a]] should calculate all permutations of a list.

perm :: Eq a => [a] -> [[a]]
perm xs = makeUnique ( helperPerm xs [] 0 )

helperPerm :: [a] -> [a] -> Int -> [[a]]
helperPerm [] ys indx = [ys]
helperPerm xs ys indx | (length xs) == (indx + 1) = (helperPerm (removeElemFromListByIndex indx xs) ((getValueByIndex indx xs):ys) 0)
                      | otherwise                 = (helperPerm (removeElemFromListByIndex indx xs) ((getValueByIndex indx xs):ys) 0) ++ (helperPerm xs ys (indx + 1))

getValueByIndex :: Int -> [a] -> a
getValueByIndex indx [] = error "Input is wrong"
getValueByIndex indx (x:xs) | indx == 0 = x
                    | otherwise  = getValueByIndex (indx - 1) xs

removeElemFromListByIndex :: Int -> [a] -> [a]
removeElemFromListByIndex n [] = []
removeElemFromListByIndex n (x:xs) | n == 0 = xs
                       | otherwise  = x : (removeElemFromListByIndex (n-1) xs) 


makeUnique :: Eq a => [[a]] -> [[a]]
makeUnique [] = []
makeUnique (l:ls) = l : (filter (/= l) (makeUnique ls))

