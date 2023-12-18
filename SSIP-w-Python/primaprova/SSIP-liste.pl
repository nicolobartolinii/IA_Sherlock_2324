:- use_module(library(lists)).

% member_resto(+Elem,+Lista,-RestoListaDopoElem).
% restituisce in maniera deterministica la sottolista di Lista
% che inizia con l'elemento successivo ad Elem
% ?- member_resto(e,[a,b,c,d],R). -> false
% ?- member_resto(d,[a,b,c,d],R). -> []
% ?- member_resto(e,[a,b,c,d],R). -> [c,d]
member_resto(X,[X|R],R) :- !.
member_resto(X,[_|Z],R) :- member_resto(X,Z,R).

% s(+Insieme,-SottoInsieme)
% restituisce nondeterministicamente un Sottoinsieme di Insieme
s([],[]).
s([_|Insieme],SottoInsieme) :-
	s(Insieme,SottoInsieme).
s([T|Insieme],[T|SottoInsieme]) :-
	s(Insieme,SottoInsieme).

% complemento(+S1,+S2,-C) crea C con gli elementi della lista S1 che
% non appartengono alla lista S2
% ?- complemento([a,b,c,d],[a,d],R). -> [b, c]
complemento([],_,[]).
complemento([T|C1],S2,Complemento) :-
	member(T,S2), !,
	complemento(C1,S2,Complemento).
complemento([T|C1],S2,[T|Complemento]) :-
	complemento(C1,S2,Complemento).

% seleziona(+S,+U,-Sel) seleziona in Sel gli elementi della lista U che
% appartengono alla lista S, prendendoli una sola volta
% ?- seleziona([a,b,c,d],[a,a,e,d],R). -> [a, d]
seleziona(_,[],[]).
seleziona(S,[T|C1],[T|C2]) :-
	member(T,S),
	\+ member(T,C1), !,
	seleziona(S,C1,C2).
seleziona(S,[_|C1],C) :-
	seleziona(S,C1,C).

% cancella(+El,+Lista,-Nlista) cancella ogni occorrenza di El in Lista
cancella(L,[L|C],C1) :-
	cancella(L,C,C1).
cancella(L,[X|C],[X|C1]) :-
	cancella(L,C,C1).
cancella(_,[],[]).

% elim_doppi(+Lista,-Nlista) cancella ogni ripetizione di elemento in Lista
% ?- elim_doppi([a,c,b,c,d],R). -> [a, b, c, d]
elim_doppi([T|C],C1) :-
	member(T,C), !,
	elim_doppi(C,C1).
elim_doppi([T|C],[T|C1]) :-
	elim_doppi(C,C1).
elim_doppi([],[]).

% sottoinsieme(+Lista1,+Lista2) controlla che tutti gli elementi di Lista2
% appartengono anche a Lista1
% ?- sottoinsieme([a,b,c,d],[b,a]). -> true
sottoinsieme(_,[]) :-!.
sottoinsieme(S,[T|C]) :-
	member(T,S), !,
	sottoinsieme(S,C).

% sottoinsieme_resto(+Lista1,+Lista2).
% come sottoinsieme(+Lista1,+Lista2) ma funziona solo se le due liste sono
% parimenti ordinate:
% ?- sottoinsieme_resto([a,b,c,d],[b,c]). -> true
% ?- sottoinsieme_resto([a,b,c,d],[c,b]). -> false
% ?- sottoinsieme_resto([a,c,b,d],[b,c]). -> false
% ?- sottoinsieme_resto([a,c,d,b],[c,b]). -> true
sottoinsieme_resto(_,[]) :-!.
sottoinsieme_resto(S,[T|C]) :-
	member_resto(T,S,R),!,
	sottoinsieme_resto(R,C).

% intersezione(+ListaDiListe,-Lista)
% restituisce la Lista intersezione di tutte le ListaDiListe
% ?- intersezione([[a,c,d,b],[b,c,l]],L). -> [c, b]
intersezione([[X|Xc]|Tc],[X|Y]) :-
	appartiene_a_tutti(X,Tc), !,
	intersezione([Xc|Tc],Y).
intersezione([[_|Xc]|Tc],Y) :-
	intersezione([Xc|Tc],Y).
intersezione([[]|_],[]).

% appartiene_a_tutti(+Elem,+ListaDiListe)
% controlla che Elem appartenga a tutte le ListaDiListe
% ?- appartiene_a_tutti(b,[[a,c,d,b],[b,c,l]]). -> true
appartiene_a_tutti(X,[T|Tc]) :-
	member(X,T), !,
	appartiene_a_tutti(X,Tc).
appartiene_a_tutti(_,[]).

% intersezione_resto(+ListaDiListe,-Lista)
% come intersezione(+ListaDiListe,-Lista) ma solo se le liste sono
% parimenti ordinate:
% ?- intersezione_resto([[a,c,d,b],[b,c,l]],L). -> [c] ERRORE
% ?- intersezione_resto([[a,b,d,l],[b,c,l]],L). -> [b, l]
intersezione_resto([[X|Xc]|Tc],[X|Y]) :-
	appartiene_a_tutti_resto(X,Tc,[],Resti), !,
	intersezione_resto([Xc|Resti],Y).
intersezione_resto([[_|Xc]|Tc],Y) :-
	intersezione_resto([Xc|Tc],Y).
intersezione_resto([[]|_],[]).

appartiene_a_tutti_resto(X,[T|Tc],TRc,R) :-
	member_resto(X,T,TR), !,
	appartiene_a_tutti_resto(X,Tc,[TR|TRc],R).
appartiene_a_tutti_resto(_,[],Resti,Resti).

% intersezione_di_due(+ListaA,+ListaB,-Intersezione)
intersezione_di_due([T|C],B,[T|C1]) :-
	member(T,B), !,
	intersezione_di_due(C,B,C1).
intersezione_di_due([_|C],B,C1) :-
	intersezione_di_due(C,B,C1).
intersezione_di_due([],_,[]).

% come intersezione_di_due(+ListaA,+ListaB,-Intersezione) ma solo se le liste sono
% parimenti ordinate
intersezione_resto([T|C],B,[T|C1]) :-
	member_resto(T,B,RB), !,
	intersezione_resto(C,RB,C1).
intersezione_resto([_|C],B,C1) :-
	intersezione_resto(C,B,C1).
intersezione_resto([],_,[]).

% compl(+ListaIntPos,+N,+Num,-Min) istanziata la lista di interi positivi
% un intero positivo Num, e 0 in N, restituisce in Min la lista
% dei minori di Num che non compaiono in ListaIntPos
% ?- compl([2,5,3,4,7],0,5,M). -> [0, 1]
compl(_,N,N,[]) :- !.
compl(MA,N,Num,M) :-
	member(N,MA), !,
	N1 is N+1,
	compl(MA,N1,Num,M).
compl(MA,N,Num,[N|M]) :-
	N1 is N+1,
	compl(MA,N1,Num,M).

% cut_m(+ListaIntPos,+N,-Listatagliata)
% data una lista ordinata di interi, restituisce i primi elementi della
% lista che sono minori di Num
/*cut_m([],_,[]).
cut_m([T|C],Num,[T|L1]):-
    Num > T,
    cut_m(C,Num,L1),!.
cut_m([T|_],Num,[]):-
    Num =< T.
*/

% unione_di_due(+ListaA,+ListaB,-Unione)
% se l'elemento della A è nella B non lo prende, ma la B la prende tutta,
% anche con ripetizioni
% ?- unione_di_due([2,5,3,4,7],[3,3,5,8],M). -> [2, 4, 7, 3, 3, 5, 8] ERRATO
% ?- unione_di_due([2,3,3,4,7],[3,5,8],M).-> [2, 4, 7, 3, 5, 8]
unione_di_due([T|C],B,U) :-
	member(T,B), !,
	unione_di_due(C,B,U).
unione_di_due([T|C],B,[T|U]) :-
	unione_di_due(C,B,U).
unione_di_due([],B,B).

% fonde(+ListaA,+ListaB,-Fusione)
% stesso comportamento della built-in merge/3 (deterministica)
% ?- fonde([a,e,r,z],[d,s],L). ->  [a, d, e, r, s, z] ; false.
fonde(L,[],L).
fonde([],[T|C],[T|C]).
fonde([T|C1],[T|C2],[T|C]) :- !,
	fonde(C1,C2,C).
fonde([T1|C1],[T2|C2],[T1|C]) :-
	T1 @< T2, !,
	fonde(C1,[T2|C2],C).
fonde([T1|C1],[T2|C2],[T2|C]) :-
	fonde([T1|C1],C2,C).
