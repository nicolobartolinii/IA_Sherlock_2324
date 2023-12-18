% tautologia(P,N): la clausola è una tautologia
% ?- tautologia([a,b,c,d],[b]).
% true
tautologia(P,N) :-
	member(L,P), memberchk(L,N), !.

% derivabile(P,N)
% la clausola è derivabile da un'altra già presente nel database dinamico
derivabile(P,N) :-	
	clausola(PP,NN),
	sottoinsieme(P,PP),
    sottoinsieme(N,NN), !.

% risolvi(+P1,+N1,+P2,+N2,-RP,-RN) 
% calcola in maniera non deterministica un risolvente c(RP,RN) delle due clausole genitrici
% ground c(P1,N1) e c(P2,N2). 
% Se il risolvente non esiste il goal fallisce.
% ?- risolvi([b],[a],[a],[],RP,RN).
% RN = [],
% RP = [b]
risolvi(P1,N1,P2,N2,RP,RN) :-
	member(L,P1), member(L,N2),
	delete(P1,L,NP1), delete(N2,L,NN2),
	unione_di_due(NP1,P2,NPP), unione_di_due(N1,NN2,NNP),
	sort(NPP,RP), sort(NNP,RN).
risolvi(P1,N1,P2,N2,NP,NN) :-
	member(L,N1), member(L,P2),
	delete(N1,L,NN1), delete(P2,L,NP2),
	unione_di_due(NN1,N2,NNP), unione_di_due(P1,NP2,NPP),
	sort(NPP,NP), sort(NNP,NN).

% refutazione(c,c) tenta la refutazione delle clausole ground nel database
% Le clausole genitrici vengono asserite come utilizzate.
% In caso di insuccesso il goal fallisce.
refutazione([],[]).
refutazione(_,_) :-
	clausola(P1,N1), 
    clausola(P2,N2),
	risolvi(P1,N1,P2,N2,P,N),
	\+ clausola(P,N),               % il risolvente non è già presente nel DB
    \+ tautologia(P,N),                                % non è una tautologia
    \+ derivabile(P,N),       % non è conseguenza logica di un'altra clausola
	asserta(clausola(P,N)), 
    assert(utilizzata(P1,N1)), 
    assert(utilizzata(P2,N2)),
	refutazione(P,N).

% inc(+S,-Inc) restituisce DETERMINISTICAMENTE un sottoinsieme inconsistente Inc
% delle clausole in S. Se S è consistente, la funzione restituisce nil
inc(C,Inconsistenti) :-
	asserisce_cl(C),
	refutazione(controllo,controllo),
	!,
	setof(c(P,N),(member(c(P,N),C),utilizzata(P,N)),Inconsistenti),
	abolish(clausola,2),abolish(utilizzata,2).
inc(_,nil) :-
	abolish(clausola,2),abolish(utilizzata,2).

asserisce_cl([c(P,N)|C]) :-
	assert(clausola(P,N)),
	asserisce_cl(C).
asserisce_cl([]).
