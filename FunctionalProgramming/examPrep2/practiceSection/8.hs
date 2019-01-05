--getNonEmptyLine :: IO String
--getNonEmptyLine = do
--  input  <- getLine
--  result <- if null input
--              then do
--                putStrLn "Please enter a non-empty string."
--                getNonEmptyLine
--              else return input
--  return result


getNonEmptyLine :: IO String
getNonEmptyLine = getLine >>= \input -> 
                         if null input then 
                             putStrLn "str" >> getNonEmptyLine
                          else
                            return input >>= \result -> return result

--getLine = do c <- getChar
--if c == '\n'
--then return ""
--else do cs <- getLine
--return (c:cs)

getLine = getChar >>= \c -> if c == '\n' then return "" 
                            else getLine >>= \cs -> return (c:cs)