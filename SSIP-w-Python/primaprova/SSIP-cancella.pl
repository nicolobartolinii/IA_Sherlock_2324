%cancella un informazione fornita in caso di errore di inserimento
cancella_info(N):-
    retract(ass(N,_,_,_)),
    findall(Ind-Pos-Neg-Fonte-Att,(ass(Ind,c(Pos,Neg),Fonte,_),att(Fonte,Att)),DaAggiungere),
    pulisci_tutto,
    reverse(DaAggiungere,DaAggiungere1),
    aggiungi_lista(DaAggiungere1),!.

% predicato che riaggiunge nel database le informazioni senza quella
% cancellata
aggiungi_lista([]).
aggiungi_lista([_-[PosT|PosC]-Neg-Fonte-Att|C]):-
   (PosT \=[],
    PosC==[],
    Neg==[],
    aggiungi(PosT,Fonte,Att);

    PosT \=[],  %or
    PosC \=[],
    Neg==[],
    aggiungi(PosT or PosC,Fonte,Att);

   PosT \=[],  %->
    PosC==[],
    Neg \=[],
    [Ng|[]]=Neg,
    aggiungi(Ng -> PosT,Fonte,Att)),
    aggiungi_lista(C).

aggiungi_lista([_-[]-Neg-Fonte-Att|C]):-  %non
    Neg\=[],
    [Ng|[]]=Neg,
    aggiungi(non Ng,Fonte,Att),
    aggiungi_lista(C).


stampa_ass(E,AA):-
	ass(E,Cl,F,_),
	informazione(_,Cl,F,_),
	(cl_l(Cl,[T|C1]),
	C1==[],
	AA=T;
	cl_l(Cl,[T|[C1]]),
	atom_concat(T,C1,AA)
	).
