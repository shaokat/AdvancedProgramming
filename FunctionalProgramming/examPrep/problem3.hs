data Nat = IHi | O Nat | I Nat   deriving (Eq, Show)

fourNat :: Nat
fourNat = O (O (IHi))


type BitVec = [Bool]

toBitVec :: Nat -> BitVec
toBitVec IHi = [True]
toBitVec (O x) =  toBitVec x ++ [False] 
toBitVec (I x) =  toBitVec x ++ [True]

fromBitVec :: BitVec -> Nat
fromBitVec xs = fromBitVec' (reverse xs)
             where
                fromBitVec' [True] = (IHi)
                fromBitVec' (y:ys) | y == True = (I (fromBitVec' ys))
                                   | otherwise = (O (fromBitVec' ys))

inv :: BitVec -> BitVec
inv [] = []
inv (x:xs) | x == True = False : inv xs 
           | otherwise = True : inv xs

xor :: BitVec -> BitVec -> BitVec
xor as bs = reverse (xor' (reverse as) (reverse bs))
          where
             xor' [] [] = []
             xor' [] (x:xs) | x == True = True : xor' [] xs
                            | otherwise = False : xor' [] xs
             xor' (x:xs) [] | x == True = True : xor' [] xs
                            | otherwise = False : xor' [] xs
             xor' (x:xs) (y:ys) | x /= y = True : xor' xs ys
                                | otherwise = False : xor' xs ys 
