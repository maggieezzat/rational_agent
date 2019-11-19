%:-[kB].
:-use_module(library(clpfd)).

grid(2,2). 
iMan(0,1,s0). 
thanos(1,0). 
isStone(0,1,s0). 
isStone(1,1,s0). 
isStone(1,0,s0).
isStone(0,0,s0).

isCell(X,Y):-
    grid(M,N),
    X < M,
    X >= 0,
    Y < N,
    Y >= 0.

% preCondition(left,S):-
%     iMan(X,Y,S),
%     Z is Y-1,
%     isCell(X,Z).


% isSituation(s0).
% isSituation(result(A,S)):-
%     isSituation(S),
%     preCondition(A,S).
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
    A = up,
    iMan(W,Z,S),
    X is W - 1,
    Y is Z,
    isCell(X,Y).

iMan(X,Y,result(A,S)):-
    A = down,
    iMan(W,Z,S),
    X is W + 1,
    Y is Z,
    isCell(X,Y).


iMan(X,Y,result(collect,S)):-
    iMan(X,Y,S).

isStone(X,Y, result(A,S)):-
    isCell(X,Y),
    isStone(X,Y,S),
    iMan(W,_,S),
    ((A \= collect) ; W \= X).

isStone(X,Y, result(A,S)):-
    isCell(X,Y),
    isStone(X,Y,S),
    iMan(_,Z,S),
    ((A \= collect) ; Y \= Z).

collected(X,Y,result(A,S)):-
    isCell(X,Y),
    A = collect,
    isStone(X,Y,S),
    iMan(X,Y,S).
collected(X,Y,result(_,S)):-
    isCell(X,Y),
    collected(X,Y,S).
% collected(X,Y,S):-
%     \+isStone(X,Y,S).

isSame(X1,Y1,X2,Y2):-
    X1=X2, 
    Y1=Y2.

snapped(S):-
    thanos(X,Y),
    iMan(X,Y,S),
    isStone(X1,Y1,s0),
    isStone(X2,Y2,s0),
    isStone(X3,Y3,s0),
    isStone(X4,Y4,s0),
    % (X1 \= X2 ; Y1 \= Y2),
    % (X1 \= X3 ; Y1 \= Y3),
    % (X1 \= X4 ; Y1 \= Y4),

    % (X2 \= X3 ; Y1\= Y3),
    % (X2 \= X4 ; Y1\= Y4),

    % (X3 \= X4 ; Y3 \= Y4),
    %all_different(X1,X2,X3,X4)
    \+isSame(X1,Y1,X2,Y2),
    \+isSame(X1,Y1,X3,Y3),
    \+isSame(X1,Y1,X4,Y4),
    \+isSame(X2,Y2,X3,Y3),
    \+isSame(X2,Y2,X4,Y4),
    \+isSame(X3,Y3,X4,Y4),
    collected(X1,Y1,S),
    collected(X2,Y2,S),
    collected(X3,Y3,S),
    collected(X4,Y4,S).





