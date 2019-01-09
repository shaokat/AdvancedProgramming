data Peano = Z | S Peano deriving (Eq, Show)

class SemiGroup a where
    (<+>) :: a -> a -> a

class SemiGroup a => Monoid a where
    neutral :: a

var1 :: Peano 
var1 = S (S (S Z))

var2 :: Peano 
var2 = S (S (S (S (S Z))))


instance SemiGroup Peano where
    (<+>) v1 v2 = makePeano ( (peanoToInt v1) + (peanoToInt v2) )


peanoToInt :: Peano -> Int
peanoToInt Z = 0
peanoToInt (S rest) = 1 + (peanoToInt rest)


makePeano :: Int -> Peano
makePeano 0 = Z
makePeano x = S (makePeano (x-1))