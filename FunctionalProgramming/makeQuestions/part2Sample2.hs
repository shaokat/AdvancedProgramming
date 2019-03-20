import Data.Char
import System.Random


makeDesign :: IO ()
makeDesign = do 
    input <- getLine
    let val = (read input)::Int
    if even val then 
        putStrLn (generatePile val) 
    else
        putStrLn (generateCross val)
    makeDesign

--5 marks
generateCross :: Int -> String
generateCross n = topPart n ++ (s (n `div` 2)) ++ "*\n" ++ bottomPart n


topPart :: Int -> String
topPart n = doIt (n - 2) 0
    where
        doIt x sp | x <= 0    = ""
                  | otherwise = (s sp) ++ "*" ++ (s x) ++ "*\n" ++ doIt (x-2) (sp + 1)


bottomPart :: Int -> String
bottomPart n = doIt 1 ((n `div` 2) - 1)
    where
        doIt x sp | x >= (n - 1)    = ""
                  | otherwise = (s sp) ++ "*" ++ (s x) ++ "*\n" ++ doIt (x+2) (sp-1)

s :: Int -> String
s n = [' '| _ <- [1..n]]

--2 marks
generatePile :: Int -> String
generatePile n = doIt n
  where
    doIt x | x == 0    = ""
           | otherwise = "*" ++ [' ' | _ <- [1..n-2]] ++ "*\n" ++ (doIt (x-1))





--Lazy Evaluation
--[0, 1, 1, 2, 4]
--3 marks

evaluateLazy :: [Integer] -> [Integer]
evaluateLazy input = input ++ (doIt (sum input))
    where 
        doIt x = x : doIt (x+x)



--List Comprehension
--5
{-
[(x,y,z) | x <- [1..5] ,  (y,z) <- (zip [1..x] [x,(x-1)..1])]
[(1,1,1),(2,1,2),(2,2,1),(3,1,3),(3,2,2),(3,3,1),(4,1,4),(4,2,3),(4,3,2),(4,4,1),(5,1,5),(5,2,4),(5,3,3),(5,4,2),(5,5,1)]

[(x,y, x*y) | x <- [1..4], y <- [4,3..1]]
[(1,4,4),(1,3,3),(1,2,2),(1,1,1),(2,4,8),(2,3,6),(2,2,4),(2,1,2),(3,4,12),(3,3,9),(3,2,6),(3,1,3),(4,4,16),(4,3,12),(4,2,8),(4,1,4)]

[x | x <- [1..144], 144 `mod` x == 0]
[1,2,3,4,6,8,9,12,16,18,24,36,48,72,144]

[ x*y | x <- [1,2,3,4], y <- [3,5,7,9]]
[3,5,7,9,6,10,14,18,9,15,21,27,12,20,28,36]

[(x,y) | x <- [1,3,5,7], y <- [2,4,6,8], x<y]
[(1,2),(1,4),(1,6),(1,8),(3,4),(3,6),(3,8),(5,6),(5,8),(7,8)]
-}

--2
getRandomInt :: IO Int
getRandomInt = do
    rNum <- randomIO :: IO Int
    let curRand = rNum `mod` 100
    return curRand

getRandomInt':: IO Int
getRandomInt' = (randomIO :: IO Int) >>= \rNum ->
    ( return (rNum `mod` 100))

testAnother :: IO Int
testAnother = (randomIO :: IO Int) >>= \rNum -> let curRand = rNum `mod` 100
    in return curRand

--3
testFunc :: IO Int
testFunc = do
    input <- getLine
    if (all isDigit input) then
         return (read input)
    else do
        putStrLn "Digit!"
        ret <- testFunc
        return ret

testFunc'  :: IO Int
testFunc' = getLine >>= \input -> if (all isDigit input) then return (read input)
                                  else putStrLn "Digit!" >> testFunc' >>= \ret -> return ret


--Game Part
-- 8 marks
--Game with the concept of tower of Hanoi

startingPoint :: IO ()
startingPoint = do
    rNum <- randomIO :: IO Int
    let curRand = max 3 (rNum `mod` 6)
    stacks <- initializeStack curRand
    tries <- gamePlay curRand stacks
    putStrLn ("Solved in " ++ (show tries) ++ " tries!!")

gamePlay :: Int -> [[Int]] -> IO Int
gamePlay n stacks = doIt stacks 1
    where 
        doIt stks tries = do
            putStrLn (generateGameStatus stks)
            if (isCompleted  n stks) then do
                return tries
            else do
               putStr "Enter from which stack you want to move pile: "
               from <- getInt
               putStr "Enter to which stack you want to put pile: "
               to <- getInt
               let newStks = updateStack from to stks
               ret <- doIt newStks (tries + 1)
               return ret


isCompleted :: Int -> [[Int]] -> Bool
isCompleted n (p:q:r:[]) | r == [x | x <- [n,(n-1)..1]] = True
                         | otherwise = False

updateStack :: Int -> Int -> [[Int]] -> [[Int]]
updateStack from to (p:q:r:[]) | from == 1 && to == 2 = let 
                                                           q' = q ++ [(last p)]
                                                           p' = take ((length p) - 1) p
                                                         in (p' : q' : r:[])

                               | from == 1 && to == 3 = let 
                                                            r' = r ++ [(last p)]
                                                            p' = take ((length p) - 1) p
                                                          in (p' : q : r':[])
                               | from == 2 && to == 1 = let 
                                                            p' = p ++ [(last q)]
                                                            q' = take ((length q) - 1) q
                                                          in (p' : q' : r:[])
                               | from == 2 && to == 3 = let 
                                                            r' = r ++ [(last q)]
                                                            q' = take ((length q) - 1) q
                                                          in (p : q' : r':[])
                               | from == 3 && to == 1 = let 
                                                            p' = p ++ [(last r)]
                                                            r' = take ((length r) - 1) r
                                                          in (p' : q : r':[])
                               | from == 3 && to == 2 = let 
                                                            q' = q ++ [(last r)]
                                                            r' = take ((length r) - 1) r
                                                          in (p : q' : r':[])
                               | otherwise            =   (p : q : r:[])

generateGameStatus :: [[Int]] -> String
generateGameStatus (p:q:r:[]) = "1st Stack: " ++ (listToString p) ++ "\n" ++
                             "2nd Stack: " ++ (listToString q) ++ "\n" ++
                             "3rd Stack: " ++ (listToString r) ++ "\n"

listToString :: [Int] -> String
listToString [] = ""
listToString (x:xs) = "  " ++ (show x) ++ (listToString xs)

initializeStack :: Int -> IO [[Int]]
initializeStack n = return [ [x | x <- [n,(n-1)..1]], [], [] ]

getInt :: IO Int
getInt = do
    input <- getLine
    if (all isDigit input) then
         return (read input)
    else do
        putStrLn "Digit!"
        ret <- getInt
        return ret