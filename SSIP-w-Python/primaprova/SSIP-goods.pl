:- use_module(library(ordsets)).

% genera_goods(+KB,-Goods) crea il DB "good(Clausole,Etichette,Modelli)"
genera_goods(KB,Goods) :-
	genera_hstree(KB,HS),                       % genera gli Hitting Sets
	complementi(KB,HS,Goods), % genera i Goods come complementi degli HSs
	database_goods(Goods).              % asserisce il database dei Goods

% genera_hstree(+KB,-HS) dato l'insieme di clausole KB genera l'insieme degli
% Hitting_Set dei Nogoods contenuti in KB
genera_hstree(KB,HS) :-
	inc(KB,Radice),	% etichetta nodo radice con sottoinsieme inconsistente
	assert(h(Radice,[],_)),	% lo asserisce con H=[] e successori incogniti
	genera(KB,HS).		     % genera i successivi livelli dell'albero

% genera(+KB,-HS) prende il primo nodo i cui successori non sono stati generati
% e li genera, finché sono stati generati i successori di tutti i nodi
genera(KB,HS) :-
	h(L,H,S), var(S),          % nodo con successori non istanziati
	genera_successori(KB,L,H), % istanzia i successori
	regola_5(L), !,            % controllo regola di potatura 5
	genera(KB,HS).
genera(_,HS) :-
	findall(H,h(nil,H,[]),HS), % istanzia HS
	abolish(h,3).

% genera_successori(+KB,+L,+H) trova i successori del nodo con etichetta L e
% percorso H, poi rimuove dal database il fatto corrispondente a quel nodo
% rimpiazzandolo in coda con un fatto analogo in cui però i successori
% sono istanziati
genera_successori(_,nil,H) :-    % determina i successori di un nodo nil
	retract(h(nil,H,_)),
	assert(h(nil,H,[])),!.
genera_successori(_,x,H) :-      % determina i successori di un nodo potato
	retract(h(x,H,_)),
	assert(h(x,H,[])),!.
genera_successori(KB,L,H) :-   % determina i successori di un nodo intermedio
	member(El,L),	% prende una clausola nell'etichetta del nodo
	complemento(KB,[El|H],Compl),     % Compl = KB - El - H
	genera_nodo(L,Lsuc,[El|H],Compl), % genera etichetta di un nodo successore
	assertz(h(Lsuc,[El|H],_)),        % lo asserisce con successori incogniti
	assert(suc(Lsuc/[El|H])),         % registra coppia L/H di nodo successore
	fail.
genera_successori(_,L,H) :-
	bagof(S,suc(S),Successori),   % trova tutte le coppie L/H di successori
	abolish(suc,1),               % cancella successori
	retract(h(L,H,_)),
	% ritratta nodo con successori incogniti
	assert(h(L,H,Successori)),!. % asserisce nodo con sucessori noti

% genera_nodo(+Lnodo,-Lsuc,+H,+C) data l'etichetta Lnodo e l'insieme di clausole
% C, genera l'etichetta Lsuc di un nodo successore con percorso H, tenendo in
% conto le regole di potatura 2, 3, 4 e parte di 5
genera_nodo(Lnodo,Lsuc,H,C) :-
	(regola_3_4(Lsuc,H), !) % se soddisfatta 3 o 4 allora il ramo è potato
	;
	(regola_2(Lsuc,H), ! % altrimenti, si cerca di riutilizzare un'etichetta
	 ;
	  (inc(C,L1),	 % altrimenti si cerca un nuovo insieme inconsistente
	  (L1 \== nil,	                    % se c'è e
           sottoinsieme(Lnodo,L1), % è sottoinsieme del nodo genitore
           Lsuc = x, !             % il ramo viene potato
	   ;
	   Lsuc = L1))).	   % altrimenti diviene l'etichetta del successore

regola_2(L,H) :-
	h(L,_,_),
	L \== nil, L \== x,
	\+ (member(Clausola,H),member(Clausola,L)).

regola_3_4(x,H) :-
	h(_,H,_), !	        % regola 4
	;
	h(nil,Hnil,_),		% regola 3
	sottoinsieme(H,Hnil).

% regola_5(+L) controlla che non esista un nodo la cui etichetta è un
% superinsieme di L, in caso negativo applica la regola 5 di potatura
regola_5(L) :-
	L \== nil,L \== x,
	h(LL,_,S), LL \== nil, LL \== x, LL \== L,
	sottoinsieme(LL,L),
	complemento(LL,L,C),
	pota(C,S).
regola_5(_) :- !.

% pota(+C,+S) termina con fallimento (vedi pota_successore(+L,+H)) causando
% l'esplorazione di tutto l'HS-TREE
pota(C,S) :-
	member(L,C), member(L/H,S),
	pota_successore(L,H).

% pota_successore(+L,+H) è una ricorsione senza tappo che termina sempre
% per fallimento grazie al retract che prima o poi fallisce provocando
% il BT al on del passo precedente il cui nondeterminismo assicura
% l'esplorazione di tutto il sottoalbero
pota_successore(L,H) :-
	retract(h(L,H,S)),
	member(LL/HH,S),
	pota_successore(LL,HH).

% genera il database dei Goods passatigli
database_goods([G|C]) :-
	findall(E,(member(Cl,G),significativa(E,Cl,_)),Etichette),
	findall(M,(member(Cl,G),modelli(Cl,M)),MM),
	intersezione_resto(MM,Modelli),
	assert(good(G,Etichette,Modelli)),
	database_goods(C).
database_goods([]).

complementi(KB,[T1|C1],[T2|C2]) :-
	complemento(KB,T1,T2),
	complementi(KB,C1,C2).
complementi(_,[],[]).
















