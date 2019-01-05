data JSON = JNull
          | JBool Bool
          | JInt Int
          | JFloat Float
          | JString String
          | JArray [JSON]
          | JObject [(String, JSON)]
  deriving Show


class ToJSON a where
    toJSON :: a -> JSON

instance ToJSON Bool where
    toJSON x = (JBool x)

instance ToJSON Int where
    toJSON x = JInt x

instance ToJSON Float where
    toJSON x = JFloat x

--instance ToJSON a => ToJSON [a] where
--    toJSON xs = JArray (map toJSON xs)

instance (ToJSON a) => ToJSON [a] where    
    toJSON [] = JArray []
    toJSON (x:xs) = concatTwoJArray (JArray [toJSON x]) (toJSON xs)

concatTwoJArray :: JSON -> JSON -> JSON
concatTwoJArray (JArray xs) (JArray ys) = JArray (xs ++ ys)

--polymorphic tuples (a, b)
--JObject [(String, JSON)]

--instance (Show a, ToJSON a, ToJSON b) => ToJSON (a,b) where
--    toJSON (x,y) = JObject [((show x),toJSON y)]

instance (ToJSON a, ToJSON b) => ToJSON (a,b) where
    toJSON (x,y) = JObject [("FirstValue ", toJSON x), ("SecondValue ", toJSON y)]


{-

toJSON [1 = x, xs: 2,3,4] = Fc (JArray [toJSON 1]) (toJSON [2 = x, xs: 3,4])
                          = Fc (Jarray [JInt 1]) (Fc (JArray [JInt 2])  (toJSON [3,4]))
                          = Fc (Jarray [JInt 1]) (Fc (JArray [JInt 2])  (Fc (JArray [JInt 3]) (toJSON [4])))
                          = Fc (Jarray [JInt 1]) (Fc (JArray [JInt 2])  (Fc (JArray [JInt 3]) ( Fc (JArray [JInt 4]  (toJSON []) ))))
                          = Fc (Jarray [JInt 1]) (Fc (JArray [JInt 2])  (Fc (JArray [JInt 3]) ( Fc (JArray [JInt 4]  (JArray []) ))))
                          = Fc (Jarray [JInt 1]) (JArray [JInt 2, JInt 3, JInt 4])
                          = JArray [JInt 1, JInt 2, JInt 3, JInt 4]


-}