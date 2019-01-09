{-
1. The expression [(1,True),(0,False)] can be typed as follows without further helper definitions.

       1. [(Int,Bool)]
       2. [Pairs]
       3. Ord a => [(a,Bool)]
       4. [Int,Bool]
       5. [(Int,Bool),(Int,Bool)]

Answer: 1, 3

var1 :: Ord a => [(a, Bool)]
var1 = [(0, False)]

-}

{-
2. The expression [(y,x) | x <- [1..3], y <- [1..2]] evaluates to

       1. [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3)]
       2. [(1,1),(2,2),(1,3),(2,1),(1,2),(2,3)]
       3. [(1,2),(2,1),(3,2),(1,1),(2,2),(3,1)]
       4. [(1,1),(1,2),(2,1),(2,2),(3,1),(3,2)]
       5. [(1,1),(2,1),(3,1),(1,2),(2,2),(3,2)]

Answer: None

-}

{-
3. The function nonsense x y = x y y can be types as follows.

       1. a -> a -> a
       2. (b -> b -> a) -> b -> a
       3. (a -> b -> b) -> b -> a
       4. (a -> a -> a) -> a -> a
       5. (a -> a -> b) -> a -> b
Answer: 2 4 5
-}


nonsense :: (a -> a -> b) -> a -> b
nonsense x y = x y y

{-
4. The expression Branch (Tip 1) (Tip 2) is a value of the following data types.

        1. data Tree a = Tip a | Branch a a
        2. data Tree a = Tip a | Branch (Tree a) (Tree a)
        3. data Tree a = Tip (Tree a) | Branch Int Int
        4. data Tree a = Tip (Tree a) | Branch (Tree a) (Tree a)
        5. data Tree a = Tip Int | Branch (Tree a) (Tree a)

Answer: 2 5
-}

data Tree a = Tip Int | Branch (Tree a) (Tree a)
var2 :: Tree Int
var2 = Branch (Tip 1) (Tip 2)


{-
5. Which of the following lists produce a type error in Haskell?

       1. [[],[]]
       2. [(),(1),(2)]
       3. [[1],[False]]
       4. [False, [True]]
       5. [[1,2],[]]

Answer: 2, 3, 4
-}