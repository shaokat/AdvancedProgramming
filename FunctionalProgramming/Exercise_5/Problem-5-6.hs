
data BExp = Bool | And BExp BExp | Or BExp BExp | Not BExp

type Valuation = [(Int, Bool)]

--Write a function normalize :: BExp -> BExp that applies the 
--laws of boolean algebra in order to return 
--an expression where negation occurs for variables only.

