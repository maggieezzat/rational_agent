isCell(X,Y,M,N):-
    X<M, 
    Y<N.

isLeftBorder(X,Y,M,N):-
    isCell(X,Y,M,N),
    Y is 0.

isRightBorder(X,Y,M,N):-
    isCell(X,Y,M,N),
    Y is N-1.

isTopBorder(X,Y,M,N):-
    isCell(X,Y,M,N),
    X is 0.

isBottomBorder(X,Y,M,N):-
    isCell(X,Y,M,N),
    X is M-1.