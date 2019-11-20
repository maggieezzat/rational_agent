%:-[kB].
/*
 * true tests:
 * snapped(result(snap,result(right,result(collect,result(down,result(right,result(collect,result(right,result(collect,result(down,result(collect,result(left,s0))))))))))))).
 * snapped(result(snap,result(right,result(collect,result(left,result(down,result(right,result(right,result(collect,result(right,result(collect,result(down,result(collect,result(left,s0)))))))))))))).
 * 
 * false tests:
 * right, collect, down, left, left, right, right, right, collect, right, collect, down, collect, left
 * snapped(result(snap,result(right,result(collect,result(down,result(right,result(collect,result(right,result(collect,result(down,result(collect,result(left,result(collect,s0)))))))))))))).
 */
% grid(2,2). 
% iMan(0,1,s0). 
% thanos(1,0). 
% isStone(0,1,s0). 
% isStone(1,1,s0). 
% isStone(1,0,s0).
% isStone(0,0,s0).
grid(5,5). 
iMan(1,2,s0). 
thanos(3,4). 
isStone(1,1,s0). 
isStone(2,1,s0). 
isStone(2,2,s0). 
isStone(3,3,s0).

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





