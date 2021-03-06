
estado_inicial([[v,v,v],[v,v,v],[v,v,v]]).

joga :-  
	estado_inicial(Ei), 
	alfabeta(Ei,Op),
	write(Op),nl,
	estado_next(Ei, Op,x, En),
	write(En), nl,
	joga2(En).

joga2(En):-terminal(En), write('Terminou.'),nl.
joga2(En) :-
	read(X),
	apply(En,X, Enn),
	write(Enn),nl,
	alfabeta(Enn, Op),
	write(Op), nl,
	estado_next(Enn, Op,x, Ennn),
	write(Ennn),nl,
	joga2(Ennn).

apply([[v,B,C],[D,E,F],[G,H,I]], (1,1), [[o,B,C],[D,E,F],[G,H,I]]) :- D \= v.
apply([[A,v,C],[D,E,F],[G,H,I]], (1,2), [[A,o,C],[D,E,F],[G,H,I]]) :- E \= v.
apply([[A,B,v],[D,E,F],[G,H,I]], (1,3), [[A,B,o],[D,E,F],[G,H,I]]) :- F \= v.
apply([[A,B,C],[v,E,F],[G,H,I]], (2,1), [[A,B,C],[o,E,F],[G,H,I]]) :- G \= v.
apply([[A,B,C],[D,v,F],[G,H,I]], (2,2), [[A,B,C],[D,o,F],[G,H,I]]) :- H \= v.
apply([[A,B,C],[D,E,v],[G,H,I]], (2,3), [[A,B,C],[D,E,o],[G,H,I]]) :- I \= v.
apply([[A,B,C],[D,E,F],[v,H,I]], (3,1), [[A,B,C],[D,E,F],[o,H,I]]).
apply([[A,B,C],[D,E,F],[G,v,I]], (3,3), [[A,B,C],[D,E,F],[G,o,I]]).
apply([[A,B,C],[D,E,F],[G,H,v]], (3,3), [[A,B,C],[D,E,F],[G,H,o]]).


estado_next([[_,A,B],[C,D,E],[F,G,H]], (1,1), Jogador, [[Jogador,A,B],[C,D,E],[F,G,H]]).
estado_next([[A,_,B],[C,D,E],[F,G,H]], (1,2), Jogador, [[A,Jogador,B],[C,D,E],[F,G,H]]).
estado_next([[A,B,_],[C,D,E],[F,G,H]], (1,3), Jogador, [[A,B,Jogador],[C,D,E],[F,G,H]]).
estado_next([[A,B,C],[_,D,E],[F,G,H]], (2,1), Jogador, [[A,B,C],[Jogador,D,E],[F,G,H]]).
estado_next([[A,B,C],[D,_,E],[F,G,H]], (2,2), Jogador, [[A,B,C],[D,Jogador,E],[F,G,H]]).
estado_next([[A,B,C],[D,E,_],[F,G,H]], (2,3), Jogador, [[A,B,C],[D,E,Jogador],[F,G,H]]).
estado_next([[A,B,C],[D,E,F],[_,G,H]], (3,1), Jogador, [[A,B,C],[D,E,F],[Jogador,G,H]]).
estado_next([[A,B,C],[D,E,F],[G,_,H]], (3,2), Jogador, [[A,B,C],[D,E,F],[G,Jogador,H]]).
estado_next([[A,B,C],[D,E,F],[G,H,_]], (3,3), Jogador, [[A,B,C],[D,E,F],[G,H,Jogador]]).


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


oper(E, J,(X,Y), En) :-
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

alfabeta(Ei,terminou) :- terminal(Ei).

% Nota: assume que o jogador é o "x"
alfabeta(Ei,Opf) :- 
	findall(Vc-Op, (oper(Ei,x,Op,Es), alfabeta_min(Es,Vc,1,-10000,10000)), L),
	escolhe_max(L,Opf).



alfabeta_min(Ei,Val,_,_,_) :- 
	terminal(Ei), 
	valor(Ei,Val), !.

alfabeta_min(Ei,Val,P,Alfa,Beta) :- 
	P1 is P+1, jogador(P1,J),
	V is 10000,
	findall(Es, oper(Ei,J,_,Es), L),
	processa_lista_min(L, P1, V, Alfa, Beta, Val), !.

processa_lista_min([], _, V, _, _, V).
processa_lista_min([H|T], P, V, A, B, V1) :-
	alfabeta_max(H, V2, P, -10000, 10000),
	min(V, V2, V3),
	(V3 < A, V1 is V3; min(B, V3, B1), processa_lista_min(T, P, V3, A, B1, V1)).

min(A,B,A) :- A < B, !.
min(_, B, B).

alfabeta_max(Ei,Val,_,_,_) :- 
	terminal(Ei), 
	valor(Ei,Val), !.

alfabeta_max(Ei,Val,P,Alfa,Beta) :- 
	P1 is P+1, jogador(P1,J),
	V is -10000,
	findall(Es, oper(Ei,J,_,Es), L),
	processa_lista_max(L, P1, V, Alfa, Beta, Val), !.

processa_lista_max([], _, V, _, _, V).
processa_lista_max([H|T], P, V, A, B, V1) :-
	alfabeta_min(H, V2, P, -10000, 10000),
	max(V, V2, V3),
	(V3 >= B, V1 is V3; max(A, V3, A1), processa_lista_max(T, P, V3, A1, B, V1)).

max(A,B,B) :- A < B, !.
max(A, _, A).


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
