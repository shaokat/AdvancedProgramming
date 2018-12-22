import Control.Monad  
import Data.Char  
import System.Random


wordList :: [String]
wordList = ["hello", "world", "hangman", "kiel", "university", 
            "informatik", "masters", "haskell", "advanced", "programming"]


main = do
    startGame
    putStrLn "Press 'y' to play again"
    userWish <- getLine
    putStrLn ("You have choosen: " ++ userWish)
    when (userWish == "y") main

startGame :: IO ()
startGame = do
               randomNumber <- randomIO :: IO Int
               let 
                   curRand = randomNumber `mod` (length wordList)
                   secretWord = getElementByIndex curRand wordList
                   guessedStr = "" 
                   
               theGame secretWord guessedStr
               return ()

theGame :: String -> String -> IO ()
theGame sWord gWord  = do
                    putStrLn ("Secret: " ++ (showSecretWord sWord gWord))
                    if (isCompleted sWord gWord) then do
                        putStrLn("Solved in " ++ (show (length gWord) ) ++ " tries.")
                        return ()
                    else do
                        putStrLn ("Enter a Character: ")
                        str <- getLine
                        if (length str) > 1 then do
                            putStrLn ("Please enter single character")
                            theGame sWord gWord 
                        else do
                            let curGWord = gWord ++ (map (toLower) str)
                            theGame sWord curGWord


isCompleted :: String -> String -> Bool
isCompleted [] _ = True
isCompleted (x:xs) g | elem x g  = True && isCompleted xs g
                     | otherwise = False
showSecretWord :: String -> String -> String
showSecretWord [] _ = []
showSecretWord (x:xs) g | elem x g  = x : showSecretWord xs g
                        | otherwise = '*' : showSecretWord xs g 


getElementByIndex :: Int -> [a] -> a
getElementByIndex _ [] = error "Element not Found" 
getElementByIndex 0 (x:xs) = x 
getElementByIndex n (x:xs) = getElementByIndex (n-1) xs

