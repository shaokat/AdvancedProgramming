import Prelude hiding (Monoid)
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
    Z <+> n = n
    n <+> Z = n
    S n <+> S m = S (S (n <+> m))

instance Monoid Peano where
    neutral = Z