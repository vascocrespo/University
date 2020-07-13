

%matriz transposta

transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).


/*-------------------------------------------------------------*/

%Contar a ocorrencia de 1's numa lista
contar([],0).
contar([H|T],X):-
	contar(T, X1),
	X is (H+X1).


%confirmar se existem X 1's seguidos na lista T a partir do inicio e sem espacos
n_seguidos(0, L, L).
n_seguidos(X, [1|L], T):-
	X>0,
	X1 is X-1,
	n_seguidos(X1,L,T).


%necessidade de ter um 0 a seguir aos 1's
espaco_obrigatorio(T,T,[]).
espaco_obrigatorio([0|T],T,X).


%verifica se a lista L1 esta correta dando certas restricoes
verifica_restricoes([],[]) :- !.
verifica_restricoes(L1, [H|T]) :-
	primeiro_um(L1, Fim1),
	n_seguidos(H,Fim1,Fim2),
	espaco_obrigatorio(Fim2,Fim3,T),
	primeiro_um(Fim3,Fim4),
	verifica_restricoes(Fim4,T).


%dado uma certa lista leva a cabeca da lista para o primeiro 1
primeiro_um([],[]).
primeiro_um([1|T], [1|T]).
primeiro_um([0|T],R) :-
    primeiro_um(T, R).


%aplica as resticoes dadas a uma lista
restricoes_lista(C,P,Lista):-
	contar(Lista,K),
	Size is P-K,
	length(C,P),
	fd_domain(C,0,1),
	fd_exactly(K,C,1),
	fd_exactly(Size,C,0),
	verifica_restricoes(C,Lista).


/*-------------------------------------------------------------*/


%{[" "," "], NLinhas}
%cria a matriz com o resultado
matrizFinal([],_,0).
matrizFinal([A|B], [C,D|_],N ):-
	length(D, Colunas),
	length(A,Colunas),
	fd_domain(A,0,1),
	N1 is N-1,
	matrizFinal(B,[C,D|_],N1).


 % {[1,2],MatrizFinal}

%aplica as restricoes a todas as listas da matriz
restricoes_matriz(_,[],_).
restricoes_matriz([C|D], [A|B], Colunas) :-
	length(Colunas,N1),
	restricoes_lista(A, N1, C),
	restricoes_matriz(D,B,Colunas).


%resolve e aplica as restricoes a matriz

solve([[Linhas|RestoLinhas]|[[Colunas|RestoColunas]]],Final2) :-
	length([Linhas|RestoLinhas],Nlinhas),
	matrizFinal(Final,[[Linhas|RestoLinhas],[Colunas|RestoColunas]|[]],Nlinhas),
	restricoes_matriz([Linhas|RestoLinhas], Final, [Colunas|RestoColunas]),
	transpose(Final,FinalTransposta),
	restricoes_matriz([Colunas|RestoColunas], FinalTransposta, [Linhas|RestoColunas]),
	transpose(FinalTransposta, Final2),
	Final2 \= [],
	maplist(fd_labeling,Final2).


%trocar os 1's por 'X' e os 0's por '.'
switch([[]],[[]]).
switch([[]|Resto],[[]|C]) :- switch(Resto,C).
switch([[0|X]|Resto], [['.'|L]|C]) :- switch([X|Resto],[L|C]).
switch([[1|X]|Resto], [['X'|L]|C]) :-switch([X|Resto],[L|C]).


%fazer print da matriz
printFinal([]).
printFinal([[]|Resto]) :- nl,
	printFinal(Resto).
printFinal([[A|X]|Resto]) :-
	write(A), 
	printFinal([X|Resto]).


%fazer o output
puzzle([[Linhas|RestoLinhas]|[[Colunas|RestoColunas]]]) :-
	solve([[Linhas|RestoLinhas]|[[Colunas|RestoColunas]]], X),
	switch(X,Y),
	printFinal(Y).



















	
	
