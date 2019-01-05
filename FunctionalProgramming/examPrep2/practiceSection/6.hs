ones :: [Int]
ones = 1: ones

fromThen :: Int -> Int -> [Int]
fromThen n1 n2 = let d = n2-n1 in n1 : fromThen (n1+d) (n2+d)



--1: 5: 9 : 13 : 17

fromTo :: Int -> Int -> [Int]
fromTo n m = if n>m then [] else n : fromTo (n + 1) m

--take 10 (fromTo 1 5)
--1: 2 : 3 : 4 : 5

fact :: Int -> Int 
fact n  = foldr (*) 1 [1..n]

--take 7 (allCombinations [True,False])
--[[],[True],[False],[True,True],[False,True],[True,False],[False,False]]
allCombinations :: [a] -> [[a]]
allCombinations xs = [[]] ++ (doIt [[]])
                   where
                    doIt list = let 
                                  newList = getNewList list xs 
                                in newList ++ (doIt newList)


getNewList :: [[a]] -> [a] -> [[a]]
getNewList _ [] = []
getNewList list (x:xs) = (updateList list x) ++ (getNewList list xs)

updateList :: [[a]] -> a -> [[a]]
updateList [] x = []
updateList (y:ys) x = (y++[x]) : (updateList ys x)
