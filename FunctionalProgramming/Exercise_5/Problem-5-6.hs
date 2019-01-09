
data BExp = Lit Bool 
            | Var Int 
            | And BExp BExp 
            | Or BExp BExp 
            | Not BExp      deriving Show
type Valuation = [(Int, Bool)]

input1 :: BExp
input1 = Not (Or (Var 1)  (Var 2))

input2 :: BExp
input2 = Not (And (Not (Or (Var 1)  (Var 2)))  ((Or (Var 3)  (Var 4))))

val2 :: Valuation
val2 = [(1, True), (2, False), (3, False), (4, True)]  



normalize :: BExp -> BExp
normalize (Lit bl)        = Lit bl
normalize (Var n)         = Var n
normalize (Not (Var n)) = Not (Var n)

normalize (And exp1 exp2) = And (normalize exp1) (normalize exp2)
normalize (Or exp1 exp2)  = Or (normalize exp1) (normalize exp2)
normalize (Not expr)       = normalize (doIt expr)
                           where
                             doIt (Lit bl) = Lit (not bl)
                             doIt (Var n) =  Not (Var n)
                             doIt (And exp1 exp2) = Or (doIt exp1) (doIt exp2)
                             doIt (Or exp1 exp2) = And (doIt exp1) (doIt exp2)
                             doIt (Not expr) = expr


vars :: BExp -> [Int]
vars (Var i) = [i]
vars (Lit bl) = []
vars (And expr1 expr2) = (vars expr1) ++ (vars expr2)
vars (Or expr1 expr2) = (vars expr1) ++ (vars expr2)
vars (Not expr) = vars expr

-- value val2 input2

value :: Valuation -> BExp -> Bool
value v (Var i)  = findOnvaluation i v
value v (Lit bl) = bl
value v (And expr1 expr2) = (value v expr1) && (value v expr2)
value v (Or expr1 expr2) = (value v expr1) || (value v expr2)
value v (Not expr) = not (value v expr)
 

findOnvaluation :: Int -> [(Int,Bool)] -> Bool
findOnvaluation n ((x,y):xys) = if n ==  x then y
                          else findOnvaluation n xys
                          
                          
                          --[ [(Int, Bool)] ]
allValuations :: [Int] -> [Valuation]
allValuations xs = doIt xs [] [] 
                where
                    doIt [] ans now     = ans ++ [now]
                    doIt (x:xs) ans now = (doIt xs ans (now ++ [(x, True)] )) ++ (doIt xs ans (now ++ [(x, False)]))

allValuationsSandra :: [Int] -> [Valuation]
allValuationsSandra []     = [[]]
allValuationsSandra (v:vs) = [(v,x):xs | x <- [True, False], xs <- allValuationsSandra vs]

satisfiable :: BExp -> [Valuation]
satisfiable expr = doIt expr  (allValuations (makeUnique (vars expr)))
                  where
                    doIt expr [] = []
                    doIt expr (x:xs) | (value x expr) == True = x : (doIt expr xs)
                                     | otherwise              = (doIt expr xs)
makeUnique :: [Int] -> [Int]
makeUnique (x:xs) = x: (filter (/=x) xs)

{-

                                     []
                            /                  \
                           /                    \
                    (1, False)                (1, True)
                     /       \              /           \
                    /         \            /             \
            (2, False)       (2, True)  (2, False)       (2, True)    




[1, 2, 3]
 => 

-}

{-
normalize :: BExp -> BExp
normalize (And b1 b2) = And (normalize b1) (normalize b2)
normalize (Or  b1 b2) = Or  (normalize b1) (normalize b2)
normalize (Not b)     = normalize (negate b)
                      where 
                        negate (Lit b) = Lit (not b)
                        negate (Var i) = Not (Var i)
                        negate (And b1 b2) = Or  (negate b1) (negate b2)
                        negate (Or  b1 b2) = And (negate b1) (negate b2)
                        negate (Not b)     = b

normalize b = b      

normalize (Not (Or (Var 1)  (Var 2))) -> normalize (negate (Or (Var 1)  (Var 2)))
                                      -> normalize (And (negate (Var 1)) (negate (Var 2)))
                                      -> normalize (And (Not (Var 1)) (Not (Var 2)))
                                      -> And (normalize (Not (Var 1)) ) (normalize (Not (Var 2)))
                                      -> And (normalize (negate (Var 1))) (normalize (negate (Var 2)))
                                      -> 

-}

