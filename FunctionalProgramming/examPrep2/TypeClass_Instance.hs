--From the lecture Note: 
data IntTree = Empty | Node IntTree Int IntTree

instance Eq IntTree where
    Empty == Empty                                      = True
    Node lTree1 val1 rTree1 == Node lTree2 val2 rTree2  = val1 == val2 && lTree1 == lTree2 && rTree1 == rTree2
    _                       == _                        = False

    leftData                /= rightData                = not (leftData == rightData)



--From the Assignment

data JSON = JNull
            | JBool Bool
            | JInt Int
            | JFloat Float
            | JString String
            | JArray [JSON]
            | JObject [(String, JSON)] deriving Show


--define Class named ToJSON consists one instance

class ToJSON a where
    toJSON :: a -> JSON

instance ToJSON JSON where
    toJSON = id

instance ToJSON Bool where
    toJSON x = JBool x

instance ToJSON Int where
    toJSON x = JInt x

instance ToJSON Float where
    toJSON x = JFloat x

--instance (ToJSON Char) => ToJSON [Char] where
--    toJSON x = JString x

instance (ToJSON a) => ToJSON [a] where
    toJSON xs = JArray (map (toJSON) xs)

instance (ToJSON a, ToJSON b) => ToJSON (a,b) where
    toJSON (x,y) = JObject [("First: ", toJSON x), ("Second: ", toJSON y)]

data Tree a = EmptyLeaf | Branch (Tree a) a (Tree a)

instance (ToJSON a) => ToJSON (Tree a) where
    toJSON EmptyLeaf = JNull
    toJSON (Branch lTree val rTree) = JObject [("leftTree ", toJSON lTree),
                                             ("val ", toJSON val),
                                             ("rightTree ", toJSON rTree)]


--data Rose a = Rose a [Rose a]
