getLine' :: IO String
getLine' =
  getChar >>= \ c ->       -- c = getChar
  if c == '\n' then
    return ""              -- return ""
  else
    getLine' >>= \ str ->  -- str = getChar
    return (c : str)       -- return (c : str)

test :: IO String
test = do
    c <- getChar
    if c == '\n' then return ""
    else do
        str <- getLine'
        return (c : str)

fac' :: Int -> IO Int
fac' 0 = do
           print 1
           return 1
fac' n = do
           x <- fac'(n-1)
           let now = n * x
           print now
           return now


sequenceIO :: [IO a] -> IO [a]
sequenceIO [] = return []
sequenceIO (x:xs) = do
                      act <- x
                      acts <- sequenceIO xs
                      return (act : acts)


mapIO :: (a -> IO b) -> [a] -> IO [b]
mapIO f [] = return []
mapIO f (x:xs) = do 
    act <- f x
    acts <- mapIO f xs
    return (act: acts)

--mapIO (\x -> putStrLn ("Now the number is " ++ show x)) [1,2,3,4]

filterIO :: (IO a -> Bool) -> [IO a] -> [IO a]
filterIO p [] = []
filterIO p (x : xs) | p x       = x : (filterIO p xs)
                    | otherwise = (filterIO p xs)  