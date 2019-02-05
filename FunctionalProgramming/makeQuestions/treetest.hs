import Data.Char

{-
data Tree a = Left a | Right a | Mid a | Node a (Tree a) (Tree a) (Tree a)

1. Give Example of 3 values of Tree. [Each example must contain all Left Right and Mid, 
                                       and each tree structure will be different]
    i) Tree Int
    ii) Tree Bool
    iii) Tree String

2. Find summation of a given (Tree Int) data 

3. Implement a function which will transorm (Tree a) to [a]. 


data Tree = Null | Node Int Bool [Tree]

1. Int + , Bool Or firstTask :: Tree -> (Int, Bool)
2. number of Null 
3. number of Node 
-}

data Tree = Null | Node Int Bool [Tree]

countNull :: Tree -> Int
countNull Null = 1
countNull (Node _ _ rest) = sum (map (countNull) rest)


sumAllInt :: Tree -> Int
sumAllInt Null = 0
sumAllInt (Node n _ rest) = n + (sum (map (countNull) rest))


firstTask :: Tree -> (Int, Bool)
firstTask Null = (0, False)
firstTask (Node n bl rest) = mergeTwoPair (n,bl) (mergeLists (map firstTask rest))


mergeLists :: [(Int, Bool)] -> (Int, Bool)
mergeLists [] = (0, False)
mergeLists ((x,y):xys) = (x + (fst (mergeLists xys)), y || (snd (mergeLists xys)))

mergeTwoPair :: (Int, Bool) -> (Int, Bool) -> (Int, Bool)
mergeTwoPair (x1,y1) (x2,y2) = (x1+x2, y1 || y2)

{-
Consider this prelude function.

ord :: Char -> Int
*Main> ord 'a'
97
*Main> ord 'b'
98
*Main> ord 'z'
122
*Main> ord 'A'
65
*Main> ord 'B'
66
*Main> ord 'Z'
90

i) Write the type of this function. 2
ii) Write in two sentence, describing this function. 2
iii) Write an input for this function and calculate the output of this function. 5 
-}
func [] = []
func (x:xs) = let 
               (p,q) = x
               newVal = map ord p
               newVal2 = map (+q) newVal
              in newVal2 : (func xs)
