init(object(destination,D),value(at,C)) :- init(object(order,D),  value(line,(A,_))),
                                           init(object(product,A),value(on,(S,_))),
                                           init(object(shelf,S),  value(at,C)).

vertex((X,Y))   :- init(object(node,_), value(at,(X,Y))).

% build edges
direction((X,Y)) :- X=-1..1, Y=-1..1, |X+Y|=1.
edge((X,Y),(X',Y')) :- direction((DX,DY)), vertex((X,Y)), vertex((X',Y')),
                                 (X,Y)=(X'-DX,Y'-DY), (X',Y')=(X+DX,Y+DY).

% build agent
agent(R) :- init(object(robot,R), value(at,_)).

% build task
start(R,S) :- init(object(robot,R), value(at,S)).
goal(R,G) :- init(object(destination,R),value(at,G)).

#show vertex/1.
#show edge/2.
#show agent/1.
#show start/2.
#show goal/2.
