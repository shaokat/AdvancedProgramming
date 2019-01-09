data Peano = Zero | Succ Peano deriving (Show)

var1 :: Peano 
var1 = Succ (Succ (Succ Zero))

var2 :: Peano 
var2 = Succ (Succ (Succ (Succ (Succ Zero))))


--addPeano var1 var2
addPeano :: Peano -> Peano -> Peano
addPeano v1 v2 = makePeano ( (peanoToInt v1) + (peanoToInt v2) )

multPeano :: Peano -> Peano -> Peano
multPeano v1 v2 = makePeano ( (peanoToInt v1) * (peanoToInt v2) )


peanoToInt :: Peano -> Int
peanoToInt Zero = 0
peanoToInt (Succ rest) = 1 + (peanoToInt rest)


makePeano :: Int -> Peano
makePeano 0 = Zero
makePeano x = Succ (makePeano (x-1))


data A a = B () | A (a -> a) 
    --deriving (Show)

examVar1 :: A Bool
examVar1 = B ()

examVar2 :: A Bool
examVar2 = A (\_ -> False)

examVar3 :: A Bool
examVar3 = A (&& True)


data Exp = Num Int
         | Add Exp Exp
         | Mul Exp Exp

exp1 :: Exp
exp1 = (Mul (Num 42) (Add (Num 1) (Num 1)))

exp2 :: Exp
exp2 = (Add (Num 2) (Mul (Mul (Num 8) (Add (Num 4) (Num 1))) (Num 2)))

exp3 :: Exp
exp3 = (Add (Num 2) (Add (Num 3) (Add (Num 4) (Add (Num 5) (Num 6) ))))

--instance Show Exp where
--    show (Num x) = (show x)
--    show (Add expr1 expr2) = "(" ++ (show expr1) ++ " + " ++ (show expr2) ++ ")"
--    show (Mul expr1 expr2) = "(" ++ (show expr1) ++ " * " ++ (show expr2) ++ ")"


instance Show Exp where
    show expr = doIt False expr
               where
                 doIt _ (Num x) = (show x)
                 doIt prev (Add expr1 expr2) | prev      = "(" ++ (doIt False expr1) ++ " + " ++ (doIt False expr2) ++ ")"
                                             | otherwise = (doIt False expr1) ++ " + " ++ (doIt False expr2)
                 doIt prev (Mul expr1 expr2) = (doIt True expr1) ++ " * " ++ (doIt True expr2)


bonusAdd :: [Int] -> Int
bonusAdd xs = doIt 0 xs
              where 
                doIt _ []        = 0
                doIt cnt (y:ys)  = if (y `mod` 5 == 0) then ((getBonus (cnt+1)) + y) + (doIt (cnt + 1) ys)
                                   else y + (doIt 0 ys)



getBonus :: Int -> Int 
getBonus x | x == 2    = 100
           | x == 3    = 300
           | x == 4    = 1000
           | otherwise = 0

{-
False
1st Step -- Addition (False)
        2nd Step -- Multiplication (True)
              3rd Step --Multiplicaiton (True)
                   4th step -- (Addition) (False) 
                        5th step --Addition (False)
                            6h step -- Multiplication (True)
                                7th step -- (Addition) (False)

-}