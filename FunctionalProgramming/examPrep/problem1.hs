
type KVS a b = a -> Maybe b

empty :: KVS a b
empty = (\x -> Nothing)

-- insert x s = \y -> if x == y then True else s y

insert :: Eq a => a -> b -> (KVS a b) -> (KVS a b)
insert x y s = \z -> if x == z then Just y else s z


remove :: Eq a => a -> (KVS a b) -> (KVS a b)
remove x s = \z -> if x == z then Nothing else s z

find :: a -> (KVS a b) -> Maybe b
find x s = s x

fromList :: Eq a => [(a, b)] -> KVS a b
fromList [] = empty
fromList ((x,y): xys) = insert x y (fromList xys)

toList :: KVS Int String -> [(Int, Maybe String)]
toList s = doIt [1..100]
         where
            doIt [] = []
            doIt (x:xs) | find x s == Nothing = doIt xs 
                        | otherwise = (x, (find x s)) : doIt xs


