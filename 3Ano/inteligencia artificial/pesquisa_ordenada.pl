estado_inicial([1, 1]).
estado_final([4, 4]).

op([3, 2], andarHorizontalCima, [2, 2], 1).
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


pesquisa_aux([no(E,Pai,Op,C,CH,P)|_],no(E,Pai,Op,C,CH,P)) :- 
	estado_final(E).
pesquisa_aux([E|R],Sol):- 
	expande(E,Lseg),
        insere_ordenado(Lseg,R,LFinal),
        pesquisa_aux(LFinal,Sol).

expande(no(E,Pai,Op,C,CH,P),L):- 
	findall(no(En,no(E,Pai,Op,C,CH,P), Opn, Cnn, CHn, P1),
                (op(E,Opn,En,Cn), P1 is P+1, Cnn is Cn+C, heur(En,H), CHn is Cnn + H), L).

pesquisa :-
	estado_inicial(S0),
	pesquisa_aux([no(S0,[],[],0,0,0)], S),
	write(S), nl.


heur([X,Y], H):-
	estado_final([XF, YF]),
	X1 is XF-X,
	Y1 is YF-Y,
	H is X1+Y1. 

ins_ord(E, [], [E]).
ins_ord(no(E,Pai,Op,C,CH,P), [no(E1,Pai1,Op1,C1,CH1,P1)|T], [no(E,Pai,Op,C,CH,P),no(E1,Pai1,Op1,C1,CH1,P1)|T]) :- C =< C1.
ins_ord(no(E,Pai,Op,C,CH,P), [no(E1,Pai1,Op1,C1,CH1,P1)|T], [no(E1,Pai1,Op1,C1,CH1,P1)|T1]) :-
	ins_ord(no(E,Pai,Op,C,CH,P), T, T1).	

insere_ordenado([],L,L).
insere_ordenado([A|T], L, LF):- 
	ins_ord(A,L,L1),
	insere_ordenado(T, L1, LF).