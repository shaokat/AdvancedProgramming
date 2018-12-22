data IntTree = Leaf Int
             | Node IntTree IntTree deriving (Show)

testTree = Node (Node (Leaf 1) (Leaf 2)) (Leaf 3)

sumTree :: IntTree -> Int
sumTree (Leaf x) = x
sumTree (Node lt rt) = sumTree lt + sumTree rt

mirrorTree :: IntTree -> IntTree
mirrorTree (Leaf x) = (Leaf x)
mirrorTree (Node lt rt) = ( Node (mirrorTree rt) (mirrorTree lt) )

--A function for calculating all labels of an IntTree as a list of 
--Ints ([Int]). Also consider the runtime of your implementation 
--with regard to the number of tree nodes.

calculateLabel :: IntTree -> [Int]
calculateLabel (Leaf x) = [x]
calculateLabel (Node lt rt) = calculateLabel lt ++ calculateLabel rt 

count :: Int -> [Int] -> Int 
count _ [] = 0
count val (x:xs) | val == x = 1 + count val xs 
                 | otherwise = count val xs

remove :: Int -> [Int] -> [Int] 
remove val [] = []
remove val (x:xs) | val == x = remove val xs
                 | otherwise = x : remove val xs

sublist :: Int -> Int -> [Int] -> [Int]
sublist s e xs = drop s (take (e+1) xs) 

reversed :: [a] -> [a]
reversed lists = doIt lists []
            where
                doIt [] ys = ys 
                doIt (x:xs) ys = doIt xs (x:ys)


indexOf :: Int -> [Int] -> Maybe Int 
indexOf val list = doIt list 0
                 where 
                    doIt [] _ = Nothing
                    doIt (x:xs) indx | x == val  = Just indx 
                                     | otherwise = doIt xs (indx+1)

--25 => 11001
decToBinList :: Int -> [Bool]
decToBinList 0 = [False]
decToBinList 1 = [True]
decToBinList x | odd x = (decToBinList ((x - 1) `div` 2)) ++ [True]
               | otherwise = (decToBinList (x `div` 2)) ++ [False]

binListToDec :: [Bool] -> Int
binListToDec xs = doIt xs 0
                where
                    doIt [True] sum = sum + 1
                    doIt [False] sum = sum
                    doIt (x:xs) sum | x == True = doIt xs ((sum + 1) * 2)
                                    | otherwise = doIt xs (sum * 2)

data Binary = IHi | I Binary | O Binary deriving (Show)

five :: Binary
five = I (O IHi)

four :: Binary
four = O (O IHi)

intToBinary :: Int -> Binary
intToBinary 1 = (IHi)
intToBinary x | odd x = (I (intToBinary ((x - 1) `div` 2)))
              | otherwise = (O (intToBinary (x `div` 2)))

binaryToInt :: Binary -> Int
binaryToInt x = binListToDec (reverse (binaryToList x))

binaryToList :: Binary -> [Bool]
binaryToList (IHi) = [True]
binaryToList (I x) = True : binaryToList x
binaryToList (O x) = False : binaryToList x


data TreeZip a = LastBox a | InnerBox a (TreeZip a) (TreeZip a) deriving (Eq, Show)

treeZip1 :: TreeZip Int
treeZip1 = InnerBox 10000
            (InnerBox 1000
                (LastBox 7) 
                (LastBox 3)
            )
            (InnerBox 2000
                (InnerBox 100
                    (InnerBox 10 
                        (LastBox 4) 
                        (LastBox 5) 
                    )
                    (InnerBox 20
                        (LastBox 5)
                        (LastBox 4)
                    )
                )
                (LastBox 4)
            )


treeZip2 :: TreeZip Int
treeZip2 = InnerBox 99999
            (InnerBox 9999
                (LastBox 11) 
                (LastBox 19)
            )
            (InnerBox 8888
                (InnerBox 999
                    (InnerBox 99
                        (LastBox 37) 
                        (LastBox 23) 
                    )
                    (InnerBox 88
                        (LastBox 31)
                        (LastBox 41)
                    )
                )
                (LastBox 29)
            )


zipTree :: TreeZip Int -> TreeZip Int -> TreeZip (Int,Int)
zipTree (LastBox x) (LastBox y) = LastBox (x,y)
zipTree (InnerBox x txl txr) (LastBox y) = LastBox (x,y)
zipTree (LastBox x) (InnerBox y tyl tyr) = LastBox (x,y)
zipTree (InnerBox x txl txr) (InnerBox y tyl tyr) = (InnerBox (x,y) (zipTree txl tyl) (zipTree txr tyr))


unzipTree  :: TreeZip (Int,Int) -> (TreeZip Int, TreeZip Int)
unzipTree (LastBox (x,y)) = (LastBox x, LastBox y)
unzipTree (InnerBox (x,y) lt rt) = let 
                               (tree1left, tree2left) = unzipTree lt
                               (tree1right, tree2right) = unzipTree rt 
                              in (InnerBox x tree1left tree1right, InnerBox y tree2left tree2right)

