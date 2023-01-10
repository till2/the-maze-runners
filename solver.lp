% clingo solver.lp instance_test.lp 0

%* authors *%
% Ben Kampmann, 803374, kampmann2@uni-potsdam.de
% Till Zemann, 808255, till.zemann@uni-potsdam.de

%#include "instance_test.lp".
#include "instance_test_2Agents.lp".

% CONSTRAINTS:
% we forbid edge and vertex conflicts (agents can't move to the same cell)

% Makespan is equal to horizon
time(0..horizon).

% generate all possible moves
% move(agent, from_cell, to_cell, time) 
% C and C' are tuples (X,Y)
{ move(A,C,C',T) : edge(C,C') } 1 :- agent(A), time(T), position(A,C,T).

% position of timestep 0 is the start position
position(A,C,0) :- start(A,C), agent(A).

% new position if the agent moved
position(A,C',T+1) :- move(A,C,C',T), time(T+1).

% new position if the agent waited
position(A,C,T+1) :- not move(A,_,_,T), position(A,C,T), agent(A), time(T+1).

% eliminate model if there are vertex-conflicts
:- { position(A,C,T) : agent(A) } > 1, vertex(C), time(T).

% test if the agent is on the goal at the end
:- not position(A,C,horizon), goal(A,C).
:- move(A,C,_,horizon), goal(A,C).

#show move/4.
%#show position/3.