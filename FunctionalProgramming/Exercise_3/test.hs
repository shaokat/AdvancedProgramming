
testBinToDec :: [Bool] -> Int
testBinToDec [True] = 1
testBinToDec (x:xs) = if x == True then 2 * testBinToDec xs + 1 else 2 * testBinToDec xs