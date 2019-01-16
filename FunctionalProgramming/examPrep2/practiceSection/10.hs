import Data.List;

--[False, True]
allCombinations :: [a] -> [[a]]
allCombinations xs = [[]] ++ doIt [[]]
                    where 
                      doIt lists = let
                                     newList = getFullList xs lists 
                                    in newList ++ (doIt newList)


getFullList :: [a] -> [[a]] -> [[a]]
getFullList [] ys = []
getFullList (x:xs) ys = (addToAllList x ys)  ++ (getFullList xs ys)


addToAllList :: a -> [[a]] -> [[a]]
addToAllList x [] = []
addToAllList x (y:ys) = (y++[x]) : (addToAllList x ys)




mySort :: [Int] -> [Int]
mySort xs = sort xs

--take 10 avalanche
--[1,3,5,7,9,15,21,25,27,35]

avalanche :: [Int]
avalanche = doIt [1]
           where 
            doIt (x:xs) = x : doIt (sort (makeUnique ([x*3, x*5, x*7] ++ xs)))
makeUnique :: [Int] -> [Int]
makeUnique [] = []
makeUnique (x:xs) = x : (makeUnique (filter (/=x) xs))