%1. Potter and Malfoy do not want to join the board together.
%2. Malfoy is only available for the board if Granger becomes chairperson.
%3. Weasley will only join the board if Potter also belongs to it.
%4. Potter does not want to join the board if Granger becomes the secretary.
%5. Granger does not join the board if Weasley becomes chairperson.

player(potter).
player(malfoy).
player(granger).
player(weasley).

isNotSame(X1, X2) :- player(X1), player(X2), X1 \= X2.

isUnique(gameBoard(Chairperson, Secretary, Ordinary))
  :- isNotSame(Chairperson, Secretary), isNotSame(Secretary, Ordinary), isNotSame(Ordinary, Chairperson).

isPlayingOnBoard(P, gameBoard(P, _, _)).
isPlayingOnBoard(P, gameBoard(_, P, _)).
isPlayingOnBoard(P, gameBoard(_, _, P)).

isNotPlayingOnBoard(P, gameBoard(Chairperson, Secretary, Ordinary)) 
  :- Chairperson \= P, Secretary \= P, Ordinary \= P.

isChairperson(P, gameBoard(Chairperson, _, _)) :- P == Chairperson.
isNotChairperson(P, gameBoard(Chairperson, _, _)) :- P \= Chairperson.

isSecretary(P, gameBoard(_, Secretary, _)) :- P == Secretary.
isNotSecretary(P, gameBoard(_, Secretary, _)) :- P \= Secretary.

conditionPotterAndMalfoy(V) :- isPlayingOnBoard(potter, V), isNotPlayingOnBoard(malfoy, V).
conditionPotterAndMalfoy(V) :- isPlayingOnBoard(malfoy, V), isNotPlayingOnBoard(potter, V).
conditionPotterAndMalfoy(V) :- isNotPlayingOnBoard(malfoy, V), isNotPlayingOnBoard(potter, V).

conditionMalfoyAndGranger(gameBoard(granger, Secretary, Ordinary)) 
  :- isPlayingOnBoard(malfoy, gameBoard(granger, Secretary, Ordinary)).
conditionMalfoyAndGranger(V) :- isNotPlayingOnBoard(malfoy, V).

conditionWeasleyAndPotter(V) :- isPlayingOnBoard(potter, V), isPlayingOnBoard(weasley, V).
conditionWeasleyAndPotter(V) :- isNotPlayingOnBoard(potter, V), isNotPlayingOnBoard(weasley, V).

conditionPotterAndGranger(V)
  :- isNotSecretary(granger, V), isPlayingOnBoard(potter, V).
conditionPotterAndGranger(V)
  :- isSecretary(granger, V), isNotPlayingOnBoard(potter, V).

conditionWeasleyAndGranger(V)
  :- isChairperson(weasley, V), isNotPlayingOnBoard(granger, V).
conditionWeasleyAndGranger(V) 
  :- isNotChairperson(weasley, V), isPlayingOnBoard(granger, V).

solution(V) :- 
    isUnique(V),
    conditionPotterAndMalfoy(V),
    conditionMalfoyAndGranger(V),
    conditionWeasleyAndPotter(V),
    conditionPotterAndGranger(V),
    conditionWeasleyAndGranger(V).


    
    

                      
