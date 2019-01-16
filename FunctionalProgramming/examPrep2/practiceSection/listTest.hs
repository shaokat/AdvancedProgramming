fibs :: [Integer]
--fibs = [ y | x <- [0..], y <- (zip [x..] (tail [x..])) ]
fibs = [0,1] ++ doIt 
      where
         doIt = [ x+y | (x,y) <- zip (0:1:doIt) (1:doIt)] 

myFibs :: [Integer]
myFibs = 0:1:[a+b | (a,b) <- zip myFibs (tail myFibs)]

{-
(0,1), (1,fibs)

0 1 1 2 3 5 8 
1 1 2 3 5 8
---------------
1 2 3 5 8 13
2 3 5 8 13
---------------
3 5 8 13
5 8 13
---------------
8 13
-}



--myFibs = 0:1:[x+y | x <- 1:myFibs, y<- 0:1:myFibs]

--1, 2, [x+y | x <- 1:myFibs, y<- 0:1:myFibs]

{-
0 
1
0 + 1
1 + 1
2 + 1
3 + 2
5 + 3
-}