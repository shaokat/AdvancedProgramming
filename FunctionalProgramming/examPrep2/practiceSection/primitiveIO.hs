import System.Random;
import Control.Concurrent;
import Data.List;

type Pos = (Int, Int)

maxScatter :: Int
maxScatter = 70

goto :: Pos -> IO ()
goto (x , y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

hitEnter :: IO ()
hitEnter = do 
                   randomNumber1 <- randomIO :: IO Int
                   randomNumber2 <- randomIO :: IO Int
                   let
                     x = randomNumber1 `mod` maxScatter
                     y = randomNumber2 `mod` maxScatter
                   goto (x,y)
                   --str <- getLine
                   threadDelay 100000
                   goto (x,y)
                   putStrLn ("*")
                   hitEnter


