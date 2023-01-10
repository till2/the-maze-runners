vertex((1..6,1..6)). % larger grid

% generate all edges
diff(X,Y) :- X=-1..1, Y=-1..1, |X+Y|=1.
edge(C1,C2) :- vertex(C1), vertex(C2), C1=(X+DX, Y+DY), diff(DX,DY), C2=(X,Y).

agent(a1).
start(a1,(1,1)).
goal(a1,(2,2)).

agent(a2).
start(a2,(1,2)).
goal(a2,(2,1)).

#const horizon=5.