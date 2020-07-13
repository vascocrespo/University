?- set_prolog_flag(answer_write_options,[ quoted(true),portray(true),spacing(next_argument)]).

estado_final(_,X,_,player1) :- X >=25.
estado_final(_,_,X,player2) :- X >=25.

estado_inicial([0,0,0,0,0,0,4,4,4,4,4,4],0,0).

posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal):-
	NumNaPosicao <12,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp1 < 13,
	NumeroFinal is Temp1.

posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal):-
	NumNaPosicao <12,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp1 > 12,
	Temp2 is Temp1 - 12,
	Temp2 < 13,
	NumeroFinal is Temp2.

posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal):-
	NumNaPosicao > 12,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp1 > 11,
	Temp2 is Temp1 - 12,
	NumeroFinal is Temp2.


posicaoFinal2(PosicaoFinal1, Finito) :-
	Finito is 13 - PosicaoFinal1.


reverterLista(A,B ) :- reverterLista(A,B,[]).
reverterLista([],X,X).
reverterLista([A|B], X, Else) :- reverterLista(B,X,[A|Else]).

jogada2([A|B], [C|D], PosicaoARetirar,NumNaPosicao) :-
	NumNaPosicao < 13,
	NumNaPosicao > 0,
	jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao).

jogada2([A|B], [E|F], PosicaoARetirar,NumNaPosicao) :-
	NumNaPosicao > 12,
	jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao),
	NumNaPosicao1 is NumNaPosicao - 11, 
	jogada2([C|D], [E|F], PosicaoARetirar,NumNaPosicao1).


jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao) :- jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao,1).
jogada([],[],_,_,_).
jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao,Atual) :-
	Temp1 is 12 - PosicaoARetirar,
	Temp2 is NumNaPosicao-Temp1,
	Temp2 > 0,
	(Atual =< Temp2;
	Atual > PosicaoARetirar),	
	Atual \= PosicaoARetirar,
	Atual < 13,
	C is A + 1,
	Atual1 is Atual+1,
	jogada(B,D,PosicaoARetirar,NumNaPosicao,Atual1). 

jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao,Atual) :-
	Temp1 is 12 - PosicaoARetirar,
	Temp2 is NumNaPosicao-Temp1,
	Temp2 =< 0,
	Atual > PosicaoARetirar,
	Temp3 is PosicaoARetirar + NumNaPosicao,
	Atual =< Temp3,
	C is A + 1,
	Atual1 is Atual+1,
	jogada(B,D,PosicaoARetirar,NumNaPosicao,Atual1). 

jogada([_|B], [C|D], PosicaoARetirar,NumNaPosicao,Atual) :-
	Atual is PosicaoARetirar,
	C is 0,
	Atual1 is Atual+1,
	jogada(B,D,PosicaoARetirar,NumNaPosicao,Atual1).


jogada([A|B], [C|D], PosicaoARetirar,NumNaPosicao,Atual) :-
	((Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp1 < 13,
	(Atual < PosicaoARetirar;
	Atual > Temp1));
	(Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp1 > 12,
	Temp2 is Temp1 - 12,
	Atual > Temp2,
	Atual < PosicaoARetirar)),
	Atual \= PosicaoARetirar, 	
	C is A,
	Atual1 is Atual + 1,
	jogada(B,D,PosicaoARetirar,NumNaPosicao,Atual1).


levarAtePosicao([A|B], PosicaoAParar,[C|D]) :- levarAtePosicao([A|B], PosicaoAParar,[C|D],1).
levarAtePosicao(A, PosicaoAParar,A,X) :-X is PosicaoAParar.
levarAtePosicao([_|B], PosicaoAParar,C,Atual) :-
	Atual \= PosicaoAParar,
	Atual1 is Atual+1,
	levarAtePosicao(B, PosicaoAParar,C,Atual1).


captura([A|B], player1,Num,PointsToAdd) :- captura([A|B], player1,Num,PointsToAdd,0).
captura([A|B], player2,Num,PointsToAdd) :- captura([A|B], player2,Num,PointsToAdd,0).
captura([A|_], player1,Num,PointsToAdd,Counter) :- ((A \= 2,A\=3);Num >12;Num <7),PointsToAdd is Counter,!.
captura([A|B], player1,Num,PointsToAdd,Counter) :-
	(A is 2;
	A is 3),
	Counter1 is Counter + A,
	Num1 is Num+1,
	captura(B, player1,Num1,PointsToAdd,Counter1).


captura([A|_], player2,Num,PointsToAdd,Counter) :- ((A \= 2,A\=3);Num >6;Num <0),PointsToAdd is Counter,!.
captura([A|B], player2,Num,PointsToAdd,Counter) :-
	(A is 2;
	A is 3),
	Counter1 is Counter + A,
	Num1 is Num+1,
	captura(B, player2,Num1,PointsToAdd,Counter1).


valor([A|B],PosicaoARetirar,ValorPosicao) :- valor([A|B],PosicaoARetirar,ValorPosicao,1).
valor([A|_],PosicaoARetirar, A, X) :- X is PosicaoARetirar.
valor([_|B],PosicaoARetirar,ValorPosicao,Atual) :-
	Atual \= PosicaoARetirar,
	Atual1 is Atual+1,
	valor(B,PosicaoARetirar,ValorPosicao,Atual1).

maxValuePlayer1([A|B],Max) :- maxValuePlayer1([A|B],Max,1,0).
maxValuePlayer1(_,Max,Atual,Verifica) :- Atual > 6, Max is Verifica,!.
maxValuePlayer1([A|B],Max,Atual,Verifica) :-
	((A > Verifica,
	Verifica1 is A,
	Atual1 is Atual+1,
	maxValuePlayer1(B,Max,Atual1,Verifica1));
	((A=<Verifica),
	Atual1 is Atual+1,
	maxValuePlayer1(B,Max,Atual1,Verifica))).


maxValuePlayer2([A|B],Max) :- maxValuePlayer2([A|B],Max,1,0).
maxValuePlayer2(_,Max,Atual,Verifica) :- Atual > 12, Max is Verifica,!.
maxValuePlayer2([A|B],Max,Atual,Verifica) :-
	Atual > 6,
	((A > Verifica,
	Verifica1 is A,
	Atual1 is Atual+1,
	maxValuePlayer2(B,Max,Atual1,Verifica1));
	((A=<Verifica),
	Atual1 is Atual+1,
	maxValuePlayer2(B,Max,Atual1,Verifica))).

maxValuePlayer2([_|B],Max,Atual,Verifica):-
	Atual < 7,
	Atual1 is Atual+1,
	maxValuePlayer2(B,Max,Atual1,Verifica).


jogadaPlayer1(A,player1,PosicaoARetirar, Points,NewLista5) :-
	posicaoFinal2(PosicaoARetirar,PosicaoARetirar2),
	PosicaoARetirar2 < 13,
	PosicaoARetirar2 > 6,
	reverterLista(A,NewLista),
	maxValuePlayer1(A, MaxValue),
	valor(NewLista,PosicaoARetirar2,ValorPosicao),
	((MaxValue > 1,
	ValorPosicao > 1);
	(MaxValue > 0,
	MaxValue < 2,
	ValorPosicao > 0)),
	jogada2(NewLista,NewLista2,PosicaoARetirar2,ValorPosicao),
	reverterLista(NewLista2,NewLista3),
	posicaoFinal(PosicaoARetirar2, ValorPosicao, NumeroFinal),
	posicaoFinal2(NumeroFinal,NumeroFinalMesmo),
	levarAtePosicao(NewLista3,NumeroFinalMesmo,NewLista4),
	captura(NewLista4,player1,NumeroFinalMesmo,Points),
	((Points >0,
	capturaSubstituir(NewLista3,PosicaoARetirar,NumeroFinalMesmo,NewLista5));
	(Points is 0,
	listasIguais(NewLista3,NewLista5))).

listasIguais(X,X).

jogadaPlayer2(A,player2,PosicaoARetirar, Points,NewLista5) :-
	posicaoFinal2(PosicaoARetirar,PosicaoARetirar2),
	PosicaoARetirar2 < 7,
	PosicaoARetirar2 > 0,
	reverterLista(A,NewLista),
	maxValuePlayer2(A, MaxValue),
	valor(NewLista,PosicaoARetirar2,ValorPosicao),
	((MaxValue > 1,
	ValorPosicao > 1);
	(MaxValue > 0,
	MaxValue < 2,
	ValorPosicao > 0)),
	jogada2(NewLista,NewLista2,PosicaoARetirar2,ValorPosicao),
	reverterLista(NewLista2,NewLista3),
	posicaoFinal(PosicaoARetirar2, ValorPosicao, NumeroFinal),
	posicaoFinal2(NumeroFinal,NumeroFinalMesmo),
	levarAtePosicao(NewLista3,NumeroFinalMesmo,NewLista4),
	captura(NewLista4,player2,NumeroFinalMesmo,Points),
	((Points >0,
	capturaSubstituir(NewLista3,PosicaoARetirar,NumeroFinalMesmo,NewLista5));
	(Points is 0,
	listasIguais(NewLista3,NewLista5))).


capturaSubstituir([A|B],PosicaoRetirada,NumComecar, [C|D]) :- capturaSubstituir([A|B],PosicaoRetirada,NumComecar,[C|D], 1,-1,0).
capturaSubstituir([],_, _,[],_, _,_).
capturaSubstituir([A|B],PosicaoRetirada,NumComecar, [C|D], Atual,ValorAnterior,_):-
	(ValorAnterior \= 0;
	(ValorAnterior is 0,(A \=2,	A \=3));
	(ValorAnterior is 0,(A is 2;A is 3), ((PosicaoRetirada < 7,Atual < 7);(PosicaoRetirada >6,Atual > 6)))),
	NumComecar \= Atual,
	C is A,
	NumAnterior1 is Atual,
	ValorAnterior1 is A,
	Atual1 is Atual+1,
	capturaSubstituir(B,PosicaoRetirada,NumComecar, D, Atual1,ValorAnterior1,NumAnterior1).

capturaSubstituir([A|B],PosicaoRetirada,NumComecar, [C|D], Atual,ValorAnterior,_) :-
	((PosicaoRetirada < 7,Atual > 6);
	(PosicaoRetirada >6,Atual < 7)),
	NumComecar =< Atual,
	((ValorAnterior is 0,Atual > NumComecar);
	Atual is NumComecar),
	(A is 2;
	A is 3),
	C is 0,
	Atual1 is Atual+1,
	NumAnterior1 is Atual,
	ValorAnterior1 is 0,
	capturaSubstituir(B,PosicaoRetirada,NumComecar, D, Atual1,ValorAnterior1,NumAnterior1).


op(Lista, Points,player1, ListaFinal,1) :-
	maxValuePlayer1(Lista,Max),
	((Max is 0,
	append(Lista,[],ListaFinal),
	Points is 0);
	(Max > 0,
	between(1,6,X),
	jogadaPlayer1(Lista,player1,X,Points,ListaFinal))).
	


op(Lista,Points,player2, ListaFinal, 1) :-
	maxValuePlayer2(Lista,Max),
	((Max is 0,
	ListaFinal is Lista);
	(Max > 0,
	between(1,6,X),
	jogadaPlayer2(Lista,player2,X,Points,ListaFinal))).


pesquisa_local_hill_climbingSemCiclos(E, Pontos1,Pontos2,_) :- 
	estado_final(E,Pontos1,Pontos2,player2),
	write(E), nl,write('player2 '),write('ganhou com '),write(Pontos2),nl.

pesquisa_local_hill_climbingSemCiclos(E, Pontos1,_,L) :- 
	write(E), write(' '),nl,
	expande(E,LSeg),
	sort(3, @=<, LSeg, LOrd),
	obtem_no(LOrd, no(ES, Op, _)),
	\+ member(ES, L),
	PontosNovos is Op + Pontos1,
	write('Estado Novo: '),write(ES),nl, 
	((PontosNovos >24, 
	write('player1 '),write('ganhou com '),write(PontosNovos),nl);
	(PontosNovos<25, 
	write('Pontos: '),write(PontosNovos))).
	%%(pesquisa_local_hill_climbingSemCiclos(ES,PontosNovos,_,[E|L]) ; write(undo(Op)), write(' '), fail).

expande(E, L):- 
	findall(no(En,Pontos,Heur),
                (op(E,Pontos,player1,En,_), heur(Pontos, Heur)),
                L).

heur(Pontos,PontosNovos) :-
	PontosNovos is -1*Pontos.

obtem_no([H|_], H).
obtem_no([_|T], H1) :-
	obtem_no(T, H1).

pesquisa :-
	estado_inicial(A,B,C),
	pesquisa_local_hill_climbingSemCiclos(A,B,C, []).