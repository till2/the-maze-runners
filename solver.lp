% clingo solver.lp 0

%* authors *%
% Ben Kampmann, 803374, kampmann2@uni-potsdam.de
% Till Zemann, 808255, till.zemann@uni-potsdam.de

% include an instance
#include "multi_agent_instances/instance1.lp".

% CONFLICTS:
% we forbid edge, vertex and swapping conflicts

% Makespan = horizon - 1
{horizon(0..100)}=1.
time(0..X) :- horizon(X).
#minimize{X : horizon(X)}.

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

% eliminate model if there are swapping-conflicts
:- move(A1,C1,C2,T), move(A2,C2,C1,T).

% test if the agent is on the goal at the end
:- not position(A,C,X), horizon(X), goal(A,C).
:- move(A,C,_,X), horizon(X), goal(A,C).

% pruning with distance to goal
distance_to_goal(A,C',D) :-  agent(A), goal(A,C), vertex(C), vertex(C'), C=(X,Y), C'= (X',Y'), D=|X'-X|+|Y'-Y|.
:- horizon(X), time(T), distance_to_goal(A,C,D), position(A,C,T), X-T < D. % prune model if the goal is not reachable anymore

% convert "move" to "path" & "plan" as output
path(A,C1,C2) :- move(A,C1,C2,T).
plan(A,ACTION,T) :- move(A,C1,C2,T), C1=(X,Y), C2=(X',Y'), ACTION=(X'-X,Y'-Y).
%#show move/4.
#show path/3.
#show plan/3.