% clingo solver.lp instance_test.lp 0

%* authors *%
% Ben Kampmann, 803374, kampmann2@uni-potsdam.de
% Till Zemann, 808255, till.zemann@uni-potsdam.de

#include "instance_test.lp".

%:- use_module(library(instance.lp)).
% forbid edge and vertex conflicts (agents can't move to the same cell)

time(1..horizon).

% generate all possible moves
% move(agent, from_cell, to_cell, time) 
% C and C' are tuples (X,Y)
{ move(A,C,C',T) : edge(C,C') } 1 :- agent(A), time(T), position(A,C,T).

position(A,C',T+1) :- move(A,C,C',T), time(T+1).
position(A,C,T+1) :- not move(A,_,_,T), position(A,C,T), agent(A), time(T+1).
position(A,C,T) :- start(A,C), agent(A), time(T), T=1.

% vertex-conflict
:- { position(A,C,T) : agent(A) } > 1, vertex(C), time(T).

% test if the agent is 
:- not position(A,C,horizon), goal(A,C).
:- move(A,C,_,horizon), goal(A,C).

#show time/1.
#show move/4.
#show position/3.