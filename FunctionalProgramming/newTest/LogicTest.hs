
data LExp a =   P a
                | Neg (LExp a)
                | (LExp a) :∨: (LExp a)
                | (LExp a) :∧: (LExp a)
                | (LExp a) :→: (LExp a)
                deriving (Show)


-- ((¬p ∧ q) ∨ (q → r)) ∧ (p ∨ ¬r)
expression1 :: LExp Char
expression1 = (( (Neg (P 'p')) :∧: (P 'q') ) :∨: ((P 'q') :→: (P 'r'))) :∧: ( (P 'p') :∨: (Neg (P 'r')) )

 --  ¬ (¬ (¬ p ∧ q) ∧ q ∧ ¬r)) ∧ ¬ (¬p ∧ r)
expression2 :: LExp Char 
expression2 =  (Neg (Neg ( (Neg (P 'p')) :∧: (P 'q')) :∧: (P 'q') :∧: (Neg (P 'r')))) :∧: (Neg ( (Neg (P 'p')) :∧: (P 'r')))

expression3 :: LExp Char
expression3 = (P 'p') :→: (P 'q')

expression4 :: LExp Char
expression4 = Neg (P 'p') :∨: (P 'q')

--  ((p → q) and (q → r)) and ( (r -> s) and (s -> p))
expression5 :: LExp Char
expression5 = (((P 'p') :→: (P 'q')) :∧: ((P 'q') :→: (P 'r')))  :∧:  (((P 'r') :→: (P 's')) :∧: ((P 's') :→: (P 'p')))

-- (¬p ∨ ¬q ∨ r) ∧ (q ∨ ¬q ∨ r) ∧ (p ∨ ¬r)
expression6 :: LExp Char
expression6 =(  (Neg (P 'p')) :∨: (Neg (P 'q')) :∨: (P 'r')  ) :∧:  (  (P 'q') :∨: (Neg (P 'q')) :∨: (P 'r')  ) :∧: ( (P 'p') :∨: (Neg (P 'r')))
getValueFor :: (Eq a) => a -> [(a, Bool)] -> Bool
getValueFor x ((f,s):rest) | x == f    = s
                           | otherwise = getValueFor x rest

valuation :: (Eq a) => LExp a -> [(a, Bool)] -> Bool
valuation (P x)              l  = (getValueFor x l)
valuation (Neg expr)         l  = not (valuation expr l)
valuation (expr1 :∨: expr2)  l  = (valuation expr1 l) || (valuation expr2 l)
valuation (expr1 :∧: expr2)  l  = (valuation expr1 l) && (valuation expr2 l)
valuation (expr1 :→: expr2)  l  = (not (valuation expr1 l)) || (valuation expr2 l)

propositionList :: LExp a -> [a]
propositionList (P x)              = [x]
propositionList (Neg expr)         = propositionList expr
propositionList (expr1 :∨: expr2)  = (propositionList expr1) ++ (propositionList expr2)
propositionList (expr1 :∧: expr2)  = (propositionList expr1) ++ (propositionList expr2)
propositionList (expr1 :→: expr2)  = (propositionList expr1) ++ (propositionList expr2)

makeUnique :: (Eq a) => [a] -> [a]
makeUnique [] = []
makeUnique (x:xs) = x : makeUnique (filter (/=x)  xs)


  --[ [(p,False), (q,False), (r,False)], [(p,False), (q, False), (r,True)] ] 

wholeTable :: [a] -> [ [(a, Bool)] ]
wholeTable xs = doIt xs []
              where 
                doIt [] cur = [cur]
                doIt (y:ys) cur = (doIt ys (cur ++ [(y, False)] )) ++  (doIt ys (cur ++ [(y, True)] ))


--                                            []
--     
--                     p False                                       p True
--     
--          q False               q True                  q False               q True
--     
--     r False    r True      r False    r True     r False    r True    r False    r True


eachValuation :: (Eq a) => LExp a -> [Bool]
eachValuation expr = doIt expr  (wholeTable (makeUnique (propositionList expr))) 
                  where
                    doIt expr [] = []
                    doIt expr (y:ys) = (valuation expr y) : (doIt expr ys)



-- ¬ (p ∧ ¬q ∧ ¬ (¬q ∧ ¬r)) ∧ ¬ (¬p ∧ r)
--         p q r  ¬ (p ∧ ¬q ∧ ¬ (¬q ∧ ¬r))          ¬ (¬p ∧ r)
--         0 0 0      1                                 1
--         0 0 1      1                                 0
--         0 1 0      1                                 1
--         0 1 1      1                                 0
--         1 0 0      1                                 1
--         1 0 1      0                                 1
--         1 1 0      1                                 1
--         1 1 1      1                                 1


-- ((¬p ∧ q) ∨ (q → r)) ∧ (p ∨ ¬r)
--         p q r  (¬p ∧ q)   (q → r)  ((¬p ∧ q) ∨ (q → r))         ((¬p ∧ q) ∨ (q → r)) ∧ (p ∨ ¬r)
--         0 0 0      1         1               1                                 1
--         0 0 1      1         1               1                                 0
--         0 1 0      1         0               1                                 1
--         0 1 1      1         1               1                                 0
--         1 0 0      1         1               1                                 1
--         1 0 1      0         1               1                                 1
--         1 1 0      0         0               0                                 0
--         1 1 1      1         1               1                                 1