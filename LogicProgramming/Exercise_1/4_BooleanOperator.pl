and(false, false, false).
and(false, true, false).
and(true, false, false).
and(true, true, true).

or(false, false, false).
or(false, true, true).
or(true, false, true).
or(true, true, true).

not(false, true).
not(true, false).



%(x∧y)∨z
%(x∧y)∨((y∧z)∧z)
%(x∧(¬y)∧z)∨((z∧y)∨z)


ex1(X,Y,Z,Res) :- and(X,Y,Res1), or(Res1, Z, Res).
ex2(X,Y,Z,Res) :- add(X,Y,Res1), and(Y, Z, Res2), and(Res2, Z, Res3), or(Res1, Res3, Res).
ex3(X,Y,Z,Res) :- not(Y, Res1), and(X, Res1, Res2), and(Res2, Z, Res3), and(Z, Y, Res4), or(Res4, Z, Res5), or(Res3, Res5, Res).



%ex1(true,false,true,Res).
%ex2(true,false,true,Res).
%ex3(true,false,true,Res).
%ex3(X,Y,Z,Res).