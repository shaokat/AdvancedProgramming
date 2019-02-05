import Data.Char

main :: IO ()
main = do 
    n <- guessNumber 42
    putStrLn ("You completed this on : " ++ show n ++ " tries!")

getInt :: IO Int
getInt = do
    str <- getLine
    if all isDigit str then do
        let num = read str :: Int
        return num
    else do
        putStrLn ("Enter a number")
        r <- getInt
        return r

guessNumber :: Int -> IO Int
guessNumber n = doIt 1
      where
        doIt t = do
            putStrLn "Your Guess!" 
            now <- getInt
            if now == n then do 
                putStrLn "Correct"
                return t
            else if now < n then do
                putStrLn "Too low"
                r <- doIt (t+1)
                return r
            else do
                putStrLn "Too high"
                r <- doIt (t+1)
                return r

another = do
    str <- getLine
    print ([read str :: Int ..])



