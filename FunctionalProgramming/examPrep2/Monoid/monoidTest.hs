myGetLine' :: IO String
myGetLine' = getChar >>= \x -> if (x == '\n') then 
                                   return []
                               else
                                   myGetLine >>= \xs -> return (x:xs)





myGetLine :: IO String
myGetLine = do x <- getChar
               if (x == '\n') then
                  return []
               else
                  do xs <- myGetLine
                     return (x : xs)

myGetLine2 :: IO String
myGetLine2 = getChar >>= \x ->
            (if (x == '\n') then
                return []
            else
                myGetLine2 >>= \xs -> return (x : xs))