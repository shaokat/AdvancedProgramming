dtoB:: Int -> [ Bool ]

dtoB 1 = [True]

dtoB n = if odd n then 
             dtoB (div (n-1) 2) ++ [True]
         else 
             dtoB (div n 2) ++ [False]