data Exp = Num Int
         | Exp :+: Exp   -- :+: is an infix constructor, similar to (:+:) Exp Exp
         | Exp :-: Exp
         | Exp :*: Exp
         | Exp :/: Exp

infix 4 :/:
infix 3 :*:
infix 2 :+:
infix 1 :-:

eval :: Exp -> Int
eval (Num x) = x

eval (x :+: y) = (eval x) + (eval y)
eval (x :-: y) = (eval x) - (eval y)
eval (x :*: y) = (eval x) * (eval y)
eval (x :/: y) = (eval x) `div` (eval y)


{-
TestInput
---------------
i) eval ((Num 5) :+: (Num 6) :*: (Num 4) :/: (Num 2))
ii) eval (((Num 5) :+: (Num 6)) :*: (Num 4))
ii) eval ((Num 5) :+: (Num 6) :*: (Num 4))

TestOutput
-----------------
i) 17
ii) 44
iii) 29
-}

eval2 :: Exp -> Maybe Int
eval2 (Num x) = Just x

eval2 (x :+: y) = helperEval2Add (eval2 x) (eval2 y)
eval2 (x :-: y) = helperEval2Sub (eval2 x) (eval2 y)
eval2 (x :*: y) = helperEval2Mult (eval2 x) (eval2 y)
eval2 (x :/: y) = helperEval2Div (eval2 x) (eval2 y)


helperEval2Add :: Maybe Int -> Maybe Int -> Maybe Int
helperEval2Add (Nothing) (Nothing) = Nothing
helperEval2Add (Just x) (Nothing) = Nothing
helperEval2Add (Nothing) (Just y) = Nothing
helperEval2Add (Just x) (Just y) = Just (x + y)

helperEval2Sub :: Maybe Int -> Maybe Int -> Maybe Int
helperEval2Sub (Nothing) (Nothing) = Nothing
helperEval2Sub (Just x) (Nothing) = Nothing
helperEval2Sub (Nothing) (Just y) = Nothing
helperEval2Sub (Just x) (Just y) = Just (x - y)

helperEval2Mult :: Maybe Int -> Maybe Int -> Maybe Int
helperEval2Mult (Nothing) (Nothing) = Nothing
helperEval2Mult (Just x) (Nothing) = Nothing
helperEval2Mult (Nothing) (Just y) = Nothing
helperEval2Mult (Just x) (Just y) = Just (x * y)

helperEval2Div :: Maybe Int -> Maybe Int -> Maybe Int
helperEval2Div (Nothing) (Nothing) = Nothing
helperEval2Div (Just x) (Nothing) = Nothing
helperEval2Div (Nothing) (Just y) = Nothing
helperEval2Div (Just x) (Just 0) = Nothing
helperEval2Div (Just x) (Just y) = Just (x `div` y)

{-
TestInput
---------------
i) eval2 ((Num 5) :+: (Num 6) :*: (Num 4) :/: (Num 0))
ii) eval2 ((Num 5) :+: (Num 6) :*: (Num 4) :/: (Num 2))

TestOutput
-----------------
i) Nothing
ii) Just 17
-}

applyDistributivityLaw :: Exp -> Exp
applyDistributivityLaw (Num x) = (Num x)
applyDistributivityLaw (((Num x) :+: (Num y)) :*: Num z) = ((Num x) :*: (Num z) :+: (Num y) :*: (Num z))
applyDistributivityLaw (((Num x) :-: (Num y)) :*: Num z) = ((Num x) :*: (Num z) :-: (Num y) :*: (Num z))
applyDistributivityLaw (((Num x) :+: (Num y)) :*: z) = ((Num x) :*: (applyDistributivityLaw z) :+: (Num y) :*: (applyDistributivityLaw z))
applyDistributivityLaw (((Num x) :-: (Num y)) :*: z) = ((Num x) :*: (applyDistributivityLaw z) :-: (Num y) :*: (applyDistributivityLaw z))
applyDistributivityLaw (x :+: y) = (applyDistributivityLaw x) :+: (applyDistributivityLaw y)
applyDistributivityLaw (x :-: y) = (applyDistributivityLaw x) :-: (applyDistributivityLaw y)
applyDistributivityLaw (x :*: y) = (applyDistributivityLaw x) :*: (applyDistributivityLaw y)
applyDistributivityLaw (x :/: y) = (applyDistributivityLaw x) :/: (applyDistributivityLaw y)


{-
TestInput
---------------
i) applyDistributivityLaw (((Num 4) :+: (Num 2)) :*: (((Num 1) :-: (Num 3) ) :*: (Num 4)))
i) applyDistributivityLaw (((Num 4) :+: (Num 2)) :*: (Num 1))

TestOutput
-----------------
i)Num 4 :*: (Num 1 :*: Num 4 :-: Num 3 :*: Num 4) :+: Num 2 :*: (Num 1 :*: Num 4 :-: Num 3 :*: Num 4)
ii) Num 4 :*: Num 1 :+: Num 2 :*: Num 1
-}