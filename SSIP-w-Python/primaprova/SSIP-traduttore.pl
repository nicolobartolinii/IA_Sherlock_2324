% transla(+Formula,-Clausole)
% traduce la Formula, facente uso degli operatori, in lista di Clausole.
% ?- transla(non a, Clausole).
% Clausole = [c([], [a])].
% ?- transla(a or non b, Clausole).
% Clausole = [c([a], [b])].
% ?- transla('ferite mortali > 2' -> omicidio, Clausole).
% Clausole = [c([omicidio], ['ferite mortali > 2'])]
% ?- transla(omicidio <-> non suicidio, Clausole).
% Clausole = [c([omicidio, suicidio], []), 
%             c([], [suicidio, omicidio])]
% ?- transla(cadavere and omicidio <-> cadavere and non suicidio, Clausole).
% Clausole = [c([omicidio, suicidio], [cadavere]), 
%             c([], [suicidio, cadavere, omicidio])]

:-	op(30,fx,non).
:-	op(100,xfy,[or, and]).
:-	op(150,xfy,[-->, <->]).

transla(X,Clausole) :-
	elimpl(X,X1),
	negin(X1,X2),
	conjn(X2,X3),
	clausify(X3,Clausole,[]).

elimpl((P <-> Q),((P1 and Q1) or (non P1  and non Q1 ))) :- !,
	elimpl(P,P1),
	elimpl(Q,Q1).
elimpl((P -> Q),(non P1  or Q1)) :- !,
	elimpl(P,P1),
	elimpl(Q,Q1).
elimpl((P and Q),(P1 and Q1)) :- !,
	elimpl(P,P1),
	elimpl(Q,Q1).
elimpl((P or Q),(P1 or Q1)) :- !,
	elimpl(P,P1),
	elimpl(Q,Q1).
elimpl(non P ,non P1 ) :- !,
	elimpl(P,P1).
elimpl(P,P).

negin((non P),P1) :- !,
	neg(P,P1).
negin((P and Q),(P1 and Q1)) :- !,
	negin(P,P1),
	negin(Q,Q1).
negin((P or Q),(P1 or Q1)) :- !,
	negin(P,P1),
	negin(Q,Q1).
negin(P,P).

neg((non P),P1) :- !,
	negin(P,P1).
neg((P and Q),(P1 or Q1)) :- !,
	neg(P,P1),
	neg(Q,Q1).
neg((P or Q),(P1 and Q1)) :- !,
	neg(P,P1),
	neg(Q,Q1).
neg(P,(non P)).

conjn((P or Q),R) :- !,
	conjn(P,P1),
	conjn(Q,Q1),
	conjn0((P1 or Q1),R).
conjn((P and Q),(P1 and Q1)) :- !,
	conjn(P,P1),
	conjn(Q,Q1).
conjn(P,P).

conjn0(((P and Q) or R),(P1 and Q1)) :- !,
	conjn((P or R),P1),
	conjn((Q or R),Q1).
conjn0((P or (Q and R)),(P1 and Q1)) :- !,
	conjn((P or Q),P1),
	conjn((P or R),Q1).
conjn0(P,P).

clausify((P and Q),C1,C2) :- !,
	clausify(P,C1,C3),
	clausify(Q,C3,C2).
clausify(P,[c(A,B)|Cs],Cs) :-
	inclause(P,A,[],B,[]),!.
clausify(_,C,C).

inclause((P or Q),A,A1,B,B1) :- !,
	inclause(P,A2,A1,B2,B1),
	inclause(Q,A,A2,B,B2).
inclause((non P),A,A,B1,B) :- !,
	notin(P,A),
	putin(P,B,B1).
inclause(P,A1,A,B,B) :-
	notin(P,B),
	putin(P,A,A1).

notin(X,[X|_]) :- !, fail.
notin(X,[_|L]) :- !,
	notin(X,L).
notin(_,[]).

putin(X,[],[X]) :- !.
putin(X,[X|L],[X|L]) :- !.
putin(X,[Y|L],[Y|L1]) :- putin(X,L,L1).




/** <examples>
?- transla(omicidio <-> (non suicidio), Clausole).
?- transla(cadavere and omicidio <-> cadavere and non suicidio, Clausole).
*/
