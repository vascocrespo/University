
estado_inicial([[v,v,v],[v,v,v],[v,v,v]]).


joga :-  
	estado_inicial(Ei), 
	minimax_decidir(Ei,Op),
	write(Op),nl.


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


oper(E, J,joga(X,Y), En) :-
	joga_vazio(E,J,X, Y, En).



joga_vazio([[v,C2,C3],[X,L21,L22],L3], J, 1, 1, [[J,C2,C3],[X,L21,L22],L3]) :- X \= v.
joga_vazio([[C1,v,C3],[L21,X,L22],L3], J, 1, 2, [[C1,J,C3],[L21,X,L22],L3]) :- X \= v.
joga_vazio([[C1,C3,v],[L21,L22,X],L3], J, 1, 3, [[C1,C3,J],[L21,L22,X],L3]) :- X \= v.

joga_vazio([L1,[v,C2,C3],[X,L21,L22]], J, 2, 1, [L1,[J,C2,C3],[X,L21,L22]]) :- X \= v.
joga_vazio([L1,[C1,v,C3],[L21,X,L22]], J, 2, 2, [L1,[C1,J,C3],[L21,X,L22]]) :- X \= v.
joga_vazio([L1,[C1,C3,v],[L21,L22,X]], J, 2, 3, [L1,[C1,C3,J],[L21,L22,X]]) :- X \= v.

joga_vazio([L1,L2,[v,C2,C3]], J, 3, 1, [L1,L2,[J,C2,C3]]).
joga_vazio([L1,L2,[C1,v,C3]], J, 3, 2, [L1,L2,[C1,J,C3]]).
joga_vazio([L1,L2,[C1,C2,v]], J, 3, 3, [L1,L2,[C1,C2,J]]).

minimax_decidir(Ei,terminou) :- terminal(Ei).


% Nota: assume que o jogador é o "x"
minimax_decidir(Ei,Opf) :- 
	findall(Vc-Op, (oper(Ei,x,Op,Es), minimax_valor(Es,Vc,1)), L),
	escolhe_max(L,Opf).


minimax_valor(Ei,Val,_) :- 
	terminal(Ei), 
	valor(Ei,Val).


minimax_valor(Ei,Val,P) :- 
	P1 is P+1, jogador(P1,J),
	findall(Val1, (oper(Ei,J,_,Es), minimax_valor(Es,Val1,P1)), V),
	seleciona_valor(V,P,Val).



jogador(P, o) :- X is P mod 2, X = 0.
jogador(P, x) :- X is P mod 2, X = 1.


seleciona_valor(V,P,Val) :- 
	X is P mod 2, X=0,!, 
	maximo(V,Val).


seleciona_valor(V,_,Val):- minimo(V,Val).


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
