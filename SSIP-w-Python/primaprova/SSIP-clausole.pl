% clausola_atomo(+c[LetPos],[LetNeg]),Atomo)
% converte una clausola in espressione atomica
% ?- clausola_atomo(c([omicidio],['ferite_mortali > 2']), Atomo).
% Atomo = 'omicidio oppure non e' vero che ferite_mortali > 2'
clausola_atomo(Clausola,Atomo) :-
	clausola_lista(Clausola,Lista),
	concatena(Lista,Atomo).

clausola_lista(c(P,[]),I) :- !,
	cambia_pos_p(P,I).
clausola_lista(c([],N),I) :- !, %per rappresentare una negazione
	cambia_neg1(N,I).
clausola_lista(c(P,N),I) :- % per le implicazioni logiche
	cambia_pos(P,P1),
	cambia_neg(N,N1),
	append(N1,P1,I).

cambia_pos_p([],[]) :- !.
cambia_pos_p([T],[T]) :- !.
cambia_pos_p([T|C],[T1|C1]) :-
	concatena([T,' OPPURE '],T1),
	cambia_pos_p(C,C1).

cambia_pos([],[]) :- !.
cambia_pos([T],[T]) :- !.%modifica effettuata secondo T al posto di T1
	%concatena([T,' OPPURE '],T1).
cambia_pos([T|C],[T1|C1]) :-
	concatena([T,' OPPURE '],T1),
	cambia_pos(C,C1).

cambia_neg([],[]) :- !.
cambia_neg([T],[T1]) :- !,
	concatena([T,' IMPLICA '],T1).  % implica al posto di non e' vero che
cambia_neg([T|C],[T1|C1]) :-
	concatena([T,' OPPURE '],T1),
	cambia_neg(C,C1).

cambia_neg1([],[]) :- !.
cambia_neg1([T],[T1]) :- !,
	concatena(['NON È VERO CHE ',T],T1).   % per la negazione
cambia_neg1([T|C],[T1|C1]) :-
	concatena([T,' OPPURE '],T1),
	cambia_neg1(C,C1).

% concatena([a,b,c,d],Atomo) .
% ?- concatena([a,b,c,d],Atomo).
% Atomo = abcd
concatena(ListaDiAtomi,Atomo) :-
	concatena(ListaDiAtomi,[],ListaAtomo),
	name(Atomo,ListaAtomo).
concatena([A|Atomi],Acc,ListaAtomo) :-
	name(A,L),
	append(Acc,L,Acc1),
	concatena(Atomi,Acc1,ListaAtomo).
concatena([],L,L).
