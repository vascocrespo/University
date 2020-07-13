estado_inicial([1, 1]).
estado_final([4, 4]).

op([3, 2], andarVerticalCima, [2, 2], 1).
op([X, Y], andarHorizontal, [X, Y1], 1) :-
	((X \= 1; Y \= 1),
	(X \= 2; Y \= 1),
	(X \= 3; Y \= 2),
	(X \= 4; Y \= 2)),
	Y1 is Y + 1,
	Y < 4.

op([X,Y], andaVertical, [X1, Y], 1) :-
	(X \= 3; Y \=1),
	X1 is X + 1,
	X < 4.


pesquisa_aux(_, [no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P)) :- 
	estado_final(E).
pesquisa_aux(N, [no(E,Pai,Op,C,P)|R],Sol):- 
	P < N,
	expande(no(E,Pai,Op,C,P),Lseg),
        insere_inicio(Lseg,R,LFinal),
        pesquisa_aux(N, LFinal,Sol).
pesquisa_aux(N, [no(_,_,_,_,P)|R],Sol):- 
	P == N,
        pesquisa_aux(N, R, Sol).


expande(no(E,Pai,Op,C,P),L):- 
	findall(no(En,no(E,Pai,Op,C,P), Opn, Cnn, P1),
                (op(E,Opn,En,Cn), P1 is P+1, Cnn is Cn+C),
                L).

p_iterativa(N, S0, S) :-
	pesquisa_aux(N, S0, S).

p_iterativa(N, S0, S) :-
	N1 is N + 1,
	p_iterativa(N1, S0, S).

pesquisa :-
	estado_inicial(S0),
	p_iterativa(1, [no(S0,[],[],0,0)], S),
	write(S), nl.


insere_inicio(A,B,C) :- append(A, B, C).
insere_fim(A,B,C) :- append(B, A, C).
