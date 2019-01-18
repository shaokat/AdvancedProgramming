import Data.List

--Definition of Function Composition
--Some necessary knowledge 
-- https://prime.haskell.org/wiki/TypeDirectedNameResolution

-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \ x -> f (g x)
-- (.) f g = f . g = f (g x)
-- (f.) = ((.) f) 
-- (f.) . (g.) = ((f . g) .)
-- (f . g) x = f (g x)
--  (.x)  =  (\f -> f.x)
-- (.x) f is equivalent to f.x

--Example 1:
desort :: (Ord a) =>  [a] -> [a]
desort = (reverse . sort)
-- equivalent implementation
--desort xs = reverse (sort xs)




--Example 2:
{-
h x y = f (g x y) which is valid for this expression

a) f . g 
b) (f.) . g  
c) (.) f (.g)  
d) f (.g) 

Answer: 
a) f . g = \x -> f (g x)  it needs only one parameter 

b) (f.) . g = (.) (f.) g
            = \x -> (f.) (g x)
            = \x -> ((.) f) (g x)
            = \x -> (.) f (g x)           //no need of this bracket
            = \x -> (\y -> f ((g x) y) )
            = \x -> (\y -> f (g x y) )    // ((g x) y) can be rewritten to (g x y)
            = \x y -> f (g x y)           // rewrite nested lambda into single
            = (that's what we want)

c) (.) f (.g) = \x -> f ((.g) x)
              = \x -> f (x . g)
              = \x -> f ((.) x g)
              = (It's clear that it's going to wrong direction)

d) f (.g) = \x -> f (.g) x
          = \x -> f ((.g) x)
          = \x -> f (x . g)
          = (It's clear that it's going to wrong direction)

-}

--Example 3: 
{-
\x y -> f (g x) y, where f and g are global functions.

\x y -> f (g x) y  = \x -> f (g x)
                   = \x -> (f . g) x
                   = (f . g)
-}

--Example 4:
{-
\x y -> f (g (h x y)), where f, g and h are global functions.

\x y -> f (g (h x y)) = \x y -> f (g ((h x) y))
                      = \x y -> f (g ((h x) y))
                      = \x y -> f ( (g . (h x)) y)
                      = \x y -> ( f . (g . (h x)) ) y
                      = \x ->  f . (g . (h x))
                      = \x ->  f . ((.) g (h x)) 
                      = \x ->  f . ( ((.) g) (h x) )
                      = \x ->  f . ( (((.) g) . h) x )
                      = \x ->  (.) f  ( (((.) g) . h) x )
                      = \x ->  ((.) f)  ( (((.) g) . h) x )
                      = \x ->  ( ((.) f) . (((.) g) . h) ) x
                      = ((.) f) . (((.) g) . h)
                      = (f.) . ( (g.) . h )
                      = (f.) . (g.) . h   // right bracket unneccessary
                      = ((f . g) .) . h


-} 

--Example 5:
{-
\f g x -> g (f x) to function composition expression

\f g x -> g (f x)  = \f g x -> (g . f) x
                   = \f g -> (g . f)
                   = \f g -> (.) g f
                   = \f g -> flip (.) f g
                   = \f -> flip (.) f
                   = flip (.)

-} 

--Example 6:
{-
(flip id) to using lambda functions

flip id = \x -> flip id x
        = \x f -> flip id x f
        = \x f -> id (f x)
        = \x f -> f x
-}


--Example 7:
{-
(.) . (.) (also called "the owl") to using lambda functions

(.) . (.)  = \f -> ((.) . (.)) f 
           = \f -> (.) ( (.) f)
           = \f -> (.) (f.)
           = \f g -> (.) (f.) g
           = \f g ->  (f.) . g
           = \f g x ->  ((f.) . g) x
           = \f g x ->  (f.)  (g x)
           = \f g x y ->  (f.)  (g x) y
           = \f g x y ->  ((.) f)  (g x) y
           = \f g x y ->  (.) f  (g x) y
           = \f g x y ->  f ((g x) y)
           = \f g x y ->  f (g x y)
-}