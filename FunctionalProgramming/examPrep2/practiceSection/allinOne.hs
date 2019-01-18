import Data.List
import Data.Maybe

--Assignment 4

data JSON = JNull
          | JBool Bool
          | JInt Int
          | JFloat Float
          | JString String
          | JArray [JSON]
          | JObject [(String, JSON)]
  deriving Show


class ToJSON a where 
    toJSON :: a -> JSON

instance ToJSON Bool where
    toJSON bl = JBool bl

instance ToJSON Int where
    toJSON n = JInt n

instance ToJSON Float where
    toJSON fl = JFloat fl


--instance ToJSON [Char] where
--    toJSON str = JString str

instance ToJSON a => ToJSON [a] where
    toJSON xs = JArray (map (toJSON) xs)

instance (ToJSON a, ToJSON b) => ToJSON (a,b) where 
    toJSON (x,y) = JObject [("fst ", toJSON x), ("snd ", toJSON y)]


data Tree a = Empty | Node (Tree a) a (Tree a) deriving (Show)

instance ToJSON a => ToJSON (Tree a) where 
    toJSON Empty = JNull
    toJSON (Node lt x rt) = JObject [ ("lf ", toJSON lt),
                                      ("val ", toJSON x),
                                      ("rt ", toJSON rt)
                                     ]
tree1 :: Tree Bool
tree1 =  Node (Node Empty True Empty) True (Node Empty False Empty)

-------------------------------------------------------------------------------------------------------

data Rose a = Rose a [Rose a] deriving (Show)


instance (Eq a) => Eq (Rose a) where 
    (==) (Rose x []) (Rose y []) = x == y
    (==) (Rose x xs) (Rose y ys) = x == y && xs == ys

--LT | EQ | GT

instance (Ord a) => Ord (Rose a) where 
    compare (Rose x xs) (Rose y ys) | compare x y == EQ = compare xs ys
                                    | otherwise         = compare x y



valRose :: Rose Int
valRose = (Rose 4 [Rose 5 [Rose 1 [Rose 11 [Rose 12 []] ], Rose 2 [], Rose 3 []], Rose 6 []])

valRose2 :: Rose Int
valRose2 = (Rose 4 [Rose 5 [Rose 1 [], Rose 2 [], Rose 3 []], Rose 6 []])

class Pretty a where
    pretty :: a -> String

instance Pretty Int where
    pretty input = show input

instance (Show a, Pretty a) => Pretty (Rose a) where
    pretty input = doIt 0 input

doIt :: (Show a) => Int -> (Rose a) -> String
doIt lvl (Rose x []) = generatePrefix (lvl)  ++ (show x) ++ "\n"
doIt lvl (Rose x xs) = generatePrefix (lvl)  ++ (show x) ++ "\n" ++ (callForAll (lvl+1) xs )

callForAll ::(Show a) => Int -> [Rose a] -> String
callForAll lvl [] = ""
callForAll  lvl (x:xs) = (doIt lvl x) ++ (callForAll lvl xs)

generatePrefix :: Int -> String 
generatePrefix n | n <= 0    = ""
                 | n == 1    = "+-- "
                 | otherwise = "|   " ++ generatePrefix (n-1)

type Set a = a -> Bool

emptySet :: Set Int
emptySet = (\x -> False)

lostSet :: Set Int
lostSet = \x -> elem x [4, 8, 15, 16, 23, 42]

insert :: Eq a => a -> Set a -> Set a
insert x st = (\y -> y == x || st y)

remove :: Eq a => a -> Set a -> Set a
remove x st = (\y -> if y == x then False else st y)

isElem :: a -> Set a -> Bool
isElem x st = st x

union :: Set a -> Set a -> Set a
union st1 st2 = (\y -> isElem y st1 || isElem y st2)

intersection :: Set a -> Set a -> Set a
intersection st1 st2 = (\y -> isElem y st1 && isElem y st2)

complement :: Set a -> Set a
complement s = \y -> not (s y)

difference :: Set a -> Set a -> Set a 
difference st1 st2 = intersection st1 (complement st2)

listToSet :: Eq a => [a] -> Set a
listToSet xs = (\y -> elem y xs)

setToList :: Set Int -> [Int]
setToList st =  doIt [1..] 
            where 
                doIt [] = []
                doIt (x:xs) | isElem x st = x : (doIt xs)
                            | otherwise   = doIt xs

--not possible


--Function composition
{-
\x y -> f (g x) y
\x -> f (g x)
f .g

\x y -> f (g (h x y))
\x y -> f ( g ((h x) y) )
\x y -> f (  g . (h x)  y)
\x y -> f . (  g . (h x))  y
\x -> f . (  g . (h x))
\x -> f . (  g . (h x) )
\x -> f . ( (.) g  (h x) )
\x -> f . ( (.) g . h x )
\x -> ((.) f) ( (.) g . h x )
\x -> (.) f . (.) g . h x
(.) f . (.) g . h
(f.) . (g.) . h
((f . g) .) . h

\f g x -> g (f x)
\f g x -> (g . f) x
\f g -> (.) g  f
\f g -> flip (.) f g
flip (.)


flip id = \x -> flip id x
        = \x f -> flip id x f
        = \x f -> id (f x)
        = \x f -> f x

(.) . (.)  = \f -> ((.) . (.)) f
           = \f -> (.) ( (.) f)
           = \f -> (.) ( f .)
           = \f g -> ((.) ( f .)) g
           = \f g -> ( f .) . g
           = \f g x ->  ((f.) . g) x
           = \f g x ->  (f.)  (g x)
           = \f g x y ->  (f.)  (g x) y
           = \f g x y ->  (.) f  (g x) y
           = \f g x y ->  f (g x y)
-}


--Assignment 5:

--allcombination

--allCombinations [True,False]
allCombinations :: [a] ->  [[a]]
allCombinations list = [[]] ++ doIt [[]]
                      where
                        doIt now = let 
                                      cur = dividAll list now
                                    in cur ++ (doIt cur)


dividAll :: [a] -> [[a]] -> [[a]]
dividAll [] list = []
dividAll (x:xs) list = (addToall x list) ++ (dividAll (xs) list)

--[True]

--[[True, False], [False, False]] 

addToall :: a -> [[a]] -> [[a]]
addToall x [] = []
addToall x (y:ys) = (y ++ [x]) : (addToall x ys)



--avalanche

--take 10 avalanche
--[1,3,5,7,9,15,21,25,27,35]

avalanche :: [Int]
avalanche = doIt [1]
         where
            doIt (x:xs) =x :  doIt (sort (makeUnique ([x*3, x*5, x*7] ++ xs)))

makeUnique :: [Int] -> [Int]
makeUnique [] = []
makeUnique (x:xs) = x : makeUnique (filter (/=x) xs)


--Boolean EXp

data BExp = Lit Bool | Var Int | And BExp BExp | Or BExp BExp | Neg BExp deriving (Show)



input1 :: BExp
input1 = Neg (Or (Var 1)  (Var 2))

input2 :: BExp
input2 = Neg (And (Neg (Or (Var 1)  (Var 2)))  ((Or (Var 3)  (Var 4))))

val2 :: Valuation
val2 = [(1, True), (2, False), (3, False), (4, True)]  




normalize :: BExp -> BExp
normalize (Lit x) = (Lit x)
normalize (Var x) = (Var x)
normalize (Neg (Var x)) = (Neg (Var x))
normalize (And x y) = And (normalize x) (normalize y)
normalize (Or x y) = Or (normalize x) (normalize y)
normalize (Neg x) = normalize (doIt x)
             where
                doIt (Lit x) = Lit (not x)
                doIt (Var x) = Neg (Var x)
                doIt (And x y) = Or (doIt x) (doIt y)
                doIt (Or x y) = And (doIt x) (doIt y)
                doIt (Neg x) = x

vars :: BExp -> [Int]
vars (Lit x) = []
vars (Var x) = [x]
vars (Neg x) = (vars x)
vars (And x y) = (vars x) ++ (vars y)
vars (Or x y) = (vars x) ++ (vars y)

type Valuation = [(Int, Bool)]

--[(1, True), (2, False)]

value :: Valuation -> BExp -> Bool
value v (Lit x) = x 
value v (Var x) = (getValueByVar v x)
value v (And x y) = (value v x) && (value v y)
value v (Or x y) = (value v x) || (value v y)
value v (Neg x) = not (value v x)

getValueByVar :: Valuation -> Int -> Bool 
getValueByVar [] n = error "Not found"
getValueByVar ((x,y):xys) n | x == n    = y
                            | otherwise = getValueByVar xys n

--[ [(Int, Bool)] ]

allValuations :: [Int] -> [Valuation]
allValuations list = doIt list []
                 where
                    doIt []  now = [now]
                    doIt (x:xs) now = (doIt xs (now ++ [(x , True)])) ++ (doIt xs (now ++ [(x , False)])) 

satisfiable :: BExp -> [Valuation]
satisfiable expr = let 
                     allVars = vars expr
                     vv = allValuations allVars
                   in doIt vv
                where
                    doIt [] = []
                    doIt (x:xs) | (value x expr) == True = x : doIt xs
                                | otherwise = doIt xs

-- Assignment 6
-- Hangman
--hangman "hallo"

hangman :: String -> IO ()
hangman sWord = startGame sWord ""
                 
startGame :: String -> String -> IO ()
startGame sWord gWord = do 
                         putStrLn ("Secrete: " ++ (printSecretWord sWord gWord))
                         if (isCompleted sWord gWord) then 
                            putStrLn ("Solved in " ++ show (length gWord) ++ "tries.")
                         else do
                            putStr ("Enter a character: ")
                            str <- getLine
                            startGame sWord (gWord ++ str)



printSecretWord :: String -> String -> String
printSecretWord [] gWord = ""
printSecretWord (x:xs) gWord | (elem x gWord) =  x : printSecretWord xs gWord
                             | otherwise      = '*': printSecretWord xs gWord

isCompleted :: String -> String -> Bool
isCompleted [] gWord = True
isCompleted (x:xs) gWord  | elem x gWord = isCompleted xs gWord
                          | otherwise    = False 

--diamond
diamond :: Int -> IO ()
diamond n  | n < 1 = return ()
           | n == 1 = putStrLn ("*")
           | otherwise = putStrLn ((topPart n) ++ (downPart n))


addSpace :: Int -> String 
addSpace n = [' ' | _ <- [1..n]]

addStar :: Int -> String 
addStar n = ['*' | _ <- [1..n]]

downPart :: Int -> String
downPart n = doIt 1 ((n - 3) * 2 + 1)
           where
             doIt sp x | x == -1 = (addSpace sp) ++ "*\n"
                       | otherwise =  (addSpace sp) ++ "*" ++ (addSpace x) ++ "*\n" ++ doIt (sp+1) (x - 2)
                        


topPart :: Int -> String
topPart n = doIt (n-1) (-1)
          where 
            doIt sp x | x == -1 = (addSpace sp) ++ "*\n" ++ doIt (sp-1) (x + 2)
            doIt sp x | sp == 0 =  "*" ++ (addSpace x) ++ "*\n"
                      | otherwise =  (addSpace sp) ++ "*" ++ (addSpace x) ++ "*\n" ++ doIt (sp-1) (x + 2)
                      
                      
tree :: Int -> IO ()
tree n = putStrLn ( (topTree n) ++ (bottomTree n))

topTree :: Int -> String
topTree n = doIt 1 (n-1)
          where
            doIt x sp | sp == 0 = addStar ((x-1) * 2 + 1) ++ "\n"
                      | otherwise = addSpace sp ++ addStar ((x-1) * 2 + 1) ++ "\n" ++ doIt (x+1) (sp - 1)

bottomTree :: Int -> String
bottomTree n = doIt (n - 1) (n-2)
          where
            doIt sp x | x == 0 = addSpace sp ++ "*\n"
                      | otherwise = addSpace sp ++ "*\n" ++ doIt sp (x - 1)

{-
[[3],[5],[7],[9],[11]]
[(5,False),(20,True),(25,False)]
[Just 1,Just 9,Just 25]
[(1,5),(1,4),(1,3),(1,2),(2,5),(2,4),(2,3),(3,5),(3,4),(4,5)]
[ ... | i <- [1 .. 5], ...]

Define the functions map, lookup (Link), replicate (Link) and filter using 
list comprehensions. If necessary, use the (predefined) function listToMaybe from Data.Maybe
-}

listVal1 = [ [i * 2 + 1] | i <- [1 .. 5]]
listVal2 = [ (i * 5, even i) | i <- [1 .. 5], i /= 2 && i /= 3]
listVal3 = [ (Just (i*i) ) | i <- [1 .. 5], i /= 2 && i /= 4]
listVal4 = [ (i, j) | i <- [1 .. 5], j <- [5,4..2], i<j]

myMap :: (a -> b) -> [a] -> [b]
myMap f xs = [f x | x <- xs]

myLookup :: Eq a => a -> [(a,b)] -> Maybe b
myLookup x xs = listToMaybe [q | (p,q) <- xs, p == x]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p xs = [y | y <- xs , p y]

myReplicate :: Int -> a -> [a]
myReplicate n x = [x | y <- [1..n]]

getNonEmptyLine :: IO String
getNonEmptyLine =
  getLine >>= \input ->
  if null input
    then putStrLn "Please enter a non-empty string." >> getNonEmptyLine
    else return input >>= \result ->
  return result


getNonEmptyLine2 :: IO String
getNonEmptyLine2 = do
   input <- getLine
   result <- if null input then do
                putStrLn "Please enter a non-empty string."
                getNonEmptyLine2
            else
                return input
   return result

data Peano = Z | S (Peano) deriving (Show)

peano1 = (S (S (S (S Z))))
peano2 = (S (S (S Z)))

addPeano :: Peano -> Peano -> Peano 
addPeano Z y     = y
addPeano (S x) y = S (addPeano x y)   


multPeano :: Peano -> Peano -> Peano
multPeano Z y = Z 
multPeano (S x) y = addPeano y (multPeano x y)

{-
ghci> ss
"2 + 8 * (4 + 1) * 2"
-}
data Exp = Num Int
    | Add Exp Exp 
    | Mul Exp Exp
    
instance Show Exp where
   show (Num x) = show x
   show (Add x1 x2) = show x1 ++ " + " ++ show x2
   show (Mul x1 (Add x2 x3)) = show x1 ++ " * " ++ "(" ++ show x2 ++  " + " ++ show x3 ++ ")"
   show (Mul x1 x2) =  show x1 ++ " * " ++ show x2

class SemiGroup a where
    (<+>) :: a -> a -> a

class SemiGroup a => Monoid a where
    neutral :: a

instance SemiGroup Peano where
    Z <+> m = m
    S n <+> m = S (n <+> m)




perm :: Eq a => [a] -> [[a]]
perm xs = ( helperPerm xs [] 0 )

helperPerm :: [a] -> [a] -> Int -> [[a]]
helperPerm [] ys indx = [ys]
helperPerm xs ys indx | (length xs) == (indx + 1) = (helperPerm (removeElemFromListByIndex indx xs) ((getValueByIndex indx xs):ys) 0)
                      | otherwise                 = (helperPerm (removeElemFromListByIndex indx xs) ((getValueByIndex indx xs):ys) 0) ++ (helperPerm xs ys (indx + 1))

getValueByIndex :: Int -> [a] -> a
getValueByIndex indx [] = error "Input is wrong"
getValueByIndex indx (x:xs) | indx == 0 = x
                    | otherwise  = getValueByIndex (indx - 1) xs

removeElemFromListByIndex :: Int -> [a] -> [a]
removeElemFromListByIndex n [] = []
removeElemFromListByIndex n (x:xs) | n == 0 = xs
                        | otherwise  = x : (removeElemFromListByIndex (n-1) xs) 


makeUnique2 :: Eq a => [[a]] -> [[a]]
makeUnique2 [] = []
makeUnique2 (l:ls) = l : (filter (/= l) (makeUnique2 ls))