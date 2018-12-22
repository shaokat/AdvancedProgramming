diamond :: Int -> IO ()
diamond n = if n == 0 then
               return ()
            else
                putStrLn((topPortion n (n-1) 1) ++ (bottomPortion (n) 1 (n-1)))
                
blankpace :: Int -> String
blankpace n | n <= 0    = ""
            | otherwise = " " ++ (blankpace (n-1))

star :: Int -> Int -> String
star len n | n == 1    = "*"
           | n == len  = "* " ++ (star len (n-1))
           | otherwise = "  " ++ (star len (n-1))

topPortion :: Int -> Int -> Int -> String
topPortion total sp st | st > total = ""
                       | otherwise  = let 
                                        now = (blankpace sp ++ star st st) ++ "\n"
                                      in now ++ (topPortion total (sp-1) (st+1))
                              
                         

bottomPortion :: Int -> Int -> Int -> String
bottomPortion total sp st | sp >= total = ""
                          | otherwise   = let 
                                            now = (blankpace sp ++ star st st) ++ "\n";
                                          in now ++ (bottomPortion total (sp+1) (st-1))
                                