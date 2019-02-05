add(o     , N     , N     ) .
add(N     , o     , N     ) .
add(pos(M), pos(N), pos(K)) :- lessP(M, K), lessP(N, K), addP(M, N, K).

addP(i   , i   , o(i)) .
addP(i   , o(N), i(N)) .
addP(o(M), i   , i(M)) .
addP(i   , i(N), o(K)) :- addP(i, N, K).
addP(o(M), o(N), o(K)) :- addP(M, N, K).
addP(o(M), i(N), i(K)) :- addP(M, N, K).
addP(i(M), i   , o(K)) :- addP(i, M, K).
addP(i(M), o(N), i(K)) :- addP(M, N, K).
addP(i(M), i(N), o(K)) :- addP(i, M, J), addP(J, N, K).

sub(M, N, K) :- add(N, K, M).


less(o     , pos(_)) .
less(pos(M), pos(N)) :- lessP(M, N).

lessP(i   , o(_)) .
lessP(i   , i(_)) .
lessP(o(M), o(N)) :- lessP(M, N).
lessP(o(M), i(M)) .
lessP(o(M), i(N)) :- lessP(M, N).
lessP(i(M), o(N)) :- lessP(M, N).
lessP(i(M), i(N)) :- lessP(M, N).