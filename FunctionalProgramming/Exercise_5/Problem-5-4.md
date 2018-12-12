```
--Reduction
double n = n + n

{-
1. 
double (double 3)
=> (double 3) + (double 3)
=> (3 + 3) + (double 3)
=> 6 + (double 3)
=> 6 + (3 + 3)
=> 6 + 6
=> 12

2.
double (double 3)
=> double (3 + 3)
=> double 6
=> 6 + 6
=> 12

3. double (double 3)
=> double (3 + 3)
=> (3 + 3) + (3 + 3)
=> 6 + (3 + 3)
=> 6 + 6
=> 12
-}
```