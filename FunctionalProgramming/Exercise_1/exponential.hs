{-
exponentiation :: Int -> Int -> Int
exponentiation b e = if e == 0 then 1 else
					b * exponentiation b (e - 1)
-}

exponentiation :: Int -> Int -> Int
exponentiation b e | e == 0 = 1
                   | otherwise = b * exponentiation b (e - 1)

{-
optExponentiation :: Int -> Int -> Int
optExponentiation b e = 
	if e == 0 then 1 else
	if even e then (optExponentiation b (e `div` 2)) * (optExponentiation b (e `div` 2)) else
	b * (optExponentiation b (e `div` 2)) * (optExponentiation b (e `div` 2))
-}


optExponentiation :: Int -> Int -> Int
optExponentiation b e | e == 0    = 1
                      | even e    = square (optExponentiation b (e `div` 2))
                      | otherwise = b * square (optExponentiation b (e `div` 2))

square :: Int -> Int
square x = x * x