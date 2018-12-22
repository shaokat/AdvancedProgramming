

testFunc :: IO ()
testFunc = doIt ""

doIt :: String -> IO ()
doIt xs = do 
          {
              input <- getLine;
              if input == "break" then 
                putStrLn ("Final String: " ++ xs)
              else
                do
                    let now = xs ++ input
                    putStrLn now
                    doIt now
          }