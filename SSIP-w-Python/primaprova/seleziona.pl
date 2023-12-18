%questo predicato permette di fare un collegamento logico tra due informazioni che sono state fornite in precedenza
/* collega(a,A->B):-
   seleziona_atomiche(A,B).

   collega(b,A<->B):-
    seleziona_atomiche(A,B).

   collega(c,A or B):-
    seleziona_atomiche(A,B).

   collega(d,A and B):-
    seleziona_atomiche(A,B).


seleziona_atomiche(A,B):-
    enumera1(Lista_atomiche),
    stampa(Lista_atomiche),
    prompt(_,'Seleziona il numero della prima informazione che vuoi collegare :

    '),
    read(N),nl,
    delete(Lista_atomiche,N-_,Lista1), %elimina dalla lista di atomiche quella appena scelta
    stampa(Lista1),nl,
    prompt(_,'Seleziona il numero della seconda informazione che vuoi collegare :

    '),
    read(M),nl,
    prendi(Lista_atomiche,N,A),
    prendi(Lista1,M,B).


enumera([],_,[]).
enumera([T|C],M,[M-T|L]):-
    N is M-1,
    enumera(C,N,L).

enumera1(ListaFinale1):-
    findall(At,atomica(At),Lista),
    length(Lista,M),
    reverse(Lista,Lista1),
    enumera(Lista1,M,ListaFinale),
    reverse(ListaFinale,ListaFinale1).



stampa_operatori:-
    findall(X/Y,link(X,Y),Lista_op),
    stampa(Lista_op).

link(a,->).
link(b,<->).
link(c, or).
link(d, and).

%data una lista numerata prende l'elemento il cui numero coincide con "Num" selezionato
prendi([],_,_).
prendi([N-_|C],Num,X):-
    N \= Num,
    prendi(C,Num,X).
prendi([N-T|_],N,T).


*/














