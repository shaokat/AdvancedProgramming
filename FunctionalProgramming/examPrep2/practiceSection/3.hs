data Rat = Rat Int Int deriving (Eq, Show)

--instance Show Rat where
--    show (Rat x y) = (show x) ++ "/" ++ (show y)

val1 :: Rat
val1 = Rat 1 335

rat :: Int -> Int -> Rat 
rat x y = Rat x y

nominator :: Rat -> Int
nominator (Rat x y) = x

denominator :: Rat -> Int
denominator (Rat x y) = y

--2      7
---- +  --
--12     9     
--
--(3 * 2) + (7 * 4) 
----------------
--   36
--
--
--lcm  * gcd =  x  *  y 
--lcm = (x * y) / gcd 
--
--x ...
--y ...

addR :: Rat -> Rat -> Rat
addR (Rat x y) (Rat m n) = let 
                             lcm = (lcmr y n)
                            in diminish (Rat (((lcm `div` y) * x) + ((lcm `div` n) * m)) lcm)  


--addR (Rat x y) (Rat m n) = diminish (Rat (((lcm `div` y) * x) + ((lcm `div` n) * m)) lcm)
--                         where 
--                            lcm = (lcmr y n)


diminish :: Rat -> Rat
diminish (Rat x y) = let
                        myG = (myGCD x y)
                      in Rat (x `div` myG) (y `div` myG)
   
myGCD :: Int -> Int -> Int 
myGCD x 0 = x
myGCD x y = myGCD y (x `mod` y)


lcmr :: Int -> Int -> Int
--lcmr x 0 = 0
--lcmr 0 y = 0
lcmr x y =  (x * y) `div` (myGCD x y)
5490045309041151