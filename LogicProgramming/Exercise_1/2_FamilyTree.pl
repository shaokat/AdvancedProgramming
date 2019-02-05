
mother(birgit,annika).
mother(birgit,ole).
mother(birgit,mats).
mother(christel,birgit).
mother(christel,carsten).
mother(maria,frank).
mother(sandra,lea).
mother(luise,christel).

married(birgit,frank).
married(christel,rolf).
married(maria,herbert).
married(sandra,carsten).

father(V,Child) :- married(M,V), mother(M,Child).

grandmother(GM,Child) :- mother(GM,M), mother(M,Child).
grandmother(GM,Child) :- mother(GM,V), father(V,Child).

male(P) :- married(_,P).
male(ole).
male(mats).

female(P) :- married(P,_).
female(annika).
female(lea).

brother(B,P) :- male(B), mother(M,B), mother(M,P), B \= P.

sister(S,P) :- mother(M,S), mother(M,P), S\=P, female(S). 

uncle(O,Child) :- mother(M,Child), brother(O,M).
uncle(O,Child) :- father(V,Child), brother(O,V).
uncle(O,Child) :- aunt(A,Child), married(A,O).

aunt(A,Child) :- sister(A,M), mother(M,Child).
aunt(A,Child) :- sister(A,V), father(V,Child).
aunt(A,Child) :- uncle(O,Child), married(A,O).

son(S,P) :- mother(P, S), male(S).
son(S,P) :- father(P, S), male(S).

daughter(D,P) :- mother(P,D), female(D).
daughter(D,P) :- father(P,D), female(D).

cousin(C,P) :- aunt(A, P), son(C,A).
cousin(C,P) :- aunt(A, P), daughter(C,A).
cousin(C,P) :- uncle(A, P), son(C,A).
cousin(C,P) :- uncle(A, P), daughter(C,A).

brother_in_law(B,P) :- male(P), married(X, P), brother(B, X).
brother_in_law(B,P) :- female(P), married(P, X), brother(B, X).

parent(C,P) :- mother(C,P).
parent(C,P) :- father(C,P).

ancestor(N,V) :- parent(N,V).
ancestor(N,V) :- parent(N,E), ancestor(E, V).

/*                      
                                          luise
                                          /
                                         /
herbert + maria            rolf  +  christel
           \                     /        \
            \                   /          \
            frank     +  birgit           carsten + sandra
                     /    |   \                      /
                    /     |    \                    /
                 annika  ole   mats               lea
*/

append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).


lookup(K,KVs,V) :- append(_,[(K,V)|_],KVs).

%first solution
member2V1(E,L) :- append(_,[E|R],L), append(_,[E|_],R).

%another solution
member(E, [E|_]).
member(E, [_|Xs]) :- member(E, Xs).
member2V2(E, [E|Xs]) :- member(E, Xs).
member2V2(E, [_|Xs]) :- member2V2(E, Xs).

reverse([],[]).
reverse([X|Xs],Zs) :- reverse(Xs,Ys), append(Ys,[X],Zs).

reverse2(Xs,Zs) :- reverseAcc(Xs,[],Zs).
reverseAcc([],Ys,Ys).
reverseAcc([X|Xs],Ys,Zs) :- reverseAcc(Xs,[X|Ys],Zs).

prefix(Xs, XsYs) :- append(Xs, Ys, XsYs).
suffix(Xs,YsXs) :- append(Ys,Xs,YsXs).

sublist(Xs,Ys) :- prefix(Xs,Ys).
sublist(Xs, [Y|Ys]) :- sublist(Xs,Ys).

