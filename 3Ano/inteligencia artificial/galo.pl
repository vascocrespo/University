% cada posicao pode ter "x", "o" ou "v" (vazio)
estado_inicial([[x,x,o],[v,o,v],[x,v,v]]).
%estado_inicial([[v,v,v],[v,v,v],[v,v,v]]).

terminal(G) :- linhas(G,_).
terminal(G) :- colunas(G,_).
terminal(G) :- diagonal(G,_).
terminal(G) :- cheio(G).

linhas([[X,X,X],_,_],X) :- X \= v.
linhas([_,[X,X,X],_],X) :- X \= v.
linhas([_,_,[X,X,X]],X) :- X \= v.

colunas([[X,_,_],[X,_,_],[X,_,_]],X) :- X \= v.
colunas([[_,X,_],[_,X,_],[_,X,_]],X) :- X \= v.
colunas([[_,_,X],[_,_,X],[_,_,X]],X) :- X \= v.

diagonal([[X,_,_],[_,X,_],[_,_,X]],X) :- X \= v.
diagonal([[_,_,X],[_,X,_],[X,_,_]],X) :- X \= v.

cheio([L1,L2,L3]) :- 
	append(L1,L2, L12),
	append(L12, L3, L123),
	\+ member(v, L123).

%função de utilidade, retorna o valor dos estados terminais, 1 ganha -1 perde
valor(G, 1) :- linhas(G,x).
valor(G, 1) :- colunas(G,x).
valor(G, 1) :- diagonal(G,x).
valor(G, -1) :- linhas(G,o).
valor(G, -1) :- colunas(G,o).
valor(G, -1) :- diagonal(G,o).
valor(_, 0).

% oper(estado,jogador,jogada,estado seguinte)
oper(E, J,joga(X,Y), En) :-
	joga_vazio(E,J,X, Y, En).

joga_vazio([[v,C2,C3],L2,L3], J, 1, 1, [[J,C2,C3],L2,L3]).
joga_vazio([[C1,v,C3],L2,L3], J, 1, 2, [[C1,J,C3],L2,L3]).
joga_vazio([[C1,C2,v],L2,L3], J, 1, 3, [[C1,C2,J],L2,L3]).
joga_vazio([L1,[v,C2,C3],L3], J, 2, 1, [L1,[J,C2,C3],L3]).
joga_vazio([L1,[C1,v,C3],L3], J, 2, 2, [L1,[C1,J,C3],L3]).
joga_vazio([L1,[C1,C2,v],L3], J, 2, 3, [L1,[C1,C2,J],L3]).
joga_vazio([L1,L2,[v,C2,C3]], J, 3, 1, [L1,L2,[J,C2,C3]]).
joga_vazio([L1,L2,[C1,v,C3]], J, 3, 2, [L1,L2,[C1,J,C3]]).
joga_vazio([L1,L2,[C1,C2,v]], J, 3, 3, [L1,L2,[C1,C2,J]]).




joga :-  
	estado_inicial(Ei), 
	minimax_decidir(Ei,Op),
	write(Op),nl.

% decide qual é a melhor jogada num estado do jogo
% minimax_decidir(Estado, MelhorJogada)

% se é estado terminal não há jogada 
minimax_decidir(Ei,terminou) :- terminal(Ei).

% Para cada estado sucessor de Ei calcula o valor minimax do estado
% Opf é o operador (jogada) que tem maior valor
% Nota: assume que o jogador é o "x"
minimax_decidir(Ei,Opf) :- 
	findall(Vc-Op, (oper(Ei,x,Op,Es), minimax_valor(Es,Vc,1)), L),
	escolhe_max(L,Opf).

% se um estado é terminal o valor é dado pela função de utilidade
% Nota: assume que o jogador é o "x"
minimax_valor(Ei,Val,_) :- 
	terminal(Ei), 
	valor(Ei,Val).

%Se o estado não é terminal o valor é:
% -se a profundidade é par, o maior valor dos sucessores de Ei
% -se aprofundidade é impar o menor valor dos sucessores de Ei
minimax_valor(Ei,Val,P) :- 
	P1 is P+1, jogador(P1,J),
	findall(Val1, (oper(Ei,J,_,Es), minimax_valor(Es,Val1,P1)), V),
	seleciona_valor(V,P,Val).


% jogador "x" nas jogadas impares e jogador "o" nas jogadas pares
jogador(P, o) :- X is P mod 2, X = 0.
jogador(P, x) :- X is P mod 2, X = 1.

% Se a profundidade (P) é par, retorna em Val o maximo de V
seleciona_valor(V,P,Val) :- 
	X is P mod 2, X=0,!, 
	maximo(V,Val).

% Senão retorna em Val o minimo de V
seleciona_valor(V,_,Val):- minimo(V,Val).

%% Predicados auxiliares

escolhe_max([A|R],Val):- escolhe_max(R,A,Val).

escolhe_max([],_-Op,Op).
escolhe_max([A-_|R],X-Op,Val) :- A < X,!, escolhe_max(R,X-Op,Val).
escolhe_max([A|R],_,Val):- escolhe_max(R,A,Val).


maximo([A|R],Val):- maximo(R,A,Val).

maximo([],A,A).
maximo([A|R],X,Val):- A < X,!, maximo(R,X,Val).
maximo([A|R],_,Val):- maximo(R,A,Val).

minimo([A|R],Val):- minimo(R,A,Val).

minimo([],A,A).
minimo([A|R],X,Val):- A > X,!, minimo(R,X,Val).
minimo([A|R],_,Val):- minimo(R,A,Val).
