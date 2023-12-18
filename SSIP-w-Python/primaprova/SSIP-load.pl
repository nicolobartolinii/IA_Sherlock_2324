% PROGRAMMA PRINCIPALE

:-	op(30,fx,non).
:-	op(100,xfy,[or, and]).
:-	op(150,xfy,[-->, <->]).

:-include('SSIP-scriviDB').
:-include('SSIP-cancella').
:- include('SSIP-liste').
:- include('SSIP-clausole').
:- include('SSIP-traduttore').
:- include('SSIP-risolutore').
:- include('SSIP-goods').
:- include('SSIP-modelli').
:- include('SSIP-regola_combinazione').
:- include('SSIP-garbage').
:-include('seleziona').

:- multifile ass/4,atomica/1,att/2,atomica_ind/2,significativa/3,fonte_sign/2,focali/2,b_ns/2,base_stratificata/1,f/3,foc/2,asserisce_clausole/2,cl_l/2,modelli/2,bpac/2,b/2,good/3,g_s/2,d_s/3,media/3,credibile/2,nuova_att/2,m/2,ordinatoBO/3.
:- dynamic   ass/4,atomica/1,att/2,atomica_ind/2,significativa/3,fonte_sign/2,focali/2,b_ns/2,base_stratificata/1,f/3,foc/2,asserisce_clausole/2,cl_l/2,modelli/2,bpac/2,b/2,good/3,g_s/2,d_s/3,media/3,credibile/2,nuova_att/2,m/2,ordinatoBO/3.

%================================================================================
%FontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFontiFonti
%================================================================================

% fonti
% Restituisce una coppia Fonte-Attendibilità alla volta, e viene richiamato per fallimento da Python

fonte(F,A):-
        att(F,A).

informazioni_fornite(Fonte,A,B) :-
	informazione(_,Cl,Fonte,B),
	(cl_l(Cl,[T|C]),
	C==[],
	A=T;
	cl_l(Cl,[T|[C]]),
	atom_concat(T,C,A)
	).

%================================================================================
%InfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfoInfo
%================================================================================

informazione(E,Cl,F,B) :-
	ass(E,Cl,F,_),
	(significativa(E,C,F), b(C,B)
		;
	b_ns(E,B)).

%================================================================================
%GoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoodsGoods
%================================================================================

% I goods sono stati numerati, ogni volta che ne viene chiamato uno viene restiuita una informazione con la sua
% credibilità alla volta e informazioni successive ma sempre dello stesso good vengono richiamate per fallimento
%da Pyswip di Python poi chè questo non riesce a dare come output le liste

goods_DS(N,AA-BB):-
	d_s(N,G,_),!,
	%media(G,M),
	(   member(C,G),
	    b(C,BB),
	    significativa(_,C,F) ;
	b_ns(E,BB),
	ass(E,Cl,F,_)),
	informazione(_,Cl,F,BB),
	(cl_l(Cl,[T|C1]),
	C1==[],
	AA=T;
	cl_l(Cl,[T|[C1]]),
	atom_concat(T,C1,AA)
	).

goods_media(N,AA-BB):-
	media(N,G,_),!,
	%media(G,M),
	(   member(C,G),
	    b(C,BB),
	    significativa(_,C,F) ;
	b_ns(E,BB),
	ass(E,Cl,F,_)),
	informazione(_,Cl,F,BB),
	(cl_l(Cl,[T|C1]),
	C1==[],
	AA=T;
	cl_l(Cl,[T|[C1]]),
	atom_concat(T,C1,AA)
	).

ordina_BO:-
	findall(G,g_s(_,G),Goods_s),
	base_stratificata(KB),
	quicksort_best_out(Goods_s,Goods_s_Ordinati,KB),
	stratificati_good(Goods_s_Ordinati,Goods),
	assert_goodsBO(Goods,1).

        assert_goodsBO([],_).
        assert_goodsBO([T|C],N):-
        d_s(_,T,X),
	assert(ordinatoBO(N,T,X)),
	N1 is N+1,
	assert_goodsBO(C,N1).

	mostra_goodsBO(N,AA-BB):-
	ordinatoBO(N,G,_),!,
	(   member(C,G),
	    b(C,BB),
	    significativa(_,C,F) ;
	b_ns(E,BB),
	ass(E,Cl,F,_)),
	informazione(_,Cl,F,BB),
	(cl_l(Cl,[T|C1]),
	C1==[],
	AA=T;
	cl_l(Cl,[T|[C1]]),
	atom_concat(T,C1,AA)
	).

    quicksort_best_out([],[],_).
quicksort_best_out([T|C],LO,KB) :-
	split_best_out(T,C,Lmin,Lmag,KB),
	quicksort_best_out(Lmin,LminO,KB),
	quicksort_best_out(Lmag,LmagO,KB),
	append(LminO,[T|LmagO],LO).
split_best_out(_,[],[],[],_).
split_best_out(T,[X|C],[X|Lmin],Lmag,KB) :-
	minore_best_out(T,X,KB), !,
	split_best_out(T,C,Lmin,Lmag,KB).
split_best_out(T,[X|C],Lmin,[X|Lmag],KB) :-
	split_best_out(T,C,Lmin,Lmag,KB).

minore_best_out([S|C1],[S|C2],[S|C]) :- !, % se hanno entrambe lo strato completo
	minore_best_out(C1,C2,C).          % esamina lo strato successivo
minore_best_out([_|_],[S|_],[S|_]).        % il minore ha lo strato completo

stratificati_good([G_s|C1],[G|C2]):-
 g_s(G,G_s),
 stratificati_good(C1,C2).
stratificati_good([],[]).

%================================================================================

elabora :-     % caso in cui ci sono informazioni significative
	pulisci,   % CANCELLA I VECCHI MODELLI
	setof(C,E^F^significativa(E,C,F),KB), !,
	findall(I,fonte_sign(_,I),Dniitnof),
	reverse(Dniitnof,FontiInd),
	findall(E,(ass(E,_,_,_), \+ significativa(E,_,_)),Non_significative),
	fonti_clausole,      % crea il DB "asserisce_clausole(Find,Clausole)"
	atomica_ind(N1,_), % prende l'indice maggiore di proposizione atomica ind
	N is N1 + 1, % questo è il numero delle prop. atomiche ind
	number_codes(N,Code),
	atom_codes(Atom,Code),
	atom_concat('mod',Atom,File),
	load_files(File,[]),% va a prendere i modelli m(X,Y) dal file "File"
	determina_modelli(KB,N),                % crea il DB "modelli(Clausola,Modelli)"

	elementi_focali(FontiInd), % crea DB "focali(Find,[(a,Att,Modelli),(n,N,omega)])
	calcola_bpa_combinata(FontiInd,1,[]),              % crea il DB "f(SF,P,Focale)"
	calcola_attendibilita_fonti(FontiInd),            % crea il DB "nuova_att(F,NA)"
	compatta,         % elimina il DB "f(SF,P,F)" e crea il DB "bpac(F,Credibilita)"
	bel_clausole(KB),	%genera il DB "b(Clausola,Bel)"
	genera_goods(KB,Goods),          % crea il DB "good(Clausole,Etichette,Modelli)"
	stratifica(KB,Goods),    % crea i DB "g_s(G,Gstrat)" e base_stratificata(_)
	bel_fonti(FontiInd),
	bel_non_significative(Non_significative,PesoComplessivo),
	credibilita_d_s(Goods),	% crea il DB "d_s(Etichette,B)"
	length(Non_significative,L),
	credibilita_media(Goods,L,PesoComplessivo),
    ordina_BO,
	scrivi_database,!.

elabora :-	%caso in cui non ci sono informazioni significative
	pulisci,
	findall(C,ass(_,C,F,_),Good),
	findall(E,ass(E,_,F,_),Etichette),
	assert(good(Good,Etichette,_)),
	bel_non_significative_2(Good,PC), %genera il DB "b_ns(Clausola,Bel)"
	credibilita_d_s(Good,Good,1), % crea il DB "d_s(Etichette,B)"
	length(Good,L),
	M is PC/L,
	assert(media(Good,M)),
	scrivi_database,!.

fonti_clausole :-
	fonte_sign(Fonte,Find),
	findall(C,significativa(_,C,Fonte),Clausole),
	assert(asserisce_clausole(Find,Clausole)),
	fail.
fonti_clausole.

stratifica(KB,Goods) :-
	setof(B,C^b(C,B),Idarg), reverse(Idarg,Gradi),
	stratifica_base(KB,Gradi,KBstratificata),
	assert(base_stratificata(KBstratificata)),
	stratifica_goods(KBstratificata,Goods).

stratifica_base(KB,[G|Gradi],[Strato|Strati]) :-
	findall(C,(b(C,G),member(C,KB)),Strato),
	stratifica_base(KB,Gradi,Strati).
stratifica_base(_,[],[]).

stratifica_goods(KBstratificata,[G|Goods]) :-
	stratifica_goods0(KBstratificata,G,Gstratificato),
	assert(g_s(G,Gstratificato)),
	stratifica_goods(KBstratificata,Goods).
stratifica_goods(_,[]).

stratifica_goods0([KBStrato|KBStrati],G,[GStrato|GStrati]) :-
	findall(C,(member(C,KBStrato),member(C,G)),GStrato),
	stratifica_goods0(KBStrati,G,GStrati).
stratifica_goods0([],_,[]).

% credibilita_d_s/1
credibilita_d_s([G|C]) :-
	good(G,_,M),
	bel(M,B),
	(d_s(E,_,_),
	 E1 is E +1,
	asserta(d_s(E1,G,B));
	asserta(d_s(1,G,B))),
	credibilita_d_s(C).
credibilita_d_s([]).

% credibilita_d_s/3
credibilita_d_s([C|Coda],G,B) :- % NON ci sono informazioni significative
	ass(_,C,F,_),
	att(F,A),
	B1 is B * A,
	credibilita_d_s(Coda,G,B1).
credibilita_d_s([],G,B) :-
	(d_s(E,_,_),
	 E1 is E +1,
	asserta(d_s(E1,G,B));
	asserta(d_s(1,G,B))).

% credibilita_media/3
credibilita_media([G|C],Lns,P) :-
	length(G,LG),
	L is LG + Lns,
	credibilita_media0(G,L,P,M),
	(media(E,_,_),
	 E1 is E +1,
	asserta(media(E1,G,M));
	asserta(media(1,G,M))),
	credibilita_media(C,Lns,P).
credibilita_media([],_,_).

credibilita_media0([T|C],L,Acc,M) :-
	b(T,Bel),
	NAcc is Acc + Bel,
	credibilita_media0(C,L,NAcc,M).
credibilita_media0([],L,Acc,M) :-
	M is Acc / L.


% =====================================================================
aggiungi(T,Y,Z) :-
    setof(Atomica,foglia(T,Atomica),Atomiche),
    transla(T,Clausole),
    asser_info(Clausole,Y), % crea DB ass(E,C,F) e clausola_lista(C,L)
    asser_fonte(Y,Z),
    asser_atomiche(Atomiche),
    elabora,!.
% foglia(+Termine,-F)
% dato il Termine seleziona nondeterminisicamente un suo atomo
% ?- foglia(non a or b, F).
% F = a ;
% F = b
    foglia(F,F) :-
	atomic(F),
	!.
    foglia(F,L) :-
	F =.. [_|Argomenti],
	member(X,Argomenti),
	foglia(X,L).

    % asser_info(+Clausole,+Fonte)
    % crea i DB ass(E,C,Fonte) e clausola_lista(C,L)
    asser_info([c(P,N)|C],F) :-
	append(P,N,PN), % mette in PN le lettere atomiche della clausola
	asser_clausola(P,N,F,PN),
	asser_info(C,F).
    asser_info([],_).

    asser_clausola(P,N,Fonte,PN) :-     % caso in cui non è la prima clausola asserita
	atomica(Atomica),                   % infatti esiste già un lettera atomica
	member(Atomica,PN), !,              % la clausola è significativa
	ass(Etichetta,_,_,_),
	E1 is Etichetta + 1,
	findall(t(E,F,A),(member(X,PN),ass(E,_,F,A),memberchk(X,A)), Triple),
	findall(Et, member(t(Et,_,_),Triple), Etichette),
	findall(Ft, member(t(_,Ft,_),Triple), Fonti),
	findall(A, (member(t(_,_,At),Triple),member(A,At)), Atomiche),
	asserta(ass(E1,c(P,N),Fonte,PN)),
	clausola_lista(c(P,N),L),    % converte la clausola in una lista per la stampa
	asserta(cl_l(c(P,N),L)),                 % asserisce la conversione effettuata
	append(PN,Atomiche,Significative),
	atomiche_significative(Significative),      % incrementa DB atomica_ind(Ind,A)
	cl_significative([E1|Etichette]),         % incrementa DB significativa(E,C,F)
	fonti_significative([Fonte|Fonti]).         % incrementa DB fonte_sign(F,Find)

asser_clausola(P,N,F,PN) :-                      % la clausola non è significativa
	ass(Etichetta,_,_,_), !,                    % non è la prima clausola asserita
	E1 is Etichetta + 1,
	asserta(ass(E1,c(P,N),F,PN)),
	clausola_lista(c(P,N),L),    % converte la clausola in una lista per la stampa
	asserta(cl_l(c(P,N),L)).                 % asserisce la conversione effettuata

asser_clausola(P,N,F,PN) :-                         % è la prima clausola asserita
	asserta(ass(1,c(P,N),F,PN)),
	clausola_lista(c(P,N),L),    % converte la clausola in una lista per la stampa
	asserta(cl_l(c(P,N),L)).                 % asserisce la conversione effettuata

atomiche_significative([A|C]) :-
	atomica_ind(_,A), !,               % l'atomica è già considerata significativa
	atomiche_significative(C).
atomiche_significative([A|C]) :-
	atomica_ind(Ind,_), !,                   % c'è almeno un'atomica significativa
	Ind1 is Ind + 1,
	asserta(atomica_ind(Ind1,A)),       % asserisce la nuova atomica significativa
	atomiche_significative(C).
atomiche_significative([A|C]) :-
	asserta(atomica_ind(0,A)),                  % è la prima atomica significativa
	atomiche_significative(C).
atomiche_significative([]).

cl_significative([E|C]) :-
	significativa(E,_,_), !,         % la clausola è già considerata significativa
	cl_significative(C).
cl_significative([E|C]) :-
	ass(E,c(P,N),F,_),
	conv(P,Pind), conv(N,Nind),
	asserta(significativa(E,c(Pind,Nind),F)),
	cl_significative(C).
cl_significative([]).

conv([T1|C1],[Indice|C2]) :-
	atomica_ind(Indice,T1),
	conv(C1,C2).
conv([],[]).


fonti_significative([F|C]) :-
	fonte_sign(F,_), !,                 % la fonte è già considerata significativa
	fonti_significative(C).
fonti_significative([F|C]) :-
	fonte_sign(_,Ind), !,                     % c'è almeno una fonte significativa
	Ind1 is Ind + 1,
	asserta(fonte_sign(F,Ind1)),          % asserisce la nuova fonte significativa
	fonti_significative(C).
fonti_significative([F|C]) :-
	asserta(fonte_sign(F,0)),                    % è la prima fonte significativa
	fonti_significative(C).
fonti_significative([]).

asser_fonte(F,_) :-                                            % la fonte c'è già
	att(F,_), !.
asser_fonte(F,A) :-                                            % la fonte è nuova
	asserta(att(F,A)).

asser_atomiche([A|C]) :-                             % la lettera atomica c'è già
	atomica(A), !,
	asser_atomiche(C).
asser_atomiche([A|C]) :-                             % la lettera atomica è nuova
	asserta(atomica(A)),
	asser_atomiche(C).
asser_atomiche([]).
