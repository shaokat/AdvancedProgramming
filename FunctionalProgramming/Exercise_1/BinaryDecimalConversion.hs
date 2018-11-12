{-
decToBinList :: Int -> [Bool]
decToBinList x  = if x == 0 then [False] else
                  if x == 1 then [True] else
                  if even x then decToBinList (x `div` 2) ++ [False] else
                  decToBinList (x `div` 2) ++ [True]

decToBinList :: Int -> [Bool]               
decToBinList x | x == 0    = [False] 
               | x == 1    = [True] 
               | even x    = decToBinList (x `div` 2) ++ [False]
               | otherwise = decToBinList (x `div` 2) ++ [True]

-}
-----------------------------------------------------------------------
--(Horner's Method) decToBinList
decToBinList :: Int -> [Bool]
decToBinList x = decToBinList' x 0

decToBinList' :: Int -> Int -> [Bool]
decToBinList' 0 1 = []
decToBinList' x move = if move == 0 then (decToBinList' (decreaseValue x) 1) ++ (addElement x) else
                       decToBinList' (x `div` 2) 0

addElement :: Int -> [Bool]
addElement x = if even x then [False] else [True]

decreaseValue :: Int -> Int
decreaseValue x = if even x then x else (x - 1)
------------------------------------------------------------------

--(Horner's Method) binListToDec
binListToDec :: [Bool] -> Int
binListToDec xs = binListToDec' xs 0 0

binListToDec' :: [Bool] -> Int -> Int -> Int
binListToDec' [] _ _ = 0
binListToDec' [_] sum 1 = sum
binListToDec' (x:xs) sum move = if move == 0 then (binListToDec' (x:xs) (sum + (value x)) 1) else
                                (binListToDec' xs (sum * 2) 0)
value :: Bool -> Int
value a = if a == True then 1 else 0


------------------------------------------------------------------

--(Horner's Method) Decimal To Binary using user defined Data Type
data Binary = IHi | I Binary| O Binary deriving (Show)
decToBin :: Int -> Binary
decToBin x = decToBin' x 0

decToBin' :: Int -> Int -> Binary
decToBin' 1 0 = IHi
decToBin' x move = if move == 0 && even x then O (decToBin' x 1)  else
                   if move == 0 && odd x then I (decToBin' (x-1) 1) else
                       decToBin' (x `div` 2) 0



----------------------------------------------------------------------
--(This is not Horner's Method) But it will calculate Binary to Decimal using user defined Data Type
binToDec :: Binary -> Int
binToDec IHi = 1
binToDec x = binToDecT x 0 0


binToDecT :: Binary-> Int -> Int -> Int
binToDecT IHi sum pos = sum + (optExponentiation 2 pos)
binToDecT (O x) sum pos = binToDecT x sum (pos+1)
binToDecT (I x) sum pos = binToDecT x (sum + (optExponentiation 2 pos)) (pos+1)

optExponentiation :: Int -> Int -> Int
optExponentiation b e | e == 0    = 1
                      | even e    = square (optExponentiation b (e `div` 2))
                      | otherwise = b * square (optExponentiation b (e `div` 2))

square :: Int -> Int
square x = x * x



