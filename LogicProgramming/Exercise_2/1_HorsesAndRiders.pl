add(z , Y, Y).
add(s(X), Y, s(Z)) :- add(X,Y,Z).

mult(z, Y, z).
mult(X, z, z).
mult(s(X), Y, Z) :- mult(X,Y,A), add(A, Y, Z).

%mult(s(s(s(z))), s(s(s(z))), Z).

%s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(z))))))))))))))))))))
%s(s(s(s(s(s(s(s(z))))))))

puzzle(Legs, Heads, Rider, Horses) :- add(Rider, Horses, Heads), mult(s(s(s(s(z)))), Horses, HCount), mult(s(s(z)), Rider, RCount), add(HCount, RCount, Legs).

%['1_HorsesAndRiders.pl'].
%puzzle(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(z)))))))))))))))))))),  s(s(s(s(s(s(s(s(z)))))))), Rider, Horse ).