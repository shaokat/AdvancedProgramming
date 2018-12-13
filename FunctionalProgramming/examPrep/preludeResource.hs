--reference http://hackage.haskell.org/package/base-4.12.0.0/docs/Prelude.html#t:Bool
data Maybe a = Nothing | Just a
data Either a b = Left a | Right b
data Ordering = LT | EQ | GT

type String = [Char]

(&&) :: Bool -> Bool -> Bool       --infixr 3
(||) :: Bool -> Bool -> Bool       --infixr 2
(==) :: a -> a -> Bool             --infix 4
(/=) :: a -> a -> Bool             --infix 4     
not :: Bool -> Bool
otherwise :: Bool

compare :: a -> a -> Ordering
(<) :: a -> a -> Bool              --infix 4 #
(<=) :: a -> a -> Bool             --infix 4 #
(>) :: a -> a -> Bool              --infix 4 #
(>=) :: a -> a -> Bool             --infix 4 #
(+) :: a -> a -> a                 --infixl 6 Source#
(-) :: a -> a -> a                 --infixl 6 Source#
(*) :: a -> a -> a                 --infixl 7 Source#
(/) :: a -> a -> a                 --infixl 7
(^) :: (Num a, Integral b) => a -> b -> a --infixr 8
div :: a -> a -> a                 --infixl 7
mod :: a -> a -> a                 --infixl 7

($)  ::              (a -> b) ->   a ->   b



negate :: a -> a 
abs :: a -> a
max :: a -> a -> a #
min :: a -> a -> a
fst :: (a, b) -> a
snd :: (a, b) -> b
curry :: ((a, b) -> c) -> a -> b -> c
uncurry :: (a -> b -> c) -> (a, b) -> c

pi :: a
exp :: a -> a 
log :: a -> a 
sqrt :: a -> a
sin :: a -> a 
cos :: a -> a 
tan :: a -> a
round :: Integral b => a -> b
ceiling :: Integral b => a -> b 
floor :: Integral b => a -> b

even :: Integral a => a -> Bool 
odd :: Integral a => a -> Bool 
gcd :: Integral a => a -> a -> a
lcm :: Integral a => a -> a -> a

elem :: Eq a => a -> t a -> Bool      -- infix 4
sum :: Num a => t a -> a
product :: Num a => t a -> a

foldr :: (a -> b -> b) -> b -> t a -> b
foldl :: (b -> a -> b) -> b -> t a -> b

id :: a -> a
const :: a -> b -> a
(.) :: (b -> c) -> (a -> b) -> a -> c --infixr 9
flip :: (a -> b -> c) -> b -> a -> c

--Lists: 
(!!) :: [a] -> Int -> a              --infixl 9
(++) :: [a] -> [a] -> [a]

head :: [a] -> a
last :: [a] -> a
tail :: [a] -> [a]
init :: [a] -> [a]
length :: Foldable t => t a -> Int
reverse :: [a] -> [a]
take :: Int -> [a] -> [a]
drop :: Int -> [a] -> [a]

splitAt :: Int -> [a] -> ([a], [a])
takeWhile :: (a -> Bool) -> [a] -> [a]
dropWhile :: (a -> Bool) -> [a] -> [a]

filter :: (a -> Bool) -> [a] -> [a]
map :: (a -> b) -> [a] -> [b]
zip :: [a] -> [b] -> [(a, b)]
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
unzip :: [(a, b)] -> ([a], [b])
words :: String -> [String]

