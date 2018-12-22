christmasTree :: Int -> IO ()
christmasTree n = if n <= 2 then
               return ()
            else
                putStrLn((topPortion ((n-1)*2+1) (n-1) 1) ++ (bottomPortion (n-2) (n-1) 1))

-- 
                
blankpace :: Int -> String
blankpace n | n <= 0    = ""
            | otherwise = " " ++ (blankpace (n-1))

star :: Int -> String
star n | n == 1      = "*"
       | otherwise   = "*" ++ (star (n-1))

topPortion :: Int -> Int -> Int -> String
topPortion total sp st | st > total = ""
                       | otherwise  = let 
                                        now = (blankpace sp ++ star st) ++ "\n"
                                      in now ++ (topPortion total (sp-1) (st+2))
                              
                         

bottomPortion :: Int -> Int -> Int -> String
bottomPortion total sp st | total <= 0 = ""
                          | otherwise   = let 
                                            now = (blankpace sp ++ star st) ++ "\n";
                                          in now ++ (bottomPortion (total-1) sp st)
           