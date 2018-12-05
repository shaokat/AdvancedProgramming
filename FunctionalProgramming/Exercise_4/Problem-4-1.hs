data JSON = JNull
          | JBool Bool
          | JInt Int
          | JFloat Float
          | JString String
          | JArray [JSON]
          | JObject [(String, JSON)]
  deriving (Show)
  


class ToJSON a where
    toJSON :: a -> JSON

instance ToJSON JSON where
    toJSON = id

instance ToJSON Bool where
    toJSON val = JBool val

--instance ToJSON Int where
--    toJSON val = JInt val

instance ToJSON a => ToJSON [a] where
    toJSON xs = JArray (map toJSON xs)

instance (ToJSON a,ToJSON b) => ToJSON (a,b) where
    toJSON (a,b) = JArray [toJSON a, toJSON b]


--Node Labled
data Tree a = Empty | Node (Tree a) a (Tree a)

tree1 :: Tree Bool
tree1 =  Node (Node Empty True Empty) True (Node Empty False Empty)

instance ToJSON a => ToJSON (Tree a) where
    toJSON Empty = JArray []
    toJSON (Node lt x rt) = concats (concats (JArray [toJSON x]) (toJSON lt)) (toJSON rt)

concats :: JSON -> JSON -> JSON
concats (JArray xs) (JArray ys) = JArray (xs++ys)