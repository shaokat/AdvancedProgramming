import Control.Monad  
import Data.Char  
import System.Random

wordList :: [String]
wordList = ["hello", "world", "hangman", "kiel", "university", 
            "informatik", "masters", "haskell", "advanced", "programming"]

hangMan :: IO ()
hangMan = do
            startGame
            putStrLn "Do you want to playAgain (press y): "
            userWish <- getLine
            when (userWish == "y") hangMan

startGame :: IO ()
startGame = do
             randomNumber <- randomIO :: IO Int
             let curIndex = randomNumber `mod` (length wordList)
                 secretWord = wordList !! curIndex
                 guessedWord = ""
             playGame secretWord guessedWord

playGame :: String -> String -> IO ()
playGame sWord gWord = do
                        putStrLn ("Secret: " ++ (showCurrentStatus sWord gWord))
                        if (isCompleted sWord gWord) then do
                                putStrLn ("You completed in " ++ (show (length gWord)) ++ " tries" ) 
                                return ()
                        else
                            putStr "Enter a Char: " >> 
                            getLine >>= \gotStr -> (playGame sWord (gWord ++ gotStr))
                         

showCurrentStatus :: String -> String -> String
showCurrentStatus [] _ = []
showCurrentStatus (x:xs) gWord | elem x gWord = [x] ++ (showCurrentStatus xs gWord)
                               | otherwise    = "*" ++ (showCurrentStatus xs gWord)

isCompleted :: String -> String -> Bool
isCompleted [] _  = True
isCompleted (x:xs) gWord | elem x gWord = True && (isCompleted xs gWord)
                         | otherwise    = False