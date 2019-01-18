{-# LANGUAGE ParallelListComp #-}

var :: [(Int, Int)]
var = [(x,y) | x <- [1,2,3] | y <- [10,20]]

{-
     for(i = 0, j = 0 ; i < xs.size() && j < ys.size(); i++, j++)
     {
         print (xs[i], ys[i])
     }
-}

mySort :: Ord a => [a] -> [a]
mySort [] = []
mySort (x:xs) = (mySort (filter (<x) xs)) ++ [x] ++ (mySort (filter (>=x) xs))


genFib :: [Integer]
genFib = doIt 0 1
       where
         doIt n1 n2 = n1 : (doIt n2 (n1 + n2))

showClearly :: [Integer] -> IO ()
showClearly [] = return ()
showClearly (x:xs) = do
    putStrLn (show x)
    ret <- showClearly xs
    return ret


testIO :: IO ()
testIO = do
    putStrLn "Enter How many Fibs you want to watch: "
    str <- getLine
    let n    = read str :: Int
        list = take n genFib
    showClearly list
    testIO

--    [n1,n2 .. m] means fromThenTo n1 n2 m
fromThenTo :: Int -> Int -> Int -> [Int]
fromThenTo n1 n2 m = let 
                       d = n2 - n1
                     in if n2 > m then [n1]
                        else if n2 == m then [n1,n2]
                        else n1 : fromThenTo (n1+d) (n2+d) m