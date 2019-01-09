readNonEmptyOriginal :: IO String
readNonEmptyOriginal = do
  str      <- getLine
  nonEmpty <- if null str
              then do putStrLn "Please insert a non-empty string"
                      readNonEmptyOriginal
              else return str
  return nonEmpty


readNonEmpty :: IO String
readNonEmpty = getLine >>= \str -> (if null str then 
                                   putStrLn "Please insert a non-empty string" >> readNonEmpty
                                   else return str) >>= \nonEmpty -> return nonEmpty


readNonEmptySimplified :: IO String
readNonEmptySimplified = do
    str      <- getLine
    if null str then do putStrLn "Please insert a non-empty string"
                        readNonEmptySimplified
                else return str