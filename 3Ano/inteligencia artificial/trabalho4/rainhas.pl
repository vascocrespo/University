
changeRainha([],_,_,_).
changeRainha([[A,_]|C], Lista,Rainha, D) :-
	A \= Rainha,
	changeRainha(C,Lista,Rainha, D).

changeRainha([[A,B]|_], Lista,Rainha, D) :-
	A = Rainha,
	doColuna([A,B], Lista, D),
	changeRainha([], Lista,Rainha, D).

doColuna([A,B], Lista, D) :-
	tamanho(N),
	N1 is N-1,
	between(0,N1,Line), 
	B1 is Line + 1,
	B1 < N + 1,
	select([A,B], Lista, [A,B1],D).

operation(Lista, mover, ListaFinal,1) :-
	tamanho(N),
	between(1,N,X),
	changeRainha(Lista,Lista, X,ListaFinal).



createQueens(N, [[A|B]|C]) :- createQueens(N, [[A|B]|C],1).
createQueens(N,[],Row) :- Row is N + 1.
createQueens(N, [[A,B]|C], Row) :-
	Row < N+1,
	A is 1*Row,
	B is 1,
	Row1 is Row + 1,
	createQueens(N,C, Row1). 



vertical(X,Y,X1,Y1,N) :-
	Y1 is Y,
	X1 < N+1,
	X1 > 0,
	X1 \= X.


diagonal(X,Y,X1,Y1,N) :-diagonal(X,Y,X1,Y1,N,1).
diagonal(X,Y,X1,Y1,N,P) :-
	(X2 is X + P,
	Y2 is Y + P,
	X3 is X - P,
	Y3 is Y - P,
	((X1 is X2,
	Y1 is Y2);
	(X1 is X3,
	Y1 is Y3);
	(X1 is X3,
	Y1 is Y2);
	(X1 is X2,
	Y1 is Y3)),!);
	P1 is P+1,
	P1 \= N,
	diagonal(X,Y,X1,Y1,N,P1).



heuristica([X,Y],[[X1,Y1]|B],N, Counter) :- heuristica([X,Y],[[X1,Y1]|B],N, Counter,0).
heuristica([_,_],[],_,Counter,Start) :- Counter is Start,!.
heuristica([X,Y],[[X1,Y1]|B],N, Counter, Start ) :-
	(vertical(X,Y,X1,Y1,N);
	diagonal(X,Y,X1,Y1,N)),
	Start1 is Start + 1,
	heuristica([X,Y],B,N,Counter,Start1).
	
heuristica([X,Y],[[_,_]|B],N, Counter, Start ) :-
	heuristica([X,Y],B,N,Counter,Start).

totalHeuristica([A|B], N, Counter) :- totalHeuristica([A|B], N, Counter,0,0).
totalHeuristica([[_,_]],_,Counter,_,Something) :- Counter is Something,!.
totalHeuristica([A|B], N, Counter,_,Something) :-
	heuristica(A,B,N, Counter1),
	Counter2 is Something + Counter1,
	totalHeuristica(B,N,Counter,Counter1,Counter2).


pesquisa_local_hill_climbingSemCiclos(E, _) :- 
	tamanho(N),
	heur(E,C),
	C is 0,
	%%write(E), nl,
	tabuleiro(E,_,N).
	

pesquisa_local_hill_climbingSemCiclos(E, L) :- 
	expande(E,LSeg),
	sort(3, @=<, LSeg, LOrd),
	obtem_no(LOrd, no(ES, Op, _)),
	\+ member(ES, L),
	(pesquisa_local_hill_climbingSemCiclos(ES,[E|L]) ; write(undo(Op)), write(' '), fail).

expande(E, L):- 
	findall(no(En,Opn, Heur),
                (operation(E,Opn,En,_), heur(En, Heur)),
                L),
	write(L).

heur(En,Heur) :-
	length(En,N),
	totalHeuristica(En, N, Heur),!.


obtem_no([H|_], H).
obtem_no([_|T], H1) :-
	obtem_no(T, H1).


linhaTabuleiro([A,B], D, N) :- linhaTabuleiro([A,B], D, N,[]) .
linhaTabuleiro(_,D,0,L) :- select(_,[L],L,D),!.
linhaTabuleiro([A,B], D, N,L) :-
	B1 is N - B,
	B1 \= 0,
	N1 is N - 1,
	append([v],L,C),
	linhaTabuleiro([A,B],D,N1,C).

linhaTabuleiro([A,B], D, N,L) :-
	B1 is N - B,
	B1 = 0,
	N1 is N - 1,
	append([r],L,C),
	linhaTabuleiro([A,B],D,N1,C).

tabuleiro([],Lista2,_) :- write(Lista2),!.
tabuleiro([A|C],_,N) :-
	length([A|C],E),
	E = N,
	linhaTabuleiro(A,D,N),
	tabuleiro(C,D,N).

tabuleiro([A|C], Lista, N) :-
	linhaTabuleiro(A,D,N),
	append(Lista,D,Lista2),
	tabuleiro(C,Lista2,N).



joga :-
	read(N),
	time(jogaAuxiliar(N)).
	

jogaAuxiliar(N) :-
	assert(tamanho(N)),
	createQueens(N,X),
	pesquisa_local_hill_climbingSemCiclos(X, []).

