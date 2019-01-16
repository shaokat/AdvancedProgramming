

primeList :: [Int]
primeList = [ x | x <- [2..], isPrime x]

isPrime :: Int -> Bool
isPrime n = (length [x | x <- [1..n], n `mod` x == 0]) == 2


primeSieve :: [Int]
primeSieve = doIt [2..]
               where
                 doIt [] = []
                 doIt (x:xs) = x : doIt (filter (\y -> y `mod` x /= 0) xs)