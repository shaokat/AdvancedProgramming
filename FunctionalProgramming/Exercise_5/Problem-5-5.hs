avalanche :: [Integer]
avalanche = doIt [1]
           where 
             doIt (x:xs) = x : (makeUnique (doIt (mySort ([(x * 3)] ++ [(x * 5)] ++ [(x * 7)] ++ xs))))

mySort :: (Ord a) => [a] -> [a]
mySort [] = []
mySort (x:xs) = (mySort smaller) ++ [x] ++ (mySort larger)
               where
                smaller = [y | y <- xs, y < x]
                larger = [y | y <- xs, y >= x]

makeUnique :: (Eq a) => [a] -> [a]
makeUnique [] = []
makeUnique (x:xs) = x : makeUnique (filter (/=x) xs)

--take 50 avalanche
--[1,3,5,7,9,15,21,25,27,35,45,49,63,75,81,105,125,135,147,175,
-- 189,225,243,245,315,343,375,405,441,525,567,625,675,729,735,875,
-- 945,1029,1125,1215,1225,1323,1575,1701,1715,1875,2025,2187,2205,2401]