%Descricao do problema:

%estado_inicial(Estado)
estado_inicial([1, 1]).

%estado_final(Estado)
estado_final([4, 4]).

%representacao dos operadores
%op(Eact,OP,Eseg,Custo)

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

/*op([X, Y], andarHorizontalCima, [X, Y1], 1) :-
	((X \= 1; Y \= 2),
	(X \= 2; Y \= 2),
	(X \= 3; Y \= 3),
	(X \= 3; Y \= 2),
	(X \= 4; Y \= 3)),
	Y1 is Y - 1,
	Y > 1.


op([X,Y], andaVerticalCima, [X1, Y], 1):-
	(X \= 4; Y \=1),
	X1 is X - 1,
	X > 1.
*/
%representacao dos nos
%no(Estado,no_pai,Operador,Custo,Profundidade)

pesquisa_largura([no(E,Pai,Op,C,P)|_],no(E,Pai,Op,C,P)) :- 
	estado_final(E).
pesquisa_largura([E|R],Sol):- 
	expande(E,Lseg),
        insere_fim(Lseg,R,LFinal),
        pesquisa_largura(LFinal,Sol).

expande(no(E,Pai,Op,C,P),L):- 
	findall(no(En,no(E,Pai,Op,C,P), Opn, Cnn, P1),
                (op(E,Opn,En,Cn), P1 is P+1, Cnn is Cn+C),L).

pesquisa :-
	estado_inicial(S0),
	pesquisa_largura([no(S0,[],[],0,0)], S),
	write(S), nl.


insere_fim([],L,L).
insere_fim(L,[],L).
insere_fim(R,[A|S],[A|L]):- insere_fim(R,S,L).
