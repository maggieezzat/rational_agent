:- include('kB.pl').

isCell(X,Y):-
    grid(M,N),
    X < M,
    X >= 0,
    Y < N,
    Y >= 0.

solve(S,R):-
    solve(S,1,R).
solve(S,Limit,R):-
    call_with_depth_limit(snapped(S), Limit, R),
    R \= depth_limit_exceeded.
solve(S,Limit,R):-
    L1 is Limit + 1,
    solve(S,L1,R).
    

:- discontiguous(iMan/3).
:- discontiguous (isStone/3).

iMan(X,Y,result(collect,S)):-
    iMan(X,Y,S),
    isStone(X,Y,S).

iMan(X,Y,result(A,S)):-
    A = left,
    iMan(W,Z,S),
    Y is Z-1,
    X is W,
    isCell(X,Y).

iMan(X,Y,result(A,S)):-
    A = right,
    iMan(W,Z,S),
    X is W,
    Y is Z + 1,
    isCell(X,Y).

iMan(X,Y,result(A,S)):-
    A = down,
    iMan(W,Z,S),
    X is W + 1,
    Y is Z,
    isCell(X,Y).

iMan(X,Y,result(A,S)):-
    A = up,
    iMan(W,Z,S),
    X is W - 1,
    Y is Z,
    isCell(X,Y).

isStone(X,Y, result(A,S)):-
    isStone(X,Y,s0),
    isStone(X,Y,S),
    (
        A = left;
        A = right;
        A = down;
        A = up;
        (A = collect, \+iMan(X,Y,S))
    ).


collected(X,Y,result(_,S)):-
    collected(X,Y,S).

collected(X,Y,result(A,S)):-
    A = collect,
    isStone(X,Y,S),
    iMan(X,Y,S).

isSame(X1,Y1,X2,Y2):-
    X1=X2, 
    Y1=Y2.

snapped(result(snap,S)):-
    thanos(X,Y),
    iMan(X,Y,S),
    isStone(X1,Y1,s0),
    isStone(X2,Y2,s0),
    \+isSame(X1,Y1,X2,Y2),
    isStone(X3,Y3,s0),
    \+isSame(X1,Y1,X3,Y3),
    \+isSame(X2,Y2,X3,Y3),
    isStone(X4,Y4,s0),
    \+isSame(X1,Y1,X4,Y4),
    \+isSame(X2,Y2,X4,Y4),
    \+isSame(X3,Y3,X4,Y4),
    collected(X1,Y1,S),
    collected(X2,Y2,S),
    collected(X3,Y3,S),
    collected(X4,Y4,S).





