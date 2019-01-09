diamond :: Int -> IO ()
diamond x = putStrLn ((topStars x) ++ (downStars x))


addSpace :: Int -> String
addSpace n = [' '| _ <- [1..n]]



topStars :: Int -> String
topStars n = doIt 1
           where
             doIt x | x == 1 && n /= 0 = addSpace (n-x) ++ "*\n" ++ doIt (x+1)  
                    | x<=n = addSpace (n-x) ++ "*" ++ addSpace ((x-2)*2+1) ++ "*\n" ++ doIt (x+1) 
                    | otherwise = ""


downStars :: Int -> String
downStars n = doIt (n-1)
           where
             doIt x | x == 1 = addSpace (n-x) ++ "*\n" ++ doIt (x-1)  
                    | x>1 = addSpace (n-x) ++ "*" ++ addSpace ((x-2)*2+1) ++ "*\n" ++ doIt (x-1) 
                    | otherwise = ""

christMasTree :: Int -> IO ()
christMasTree x = putStrLn ((leafTree x) ++ (bodyTree x))

leafTree :: Int -> String
leafTree n = doIt 1
           where
            doIt x | elem n [0..2] = ""
                   | x<=n = addSpace (n-x) ++ (addStar (((x-1)*2)+1) ) ++ "\n" ++ doIt (x+1) 
                   | otherwise = ""

bodyTree :: Int -> String
bodyTree n = doIt (n-1) (n-2)
           where
             doIt s l | l < 1     = ""
                      | otherwise = (addSpace s) ++ "*\n" ++ doIt s (l-1) 

addStar :: Int -> String
addStar n = ['*' | _ <- [1..n]]