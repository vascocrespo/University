estado_inicial([1,1]).
estado_final([1,4]).

bloqued_horizontal(1,1).
bloqued_horizontal(2,1).
bloqued_horizontal(3,2).
bloqued_horizontal(4,2).
bloqued_horizontalTras(1,2).
bloqued_horizontalTras(2,2).
bloqued_horizontalTras(3,3).
bloqued_horizontalTras(4,3).
bloqued_vertical(3,1).
bloqued_verticalTras(4,1).

op([X,Y], andarCima, [X1, Y], 1) :-
	\+ bloqued_verticalTras(X,Y),
	X1 is X - 1,
	X > 1.


op([X,Y], andarDireita, [X,Y1], 1) :-
	\+ bloqued_horizontal(X,Y),
	Y1 is Y + 1,
	Y < 4.

op([X,Y], andarBaixo, [X1, Y], 1) :-
	\+ bloqued_vertical(X,Y),
	X1 is X + 1,
	X < 4.


op([X,Y], andarEsquerda, [X, Y1], 1) :-
	\+ bloqued_horizontalTras(X,Y),
	Y1 is Y - 1,
	Y > 1.



pesquisa_local_hill_climbingSemCiclos(E, _, X) :- 
	estado_final(E),
	write(E), write(' '), nl, write(X), write(' estados visitados.').

pesquisa_local_hill_climbingSemCiclos(E, L, X) :- 
	write(E), write(' '),
	expande(E,LSeg),
	sort(3, @=<, LSeg, LOrd),
	obtem_no(LOrd, no(ES, Op, _)),
	\+ member(ES, L),
	write(Op), nl,
	X1 is X + 1,
	(pesquisa_local_hill_climbingSemCiclos(ES,[E|L], X1) ; write(undo(Op)), write(' '), fail).

expande(E, L):- 
	findall(no(En,Opn, Heur),
                (op(E,Opn,En,_), heur(En, Heur)),
                L).


heur(_, 1).

obtem_no([H|_], H).
obtem_no([_|T], H1) :-
	obtem_no(T, H1).

pesquisa :-
	estado_inicial(S0),
	pesquisa_local_hill_climbingSemCiclos(S0, [], 1).





