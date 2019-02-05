{-
1. Which of the following expressions will yield a type error?

A) Just [[5,5],[1,2]]                             valid
B) Just (Just (Just Nothing))                     valid
C) Just Nothing                                   valid
D) Just Just Just Nothing                         not Valid
E) (Just Nothing, Just ("Haskell", 1))            valid

2. Which of the following expressions will yield a type error?
A) [(1:1:[])] ++ [[2]]                            valid
B) ['a', 'b', 'c'] ++ "de"                        valid
C) "abc" : ["de"]                                 valid
D) (chr 97) : "bc"                                valid
E) [([True, False], 1)] : [([True, False], 1)]    not valid

3. Which of the following statements are correct? 
A) foldr (\x y -> x - y) 2 [5, 10, 15] = 8         valid
B) foldl (\x y -> x - y) 2 [5, 10, 15] = -28       valid
C) foldr (\x y ->  2 * x - y) 1 [5, 10, 15] = 19   valid
D) foldl (\x y ->  2 * x - y) 1 [5, 10, 15] = -47  valid
E) :t foldr = (a -> b -> b) -> b -> [a] -> a       not valid


4. Which of the following statements will generate [True, True, False]
A) map even [2,4,7]                                                             --valid
B) map id [True, True, False]                                                   --valid
C) filter (\(x,y) -> y > 10) [(False, 5), (True, 15), (True, 20), (False, 25)]  --not valid
D) filter (\x -> True) [True, True, False]                                      --valid
E) fst (snd ("DeepLevel", [True, True, False]) , "TopLevel")                    --valid

5. What are the valid types of this function? func p (y:ys) = (p y) : ys
A) func :: (a -> a) -> [a] -> [a]                   --valid
B) func :: (a -> a) -> ([a] -> [a])                 --valid
C) func :: (Int -> Bool) -> [Bool] -> [Bool]        --not valid
D) func :: (Int -> Int) -> [Int] -> [Int]           --valid
E) func :: (Int -> Int) -> [Int] -> [Bool]          --not valid

-}

-- 7.
funcTest :: (a -> Bool) -> [a] -> [a]
funcTest _ [] = []
funcTest p (x:xs) | p x       = x : (x : funcTest p xs)
                  | otherwise = x : (funcTest p xs) 



--8. 
data Tree a = Leaf a | Branch (Tree a) (Tree a)
{-
                     B
                
         B                          B 


     B        B              B          B     
             
  L2  L4  L5    L8        L1   L4    L3    L12

-}
val1 :: Tree Int
val1 = Branch 
       (
           Branch 
             (Branch (Leaf 2) (Leaf 4)) 
             (Branch (Leaf 5) (Leaf 8))
       ) 
       (
           Branch 
             (Branch (Leaf 1) (Leaf 4))  
             (Branch (Leaf 3) (Leaf 12))
       )

--2
count :: (Tree Int) -> (Int,Int)
count (Leaf x) | even x    = (1, 0)
               | otherwise = (0, 1)
count (Branch lt rt) = let 
                         (x,y) = count lt
                         (p, q) = count rt
                        in (x+p, y+q)
--2
difference :: (Tree Int) -> (Tree Int) -> Int
difference tree1 tree2 = (sumTree tree1) - (sumTree tree2)

sumTree :: (Tree Int) -> Int
sumTree (Leaf x) = x
sumTree (Branch lt rt) = (sumTree lt) + (sumTree rt)

--2
unzipTree  :: Tree (Int,Int) -> (Tree Int, Tree Int)
unzipTree (Leaf (x, y)) = ((Leaf x), (Leaf y))
unzipTree (Branch tl tr) = let 
                                     (treeOneLeft, treeTwoLeft) = unzipTree tl
                                     (treeOneRight, treeTwoRight) = unzipTree tr
                                    in ((Branch treeOneLeft treeOneRight) , (Branch treeTwoLeft treeTwoRight))

--4
newReplicate :: Int -> [Int]
newReplicate n | n < 0     = error "Not valid input"
               | n == 0    = []
               | otherwise = doIt 1
                           where
                              doIt x | x == n    = (replicate x x)
                                     | otherwise = (replicate x x) ++ (doIt (x+1))

--5
wordList :: String -> [String]
wordList xs = doIt xs [] []
            where
                doIt [] cur ans                 = ans ++ [cur]
                doIt (y:ys) cur ans | y == ' '  = doIt ys [] (ans ++ [cur])
                                    | otherwise = doIt ys (cur ++ [y]) ans


--2
isSublist :: (Eq a) => [a] -> [a] -> Bool
isSublist [] _ = False
isSublist (x:xs) ys = isPrefix (x:xs) ys || (isSublist xs ys)


isPrefix :: (Eq a) => [a] -> [a] -> Bool
isPrefix [] [] = True
isPrefix [] _ = False
isPrefix _ [] = True
isPrefix (x:xs) (y:ys) | x == y = isPrefix xs ys
                       | otherwise = False



wordList2 :: String -> [String]
wordList2 [] = []
wordList2 xs = let 
                 (p, q) = takeNext xs
                in p : (wordList2 q)


takeNext :: String -> (String, String)
takeNext [] = ([], [])
takeNext (x:xs) | x == ' '  = ([], xs)
                | otherwise = let 
                                (p, q) = takeNext xs
                              in (x:p, q)