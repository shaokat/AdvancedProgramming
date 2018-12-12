isPalindrome :: String -> Bool
isPalindrome xs = xs == reverse xs

allAlphabet :: String 
allAlphabet = "abcdefghijklmnopqrstuvwxyz"
isPangram :: String -> Bool
isPangram xs = check allAlphabet
              where 
                check [] = True
                check (y:ys) = elem y xs && check ys


areAnagrams :: String -> String -> Bool
areAnagrams xs ys = qsort xs ==  qsort ys 

qsort :: (Ord a) => [a] -> [a]
qsort [] = [] 
qsort (x:xs) = qsort (smaller xs) ++ [x] ++ qsort (larger xs)
              where 
                smaller xs = [y | y <- xs, y <= x]
                larger xs = [y | y <- xs, y > x]


newisPangram :: String -> Bool
newisPangram s = all (`elem` s) ['a' .. 'z']