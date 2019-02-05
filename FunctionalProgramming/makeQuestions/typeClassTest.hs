{-
O|X|.
.|O|X
O|X|.
-}

-- "OX..OXOX."
-- String

--((0,0), 'O')
--[((Int, Int), Char)]
 
--0, 'O',
--[(Int, Char)]

data GameBoard = Value [(Int, Char)] 

--O|X|.\n.|O|X\nO|X|.\n

val1 :: GameBoard
val1 = Value [(0, 'O'), (1, 'X'), (2, '.'), (3, '.'), (4, 'O'), (5, 'X'), (6, 'O'), (7, 'X'), (8, '.')]


func1:: [(Int,Char)] -> String
func1 []  = ""
func1 ((x,y):xys) = y : func1 xys

func2 :: String -> String
func2 []           = []
func2 (x:(y:(z:xyzs))) = [x] ++ ['|'] ++ [y] ++ ['|'] ++ [z] ++ ['\n'] ++ (func2 xyzs)

instance (Show GameBoard) where
    show (Value (xs)) = func2 (func1 xs)



data Vehicle = Cycle (Int, Int) | Bus (Int, Int, Int, Int, Int, Int) | Auto (Int, Int, Int, Int) deriving (Show)

class CalculateVehicle where 
    calculateWheelPrice :: a -> Int

instance CalculateVehicle where
    calculateWheelPrice (Cycle (x,y)) = x + y



