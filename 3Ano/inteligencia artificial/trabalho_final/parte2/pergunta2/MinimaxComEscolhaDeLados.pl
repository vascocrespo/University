?- set_prolog_flag(answer_write_options,[ quoted(true),portray(true),spacing(next_argument)]).

terminal(_,X,_) :- X >=25.
terminal(_,_,X) :- X >=25.
terminal([0,0,0,0,0,0,A,B,C,D,E,F],_,_) :- A <1,B < 2, C <3,D < 4, E < 5, F < 6.
terminal([A,B,C,D,E,F,0,0,0,0,0,0],_,_) :- A <1,B < 2, C <3,D < 4, E < 5, F < 6.
terminal([0,0,0,0,0,0,0,0,0,0,0,0],_,_).

estado_inicial([4,4,4,4,4,4,4,4,4,4,4,4],0,0).

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



posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal) :-
	NumNaPosicao > 11,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	NumNaPosicao < 23,
	Temp2 is Temp1-11,
	((Temp2 > 12,
	Temp3 is Temp2-11,
	((Temp3 =< PosicaoARetirar,
	NumeroFinal is Temp3-1);
	(Temp3 >PosicaoARetirar,
	NumeroFinal is Temp3)));
	(Temp2 < 13,
	NumeroFinal is Temp2)).

posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal) :-
	NumNaPosicao >= 23,
	NumNaPosicao < 35,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp2 is Temp1 - 11,
	Temp3 is Temp2 -11,
	((Temp3 > 12,
	Temp4 is Temp3 -11,
	((Temp4 =< PosicaoARetirar,
	NumeroFinal is Temp4 -1);
	(Temp4 >PosicaoARetirar,
	NumeroFinal is Temp4)));
	(Temp3 < 13,
	NumeroFinal is Temp3)).
	
posicaoFinal(PosicaoARetirar, NumNaPosicao, NumeroFinal) :-
	NumNaPosicao >= 35,
	NumNaPosicao < 47,
	Temp1 is PosicaoARetirar+NumNaPosicao,
	Temp2 is Temp1 - 11,
	Temp3 is Temp2 - 11,
	Temp4 is Temp3 - 11,
	((Temp4 > 12,
	Temp5 is Temp4 - 11,
	((Temp5 =< PosicaoARetirar,
	NumeroFinal is Temp5 - 1);
	(Temp5 > PosicaoARetirar,
	NumeroFinal is Temp5)));
	(Temp4 < 13,
	NumeroFinal is Temp4)).


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
levarAtePosicao(A, PosicaoAParar,A,X) :-X is PosicaoAParar,!.
levarAtePosicao([_|B], PosicaoAParar,C,Atual) :-
	Atual \= PosicaoAParar,
	Atual1 is Atual+1,
	levarAtePosicao(B, PosicaoAParar,C,Atual1).


captura([A|B], player1,Num,PointsToAdd) :- captura([A|B], player1,Num,PointsToAdd,0).
captura([A|B], player2,Num,PointsToAdd) :- captura([A|B], player2,Num,PointsToAdd,0).
captura([A|_], player1,Num,PointsToAdd,Counter) :- ((A \= 2,A\=3);Num >12;Num <7),PointsToAdd is Counter,!.
captura([], player1,Num,PointsToAdd,Counter) :- ((A \= 2,A\=3);Num >12;Num <7),PointsToAdd is Counter,!.
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
valor([A|_],PosicaoARetirar, A, X) :- X is PosicaoARetirar,!.
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
	maxValuePlayer2(A,MaxValue2),
	((MaxValue2 is 0,
	MaxValue > 0,
	ValorPosicao > 0);
	(MaxValue2 > 0,
	MaxValue > 1,
	ValorPosicao > 1);
	(MaxValue2 > 0,
	MaxValue > 0,
	MaxValue < 2,
    ValorPosicao > 0)),
	jogada2(NewLista,NewLista2,PosicaoARetirar2,ValorPosicao),
    reverterLista(NewLista2,NewLista3),
	posicaoFinal(PosicaoARetirar2, ValorPosicao, NumeroFinal),
	posicaoFinal2(NumeroFinal,NumeroFinalMesmo),
    levarAtePosicao(NewLista3,NumeroFinalMesmo,NewLista4),
    captura(NewLista4,player1,NumeroFinalMesmo,Points),
	((Points >0,
	capturaSubstituir(NewLista3,ValorPosicao,PosicaoARetirar,NumeroFinalMesmo,NewLista5));
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
	maxValuePlayer1(A,MaxValue2),
	((MaxValue2 is 0,
	MaxValue > 0,
	ValorPosicao > 0);
	(MaxValue2 > 0,
	MaxValue > 1,
	ValorPosicao > 1);
	(MaxValue2 > 0,
	MaxValue > 0,
	MaxValue < 2,
	ValorPosicao > 0)),
	jogada2(NewLista,NewLista2,PosicaoARetirar2,ValorPosicao),
	reverterLista(NewLista2,NewLista3),
	posicaoFinal(PosicaoARetirar2, ValorPosicao, NumeroFinal),
	posicaoFinal2(NumeroFinal,NumeroFinalMesmo),
	levarAtePosicao(NewLista3,NumeroFinalMesmo,NewLista4),
	captura(NewLista4,player2,NumeroFinalMesmo,Points),
	((Points >0,
	capturaSubstituir(NewLista3,ValorPosicao,PosicaoARetirar,NumeroFinalMesmo,NewLista5));
	(Points is 0,
	listasIguais(NewLista3,NewLista5))).


capturaSubstituir([A|B],NumPosicaoARetirar,PosicaoRetirada,NumComecar, [C|D]) :- capturaSubstituir([A|B],NumPosicaoARetirar,PosicaoRetirada,NumComecar,[C|D], 1,-1,0).
capturaSubstituir([],_,_, _,[],_, _,_).
capturaSubstituir([A|B],NumPosicaoARetirar,PosicaoRetirada,NumComecar, [C|D], Atual,ValorAnterior,_):-
	(ValorAnterior \= 0;
	(ValorAnterior is 0,(A \=2,	A \=3));
	(ValorAnterior is 0,(A is 2;A is 3), ((PosicaoRetirada > 6, Atual >6);(PosicaoRetirada < 7, Atual < 7) ; Atual < NumComecar))),
	(NumComecar \= Atual),
	C is A,
	NumAnterior1 is Atual,
	ValorAnterior1 is A,
	Atual1 is Atual+1,
	capturaSubstituir(B,NumPosicaoARetirar,PosicaoRetirada,NumComecar, D, Atual1,ValorAnterior1,NumAnterior1).

capturaSubstituir([A|B],NumPosicaoARetirar,PosicaoRetirada,NumComecar, [C|D], Atual,ValorAnterior,_) :-
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
	capturaSubstituir(B,NumPosicaoARetirar,PosicaoRetirada,NumComecar, D, Atual1,ValorAnterior1,NumAnterior1).


oper(Lista, Points1,Points2,player1, PointsNovos1,PointsNovos2,Y,ListaFinal,_) :-
	maxValuePlayer1(Lista,Max),
	maxValuePlayer2(Lista,Max2),
	((terminal(Lista,Points1,Points2),
	PointsNovos1 is Points1,
	listasIguais(Lista,ListaFinal),
	Y is 0);
	(\+terminal(Lista,Points1,Points2),
	((Max is 0,
	Max2 > 0,
	oper(Lista,Points1,Points2,player2,NewPoints1,NewPoints2,_,ListaNova,_),
	maxValuePlayer1(ListaNova,NewMax),
	NewMax > 0,
    oper(ListaNova,NewPoints1,NewPoints2,player1,PointsNovos1,PointsNovos2,Y,ListaFinal,_));
    (Max2 is 0,
	Max > 0,
	between(1,6,X),
	Y is X,
	jogadaPlayer1(Lista,player1,X,PointsNovos,ListaFinal),
	maxValuePlayer2(ListaFinal,NewMaxMax),
	NewMaxMax > 0,
	PointsNovos1 is Points1+PointsNovos);
	(Max > 0,
    Max2 > 0,
    between(1,6,X),
	Y is X,
    jogadaPlayer1(Lista,player1,X,PointsNovos,ListaFinal),
	PointsNovos1 is Points1+PointsNovos)))),
	PointsNovos2 is Points2.
	


oper(Lista,Points1,Points2,player2, PointsNovos1,PointsNovos2,Y,ListaFinal,_) :-
	maxValuePlayer2(Lista,Max),
	maxValuePlayer1(Lista,Max2),
    ((terminal(Lista,Points1,Points2),
	PointsNovos2 is Points2,
	listasIguais(Lista,ListaFinal),
	Y is 0);
	(\+terminal(Lista,Points1,Points2),
	((Max is 0,
	Max2 > 0,
	oper(Lista,Points1,Points2,player1,NewPoints1,NewPoints2,_,ListaNova,_),
	maxValuePlayer2(ListaNova,NewMax),
	NewMax > 0,
    oper(ListaNova,NewPoints1,NewPoints2,player2,PointsNovos1,PointsNovos2,Y,ListaNova,_));
    (Max2 is 0,
    Max > 0,
	between(7,13,X),
	Y is X,
    jogadaPlayer2(Lista,player2,X,PointsNovos,ListaFinal),
	maxValuePlayer2(ListaFinal,NewMaxMax),
    NewMaxMax > 0,
	PointsNovos2 is Points2+PointsNovos);
	(Max > 0,
    Max2 > 0,
	between(7,13,X),
	Y is X,
	jogadaPlayer2(Lista,player2,X,PointsNovos,ListaFinal),
	PointsNovos2 is Points2+PointsNovos)))),
	PointsNovos1 is Points1.


oper2(Lista,Points1,Points2,player2, PointsNovos1,PointsNovos2,Y,ListaFinal,N) :-
    maxValuePlayer2(Lista,Max),
	maxValuePlayer1(Lista,Max2),
	((Max is 0,
    Max2 > 0,
    minimax_decidir(Lista,Points1,Points2,[Op,Es,Pontos1,Pontos2],N),
    maxValuePlayer2(Es,NewMax),
    NewMax > 0,
	write('Nao existia jogada possivel'),nl,
	prints(Lista,Es,Pontos1,Pontos2,Op),
    write('Insira outra casa: '),nl,
    read(P),
    NewJogada is 13 - P,
    oper2(Es,Pontos1,Pontos2,player2,PointsNovos1,PointsNovos2,NewJogada,ListaFinal,N));
	(Max > 0,
	jogadaPlayer2(Lista,player2,Y,PointsNovos,ListaFinal),
	PointsNovos2 is Points2+PointsNovos)),
	PointsNovos1 is Points1.


valorCheck(_,Atual,_,Pontos2,Dif) :- 
	Pontos2 >= 25,
	Dif is -25 - Atual.

valorCheck(_,Atual,Pontos1,_,Dif) :- 
	Pontos1 >=25,
	Dif is 25-Atual.

valorCheck(Ei,Atual,Pontos1,Pontos2,Dif) :-
	\+terminal(Ei,Pontos1,Pontos2),
	Pontos1 < 25,
	Pontos2 < 25, 
	Dif is Pontos1 - Pontos2 - Atual.

valorCheck(Ei,Atual,Pontos1,Pontos2,Dif) :-
	terminal(Ei,Pontos1,Pontos2),
	Pontos1 < 25,
	Pontos2 < 25, 
	Diferenca is Pontos1 - Pontos2,
	((Diferenca > 0,
	Dif is 25-Atual);
	(Diferenca < 0,
	Dif is -25-Atual);
	(Diferenca is 0,
	Dif is 0)).
	

jogaAuxiliar(N,Start) :-
    estado_inicial(Ei,Points1,Points2),
    ((Start = -s,
    continuaJogadas(Ei,Points1,Points2,N));
    ((Start = -p,
    minimax_decidir(Ei,Points1,Points2,[Op,Es,Pontos1,Pontos2],N))),
    ((\+terminal(Ei,Points1,Points2),
    terminal(Es,Pontos1,Pontos2),
	valorCheck(Es,0,Pontos1,Pontos2,Dif), 
	((Dif > 0,
	write('Ganhou!'),nl);
	(Dif < 0,
	write('Perdeu!'),nl);
	(Dif is 0,
    write('Empate!'),nl),!));
	((terminal(Ei,Points1,Points2),
	prints(Ei,Es,Pontos1,Pontos2,Op)));
    (\+terminal(Ei,Points1,Points2),
	\+terminal(Es,Pontos1,Pontos2),
	prints(Ei,Es,Pontos1,Pontos2,Op),
    continuaJogadas(Es,Pontos1,Pontos2,N)))).


mostrarLista1([A|B]) :- mostrarLista1([A|B],1).
mostrarLista1(_,7) :- nl,!.
mostrarLista1([A|B],Atual) :- 
    Atual < 7,
    Atual1 is Atual+1,
    write(A),write(', '),
    mostrarLista1(B,Atual1).



continuaJogadas(Ei,Pontos1,Pontos2,_) :- 
    terminal(Ei,Pontos1,Pontos2),
    ((Pontos1 > Pontos2,
	write('Jogador 1 ganhou'));
	(Pontos2 > Pontos1,
	write('Jogados 2 ganhou'));
	(Pontos1 is Pontos2,
	write('Empate'))),!.

continuaJogadas(Ei,Pontos1,Pontos2,N) :-
    write('Indique a sua proxima jogada: '),nl,
    read(NewJogada1),
    NewJogada is 13 - NewJogada1,
    oper2(Ei,Pontos1,Pontos2,player2,PointsNovos1,PointsNovos2,NewJogada,Es,N),
    JogadoTrue is 13 - NewJogada,
	((terminal(Es,PointsNovos1,PointsNovos2),
	prints(Ei,Es,PointsNovos1,PointsNovos2,JogadoTrue),
	((PointsNovos1 > PointsNovos2,
	write('Jogador 1 ganhou'));
	(PointsNovos2 > PointsNovos1,
	write('Jogados 2 ganhou'));
	(PointsNovos1 is PointsNovos2,
	write('Empate'))));
    (\+terminal(Es,PointsNovos1,PointsNovos2),
	minimax_decidir(Es,PointsNovos1,PointsNovos2,[Op,Es2,PontosNovos3,PontosNovos4],N),
	prints(Es,Es2,PontosNovos3,PontosNovos4,Op),
    continuaJogadas(Es2,PontosNovos3,PontosNovos4,N))).

prints(Ei,Es,PontosNovos1,PontosNovos2,Op) :-
	nl,mostrarLista1(Ei),
	reverterLista(Ei,NewList),
    mostrarLista1(NewList),nl,
	write('Posicao retirada: '),write(Op),nl,
    nl,mostrarLista1(Es),
    reverterLista(Es,NewList2),
    mostrarLista1(NewList2),nl,
	write('Pontos Jogador 1 : '), write(PontosNovos1),nl,
    write('Pontos Jogador 2 : '), write(PontosNovos2),nl,nl.
    

joga :-  
    write('Em que posicao joga o computador(-p ou -s): '),nl,
    read(Start),
	write('Escolha o número do modo que deseja usar: '),nl,
	write('1)Primeiro modo:'),nl,
	write('2)Segundo modo:'),nl,
	write('3)Terceiro modo:'),nl,
	read(TimeToStop1),
	((TimeToStop1 is 1,
	TimeToStop is 2);
	(TimeToStop1 is 2,
	TimeToStop is 4);
	(TimeToStop1 is 3,
	TimeToStop is 7)),
	jogaAuxiliar(TimeToStop,Start).



minimax_decidir(Ei,Points1,Points2,_,_) :- 
    terminal(Ei,Points1,Points2), 
	valorCheck(Ei,0,Points1,Points2,Dif), 
	((Dif > 0,
	write('Ganhou!'),nl);
	(Dif < 0,
	write('Perdeu!'),nl);
	(Dif is 0,
	write('Empate!'),nl)),!.



minimax_decidir(Ei,Points1,Points2,Opf,TimeToStop) :-
	findall(Vc-[Op,Es,PointsNovos1,PointsNovos2], (oper(Ei,Points1,Points2,player1,PointsNovos1,PointsNovos2,Op,Es,_), minimax_valor(Es,Vc,1,TimeToStop,PointsNovos1,PointsNovos2)), L),
    escolhe_max(L,Opf).



minimax_valor(Ei,Val,P,TimeToStop,Points1,Points2) :- 
    ((P is TimeToStop);
    (terminal(Ei,Points1,Points2))),
	valorCheck(Ei,P,Points1,Points2,Val).



minimax_valor(Ei,Val,P,TimeToStop,Points1,Points2) :- 
    P < TimeToStop,
	P1 is P+1, jogador(P1,J),
	findall(Val1, (oper(Ei,Points1,Points2,J,PointsNovos1,PointsNovos2,_,Es,_), minimax_valor(Es,Val1,P1, TimeToStop,PointsNovos1,PointsNovos2)), V),
    seleciona_valor(V,P,Val).
    %write(Val),nl.



jogador(P, player2) :- X is P mod 2, X = 0.
jogador(P, player1) :- X is P mod 2, X = 1.


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
maximo([A-_|R],X,Val):-  A < X,!, maximo(R,X,Val).
maximo([A|R],_,Val):- maximo(R,A,Val).

minimo([A|R],Val):- minimo(R,A,Val).

minimo([],A,A).
minimo([A-_|R],X,Val):- A > X,!, minimo(R,X,Val).
minimo([A|R],_,Val):- minimo(R,A,Val).