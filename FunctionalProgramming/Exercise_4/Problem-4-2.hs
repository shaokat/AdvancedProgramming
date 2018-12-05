
data Rose a = Rose a [Rose a]

instance (Eq a) => Eq (Rose a) where
    Rose a []     == Rose b []    = a == b
    Rose a restA  == Rose b restB = a == b && restA == restB
    _             == _            = False

instance (Ord a) => Ord (Rose a) where
    Rose a []     <= Rose b restB      =  True
    Rose a []     <= Rose b []        =  a <= b
    Rose a restA   <= Rose b []        =  False
    Rose a restA <= Rose b restB  =  a <= b || restA <= restB


tree1 :: Rose Int
tree1 = Rose 10 [(Rose 10 []), (Rose 15 [Rose 44 []])]

tree2 :: Rose Int
tree2 = Rose 10 [(Rose 10 []), (Rose 15 [Rose 42 []])]

tree3 :: Rose Int
tree3 = Rose 4 [Rose 5 [Rose 1 [], Rose 2 [], Rose 3 []], Rose 6 []]

treeLarge :: Rose Char
treeLarge = Rose 'R' 
        [
            Rose 'A' 
            [
                Rose 'G' [], 
                Rose 'H' 
                [
                    Rose 'P' [], 
                    Rose 'Q' 
                    [
                        Rose 'Y' [], 
                        Rose 'Z' []
                    ], 
                    Rose 'R' []    
                ], 
                Rose 'I' []
            ], 
            Rose 'B' 
            [
                Rose 'J' [], 
                Rose 'K' [], 
                Rose 'L' []
            ]
        ]

class Pretty a where 
    pretty :: a -> String

instance (Show a) => Pretty (Rose a) where 
    pretty wholeInput = helperPretty wholeInput 0


helperPretty :: (Show a) => (Rose a) -> Int -> String
helperPretty (Rose x []) level = (generatePrefix x level)
helperPretty (Rose x ys) level = (generatePrefix x level) ++ (twoDToOneD (myMap helperPretty ys (level+1)))

twoDToOneD :: [String] -> String
twoDToOneD [] = ""
twoDToOneD (x:xs) = x ++ twoDToOneD xs

myMap :: (a -> Int -> b) -> [a] -> Int -> [b]
myMap f [] _ = []
myMap f (x:xs) l = f x l : (myMap f xs l)

--vue and Level 
generatePrefix :: (Show a) =>  a -> Int -> String
generatePrefix n l = generatePrefix' n l 0
 where
   generatePrefix' v tl cl | tl == 0      = (show v)
                           | tl - cl == 1 && cl == 0 = "\n+-- " ++ (show v)
                           | tl - cl == 1 = "+-- " ++ (show v)
                           | cl == 0      = "\n|   " ++ generatePrefix' v tl (cl+1)
                           | otherwise    = "    " ++ generatePrefix' v tl (cl+1)