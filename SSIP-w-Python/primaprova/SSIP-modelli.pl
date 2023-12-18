determina_modelli(KB,N) :-
	Num is 1 << N,
	determina_modelli0(KB,Num).

determina_modelli0([c(P,N)|C],Num) :-
	modelli_positivi(P,[],MP,Num),
	modelli_negativi(N,[],MN,Num),
	merge(MP,MN,MC),
	elim_doppi(MC,MC_norip),
	assert(modelli(c(P,N),MC_norip)),
	determina_modelli0(C,Num).
determina_modelli0([],_).

modelli_positivi([T|C],Acc,MP,Num) :-
	m(T,MT),
	%cut_m(MT,Num,MTnuovi),
	merge(MT,Acc,NAcc),
	modelli_positivi(C,NAcc,MP,Num).
modelli_positivi([],MP,MP,_).

modelli_negativi([T|C],Acc,MN,Num) :-
	m_negativi(T,MT,Num),
	merge(MT,Acc,NAcc),
	modelli_negativi(C,NAcc,MN,Num).
modelli_negativi([],MN,MN,_).

m_negativi(A,M,Num) :-
	m(A,MA),
	compl(MA,0,Num,M).

%%%%%%%%%%%%% AUSILIARI %%%%%%%%%%%%%%%%%%%%%%
/*
determina_modelli([I|C]) :-
	m(I,Modelli),
	assert(info(I,Modelli)),
	determina_modelli(C).
determina_modelli([]).

m(non A,MS) :-
	m(A,MA),
	numero_atomiche(N),
	N1 is (2^N)-1,
	compl(MA,N1,M),
	sort(M,MS).

m(A and B,MS) :-
	m(A,MA),
	m(B,MB),
	intersezione_resto(MA,MB,M),
	sort(M,MS).

m(A or B,MS) :-
	m(A,MA),
	m(B,MB),
	unione_di_due(MA,MB,M),
	sort(M,MS).

m(A -> B,MS) :-
	m(non A,MA),
	m(B,MB),
	append(MA,MB,M),
	sort(M,MS).
*/














