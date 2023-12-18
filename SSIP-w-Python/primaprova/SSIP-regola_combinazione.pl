% crea gli elementi focali delle testimonianze di ciascuna fonte


elementi_focali([Find|AltreFonti]) :-
	fonte_sign(Fonte,Find),
	att(Fonte,Att),
	N is 1-Att,
	asserisce_clausole(Find,Cl),
	findall(M,(member(C,Cl),modelli(C,M)),TuttiModelli),
	intersezione_resto(TuttiModelli,Modelli),
	assert(focali(Find,[(a,Att,Modelli),(n,N,omega)])),
	elementi_focali(AltreFonti).
elementi_focali([]) :- !.

calcola_bpa_combinata([Find|C],ProdParz,F) :-	% ci sono ancora fonti
	focali(Find,Focali),
	member((A,M,Focale),Focali),
	ProdParz1 is ProdParz * M,
	calcola_bpa_combinata(C,ProdParz1,[(Find,A,Focale)|F]).
calcola_bpa_combinata([],Prod,Focali) :-		    % Focali contiene una combinazione
	genera_lista_focali(Focali,Focali_senza_omega,0,StatoFonti),
	intersezione_resto(Focali_senza_omega,Focale),
	assert(f(StatoFonti,Prod,Focale)),
	fail.
calcola_bpa_combinata([],Prod,Focali) :-		    % Focali contiene solo omega
	genera_lista_focali(Focali,[],0,StatoFonti),
	assert(f(StatoFonti,Prod,omega)),!.

calcola_attendibilita_fonti(FontiInd) :-
	f(_,_,[]),
	findall(Y,f(_,Y,[]),Sommandi),
	retractall(f(_,_,[])),
	somma(Sommandi,0,S),
        assert(foc([],S)),
	calcola_attendibilita_fonti(FontiInd,S).
calcola_attendibilita_fonti(_) :-
	\+ f(_,_,[]),
	assert((nuova_att(Fonte,Att) :- att(Fonte,Att))).
calcola_attendibilita_fonti([FonteInd|C],S) :-
	findall(P,(f(SF,P,_),btest(SF,FonteInd)),Sommandi),
	somma(Sommandi,0,Somma),
	NA is Somma / (1-S),
	fonte_sign(Fonte,FonteInd),
	assert(nuova_att(Fonte,NA)),
	calcola_attendibilita_fonti(C,S).
calcola_attendibilita_fonti([],_).

btest(X,Y) :- % testa il bit in posizione Y nell'intero X
	W is 1 << Y,
	W is /\(X,W).

compatta :-
	f(_,_,F),
	findall(Y,f(_,Y,F),Sommandi),
	retractall(f(_,_,F)),
	somma(Sommandi,0,S),
	assert(foc(F,S)),
	compatta.

compatta :-
	\+ f(_,_,_),
	calcola_bpa.

calcola_bpa :-
	foc([],X),
	retract(foc([],X)),
	ricalcola_bpa(X).
calcola_bpa :-
	\+ foc([],_),
	rinomina_bpa.

ricalcola_bpa(X) :-
	findall((F,Y),foc(F,Y),Foc),
	retractall(foc(_,_)),
	ricalcola_bpa(X,Foc).
ricalcola_bpa(X,[(F,Y)|C]) :-
	Z is Y / (1-X),
	assert(bpac(F,Z)),
	ricalcola_bpa(X,C).
ricalcola_bpa(_,[]).

rinomina_bpa :-
	findall((F,X),foc(F,X),Foc),
	retractall(foc(_,_)),
	rinomina_bpa(Foc).

rinomina_bpa([(F,X)|C]) :-
	assert(bpac(F,X)),
	rinomina_bpa(C).
rinomina_bpa([]).

genera_lista_focali([],[],Stato,Stato).
genera_lista_focali([(_,_,omega)|C],C1,SParz,S) :-
	!,
	genera_lista_focali(C,C1,SParz,S).
genera_lista_focali([(FonteInd,_,T)|C],[T|C1],SParz,S) :-
	bset(SParz,FonteInd,SParz1),
	genera_lista_focali(C,C1,SParz1,S).

bset(X,Y,Z) :- %setta il bit in posizione Y nell'intero X e restituisce Z
	W is 1 << Y,
	Z is \/(X,W).

prodotti([T|C],[Tot|C1]) :-
	prod(T,1,Tot),
	prodotti(C,C1).
prodotti([],[]).

prod([M|C],P,Pr) :-
	PP is P * M,
	prod(C,PP,Pr).
prod([],Pr,Pr).

somma([T|C],P,S) :-
	PP is P + T,
	somma(C,PP,S).
somma([],S,S).

bel(Modelli,Bel) :-
	findall(X,(bpac(F,X),sottoinsieme_resto(Modelli,F)),Sommandi),
	somma(Sommandi,0,Bel).

bel_clausole([T|C]) :-
	modelli(T,M),
	bel(M,Bel),
	assert(b(T,Bel)),
	bel_clausole(C).
bel_clausole([]).


% prende la lista delle fonti e genera il database credibile(Fonte,Bel)
bel_fonti([Ind|C]) :-
	focali(Ind,[(_,_,Modelli),(_,_,_)]),
	bel(Modelli,Bel),
	fonte_sign(Fonte,Ind),
	assert(credibile(Fonte,Bel)),
	bel_fonti(C).
bel_fonti([]).


bel_non_significative(NS,PC) :-
	bel_non_significative(NS,0,PC).
bel_non_significative([E|C],Acc,PC) :-
	ass(E,_,F,_),
	(fonte_sign(F,_),
	nuova_att(F,B), !
	;
	att(F,B)),
	assert(b_ns(E,B)),
	Acc1 is Acc + B,
	bel_non_significative(C,Acc1,PC).
bel_non_significative([],PC,PC).

bel_non_significative_2(NS,PC) :-      % non ci sono informazioni significative
	bel_non_significative_2(NS,0,PC).
bel_non_significative_2([C|Coda],Acc,PC) :-
	ass(E,C,F,_),
	att(F,B),
	assert(b_ns(E,B)),
	Acc1 is Acc + B,
	bel_non_significative_2(Coda,Acc1,PC).
bel_non_significative_2([],PC,PC).






