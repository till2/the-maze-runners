% clingo mapf_problem.lp instance_test.lp

%* authors *%
% Ben Kampmann, 803374, kampmann2@uni-potsdam.de
% Till Zemann, 808255, till.zemann@uni-potsdam.de

%#include "instance.lp"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vertex((1..2,1..2)).

edge((1,1),(1,2)).
edge((1,1),(2,1)).
edge((1,2),(2,2)).
edge((2,1),(2,2)).
edge(X,Y) :- edge(Y,X).

agent(a1).

start(a1,(1,1)).
goal(a1,(2,2)).

spath(a1,(1,1),(1,2),1).
spath(a1,(1,2),(2,2),2).

#const horizon=3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- use_module(library(instance.lp)).
% forbid edge and vertex conflicts (agents can't move to the same cell)

time(1..horizon).

% generate all possible moves
% move(agent, from_cell, to_cell, time) 
% C and C' are tuples (X,Y)
{ move(A,C,C',T) : edge(C,C') } 1 :- agent(A), time(T), position(A,C,T).

position(A,C',T+1) :- move(A,C,C',T).
position(A,C,T+1) :- not move(A,_,_,T), position(A,C,T-1), agent(A), time(T).
position(A,C,T) :- start(A,C), agent(A), time(T), T=1.                                      %first position

% BIS HIER STIMMT ES (HOFFENTLICH)

%vertex-conflict
:- { position(A,C,T) : agent(A) } > 1, vertex(C), time(T).

%test on goal position at end
:- not position(A,C,horizon), goal(A,C).

#show time/1.
#show move/4.
#show position/3.