\x y -> f (g x) y
= \x -> f (g x)
= \x -> (f . g) x
= (f . g)


\x y -> f (g (h x y))
= \x y -> f (g (h x) y)
= \x y -> f ( g . (h x) ) y
= \x -> f (g . (h x))
= \x -> f ( (.) g (h x))
= \x -> f ( (.) g . h ) x)
= \x -> f . ( (.) g . h ) x
= f . ( (.) g . h )
= (.) f ( (.) g . h )
= (f.) ( (g.) . h )
= (f.) . (g.) . h


\x y -> f (g (h x y))
= \x y -> f (g ((h x) y))
= \x y -> f ((g . h x) y)
= \x y -> (f . (g . h x)) y
= \x   -> f . (g . h x)
= \x   -> f . ((.) g (h x))
= \x   -> f . (((.) g) (h x))
= \x   -> f . (((.) g . h) x)
= \x   -> ((.) f . ((.) g . h)) x
= (.) f . ((.) g . h)
= (f.) . (g.) . h
= ((f . g) .) . h

\f g x -> g (f x)  
= \f g x -> g . f x
= \f g -> g . f
= \f g -> flip 


flip id

= \x -> flip id x
= \x -> flip id x
= \x f -> flip id x f
= \x f -> id f x
= \x f -> f x





