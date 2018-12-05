{-
In this task, you can practice working with the function composition operator (.).

Define the following expressions without lambda expressions. 
The expression \x -> id x can be defined without lambdas, for example, as id.

\x y -> f (g x) y, where f and g are global functions.
\x y -> f (g (h x y)), where f, g and h are global functions.
\f g x -> g (f x)



Define an equivalent lambda expression for the following terms.
flip id
(.) . (.) (also called "the owl")

-}
import Prelude hiding ((.))
globalF1 :: a -> b -> c
globalF1 = undefined

globalG1 :: a -> b
globalG1 = undefined

func1 :: a -> b -> d
func1 x y = globalF1 (globalG1 x) y

globalF2 :: a -> b
globalF2 = undefined

globalG2 :: a -> b
globalG2 = undefined

globalH2 :: a -> b -> c
globalH2 = undefined

func2 :: a -> b -> c
func2 x y = globalF2 (globalG2 (globalH2 x y))

(.) ::(a -> b) -> (b -> c) -> a -> c
(f . g) x = g (f x) 

-- :t (flip id) :: b -> (b -> c) -> c
eqLambda :: b -> (b -> c) -> c
eqLambda = \x f -> f x

-- :t (.) . (.) :: (a -> b) -> ((a -> c1) -> c2) -> (b -> c1) -> c2
--eqLambda2 :: (a -> b) -> ((a -> c1) -> c2) -> (b -> c1) -> c2
--eqLambda2 = \f g h i  ->  f  