import Data.Char
import System.Random
{-
1. Consider a function funcIO :: IO String -> Int -> IO Int . Which is 
   valid implementation for this function?

A) funcIO x y = return y                    
B) funcIO x y = x >>= (return y)  
C) funcIO x y = x >> (return y)             
D) funcIO x y = do
     test <- x
     return y                         
E) funcIO x y = do
     test <- x
     return ((length test) * y)    

Answer: A , C, D, E

2. Consider an implementation funcIO x y = x y. Which is 
   valid type for this function implementation?

A) funcIO :: (a -> IO a) -> a -> IO a
B) funcIO :: (a -> b) -> a -> b
C) funcIO :: (IO a -> a) -> IO a -> a
D) funcIO :: (IO a -> IO b) -> IO a -> IO b
E) funcIO :: (IO a -> b) -> IO a -> b

Answer: A, B, C, D, E

3. Consider following List Comprehensions, and Calculate for which the result will be 25?  
A) foldr (\x rest -> if x == True then (5 + rest) else rest) 0 [even x | x <- [1..10]] 
B) length ([x | x <- [[1,2,3], [4, 5]], y <- x, z <- [1..3]])
C) length (filter even [x | x <- [1..10], y <- [1..5]])
D) foldr (\x rest -> if x == True then (rest * 5) else rest) 1 [even x | x <- [1..10]]
E) length (map even [x | x <- [1..5], y <- [6..10]])

Answer: A, C, E

4. Which function is part of the type class Show? 
A) showsPrec
B) show
C) showPair
D) showType
E) showList

Answer: A, B, E


5. Which of the following expressions will terminate? 
A) take 10 (take 10 [1..])
B) zip (zip [1..] [2..]) [[1..], [1,2,3], [4,5]]
C) let xList = 1 : xList in length xList
D) zip (zip [1..] [2..]) (zip [1..10] [1..])
E) let lazy = lazy ++ lazy in lazy

Answer: A, D
-}

-- 6.
testFuncIO = do
  x <- getLine
  if (length x > 10) then do 
    putStrLn "I have got Bigger String"
    return x
  else do
    putStrLn "I have got smaller String"
    result <- testFuncIO
    return result

testFuncIO' = getLine >>= \x -> (if (length x > 10) then putStrLn "I have got Bigger String" >> return x else 
  putStrLn "I have got smaller String" >> testFuncIO' >>= (\result -> return result)) 

--7. 
{-
(>>=) :: IO a -> (a -> IO b) -> IO b
(>>) :: IO a -> IO b -> IO b
return :: a -> IO a 
read :: Read a => String -> a
getLine :: IO String
show :: Show a => a -> String
putStrLn :: String -> IO ()
print :: Show a => a -> IO ()
-}

--8. 
{-
main = do
  putStr "Enter an user input: "
  input <- getLine
  print ([5,10..(read input)::Integer])

What are the output when user input will be : 
i) 1
ii) 5
iii) 10
iv) 50
v) asdf
vi) 21

-}

--9
boxStart :: IO ()
boxStart = do
  x <- getLine
  if (all isDigit x) then do
    let n = (read x)::Int
    putStrLn (createBox n n)
    ret <- boxStart
    return ret
  else do
    putStrLn "Please enter a Number"
    ret <- boxStart
    return ret

    
createBox :: Int -> Int -> String
createBox x y | x <= 1 = ['*' | _ <- [1..y]] ++ "\n"
              | x == y = ['*' | _ <- [1..y]] ++ "\n" ++ (createBox (x-1) y)
              | otherwise = "*" ++ [' ' | _ <- [1..(y-2)]] ++ "*\n" ++ (createBox (x-1) y)



--10
nimGame :: IO ()
nimGame = do
  putStrLn "Enter name of first player: "
  name1 <- getLine
  putStrLn "Enter name of Second player: "
  name2 <- getLine
  randomNumber <- randomIO :: IO Int
  let curRand = randomNumber `mod` 10
  list <- initializeGame (max 3 curRand)
  let turn = randomNumber `mod` 2
  result <- loopGame name1 name2 turn list
  putStrLn ("Congratulations!! " ++ result ++ ", You are the King!!")


initializeGame :: Int -> IO [Int]
initializeGame n = makeList []
  where
    makeList xs | length xs == n = return xs
                | otherwise = do
                    randomNumber <- randomIO :: IO Int
                    let curRand = ((randomNumber `mod` 10) + 1)
                    ret <- makeList (xs ++ [curRand])
                    return ret

getInt :: IO Int
getInt = do 
  str <- getLine
  if (all isDigit str) then return ((read str)::Int)
  else do
    putStrLn "Enter a number, please!"
    ret <- getInt
    return ret

showPileStatus :: [Int] -> String
showPileStatus list = let strList = ["     " ++ [chr(x + 64)] | x <- [1..(length list)]] 
                                    ++ ["\n"]
                                    ++ ["     " ++ (show x) | x <- list] 
                                    ++ ["\n"]
                      in foldr (\x rest -> x ++ rest) "" strList
  

loopGame :: String -> String -> Int -> [Int] -> IO String
loopGame name1 name2 turn list = do
  putStrLn (showPileStatus list)
  if (all (==0) list) then 
    if (turn == 0) then return name2
    else return name1
  else
    if turn == 0 then do
      putStrLn ("This is the turn for : " ++ name1 )
      (pile, num) <- getUserInput list
      let newList = updatePile list (pile, num)
      result <- loopGame name1 name2 1 newList
      return result
    else do
      putStrLn ("This is the turn for : " ++ name2 )
      (pile, num) <- getUserInput list
      let newList = updatePile list (pile, num)
      result <- loopGame name1 name2 0 newList
      return result


      
updatePile :: [Int] -> (Int, Int) -> [Int]
updatePile xs (p,q) = doIt xs 0
      where
        doIt [] _ = []
        doIt (y:ys) indx | p == indx = (y - q) : ys
                          | otherwise = y : (doIt ys (indx + 1))


getUserInput :: [Int] -> IO (Int, Int)
getUserInput list = do
  putStr "Select a Pile (Must be a Character): "
  pile <- getLine
  let curChar = head pile
      indx = (ord curChar) - 65
      availableResource = head (reverse (take (indx + 1) list))
  if (indx < 0 || indx >= (length list) || availableResource == 0) then do
    putStrLn "Please be careful about your input, try again!!"
    ret <- getUserInput list
    return ret
  else do
    putStr "Enter how many you want to remove: "
    num <- getInt
    if num > availableResource then do
      putStrLn "Please be careful about your input, try again!!"
      ret <- getUserInput list
      return ret
    else
      return (indx, num)

       
  

