#include "single_agent_instances/instance1.lp".

% D is the distance (minimum number of steps) from a given cell to the goal
distance_to_goal(A,C',D) :-  agent(A), goal(A,C), vertex(C), vertex(C'), C=(X,Y), C'= (X',Y'), D=|X'-X|+|Y'-Y|.
:- horizon(X), time(T), distance_to_goal(A,C,D), position(A,C,T), X-T >= D.