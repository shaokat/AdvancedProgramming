-- Type for number sets represented by an indicator function
type IntSet = Int -> Bool

lostSet :: IntSet
lostSet = \x -> elem x [4,8,15,16,23,42]

patrickSet :: IntSet 
patrickSet = \x -> elem x [44, 56, 23, 54]

-- Empty number set
empty :: IntSet
empty = \_ -> False

-- Insert number into number set
insert :: Int -> IntSet -> IntSet
insert x s = \y -> if x == y then True else s y

-- Test for a number in a number set
isElem :: Int -> IntSet -> Bool
isElem x s = s x

-- Build the union of two number sets
union :: IntSet -> IntSet -> IntSet
union s1 s2 = \x -> s1 x || s2 x 

-- Build the intersection of two number sets
intersection :: IntSet -> IntSet -> IntSet
intersection s1 s2 = \x -> s1 x && s2 x

-- Build the complement of a number set
complement :: IntSet -> IntSet
complement m = \x -> not (m x)

-- Build the difference of two number sets
difference :: IntSet -> IntSet -> IntSet
difference m n = intersection m (complement n)
-- difference m = intersection m . complement

-- Convert list of numbers to number set
listToSet :: [Int] -> IntSet
listToSet xs = \x -> x `elem` xs
-- listToSet xs x = x `elem` xs
-- listToSet = flip elem
