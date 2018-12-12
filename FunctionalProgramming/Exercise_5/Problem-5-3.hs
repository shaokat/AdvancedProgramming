allCombinations :: [a] -> [[a]]

allCombinations xs = [[]] ++ doIt [[]]
                    where 
                      doIt lists = let
                                     newList = addListToAll xs lists 
                                    in newList ++ (doIt newList)
                     

addListToAll :: [a] -> [[a]] -> [[a]]
addListToAll [] _ = []
addListToAll (x:xs) ys = (addValueToAll x ys) ++ (addListToAll xs ys)

addValueToAll :: a -> [[a]] -> [[a]]
addValueToAll x [] = []
addValueToAll x (y:ys) = (y ++ [x]) : (addValueToAll x ys)


--take 7 (allCombinations [True,False])
--[[],[True],[False],[True,True],[False,True],[True,False],[False,False]]

--take 10 (allCombinations [True, False])
--[[],[True],[False],[True,True],[False,True],[True,False],[False,False],[True,True,True],[False,True,True],[True,False,True]]

--take 15 (allCombinations [1,2,3])
--[[],[1],[2],[3],[1,1],[2,1],[3,1],[1,2],[2,2],[3,2],[1,3],[2,3],[3,3],[1,1,1],[2,1,1]]


