add(o   , Y, Y   ) .
add(s(X), Y, s(Z)) :- add(X,Y,Z).

% Multiplying two  Peano numbers
mult(o   , _, o) .
mult(s(X), Y, Z) :- mult(X, Y, A), add(A, Y, Z).
%mult(X,Y,s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(s(o))))))))))))))))))))).

%b e a 

exponent(B, o, s(o)).
exponent(o, E, o).
exponent(B, s(N), A) :- exponent(B, N, BN), mult(BN, B, A).


minimum(N1, N2, N1) :- N1=<N2.
minimum(N1, N2, N2) :- N2=<N1.

