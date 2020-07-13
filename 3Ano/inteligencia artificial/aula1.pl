homem('Afonso Henriques','rei de Portugal',1109).
homem('Henrique de Borgonha','conde de Portugal',1069).

homem('Sancho I','rei de Portugal',1154).
homem('Fernando II','rei de Leão',1137).
homem('Afonso IX', 'rei de Leão e Castela', 1171).
homem('Afonso II', 'rei de Portugal',1185).

homem('Sancho II', 'rei de Portugal',1207).
homem('Afonso III', 'rei de Portugal',1210).


mulher('Teresa de Castela', 'condessa de Portugal', 1080).
mulher('Mafalda', 'condessa de Saboia', 1125).
mulher('Urraca', 'infanta de Portugal',1151).
mulher('Dulce de Barcelona','infanta de Aragão',1160).
mulher('Berengária', 'infanta de Portugal',1194).
mulher('Urraca C','infanta de Castela',1186).


filho('Afonso Henriques','Henrique de Borgonha').
filho('Afonso Henriques','Teresa de Castela').
filho('Urraca','Afonso Henriques').
filho('Sancho I','Afonso Henriques').
filho('Urraca','Mafalda').
filho('Sancho I','Mafalda').
filho('Afonso IX','Urraca').
filho('Afonso IX','Fernando II').
filho('Afonso II','Sancho I').
filho('Afonso II','Dulce de Barcelona').
filho('Berengária','Sancho I').
filho('Berengária','Dulce de Barcelona').
filho('Sancho II','Afonso II').
filho('Afonso III','Afonso II').
filho('Sancho II','Urraca C').
filho('Afonso III','Urraca C').

homem(A, B, C).
mulher(A, B, C).
filho(N, P).

irmao(N1, N2) :-filho(N1, B), filho(N2, B), N1 \= N2.

primoDireito(N1, N2) :-
	filho(N1, X),
	filho(N2,Y),
	irmao(Y, X).


irmaos(N1, Xs) :-
	findall(X, irmao2(N1,X), Xs).

primo(N1,X):-
	primoDireito(N1,X).

primo(N1, X) :-
	primoDireito(N1, B),
	filho(X,B).

primo(N1, X) :-
	filho(N1, B),
	primoDireito(B, X).


primos(N1, Xs) :-
	setof(X, primo(N1, X), Xs).

esposa(M,H) :-
	mulher(M,_,_),
	homem(H,_,_),
	filho(X,H),
	filho(X,M).

ascendente(N1,X) :-
	filho(N1, X).
ascendente(N1,X) :-
	filho(N1, Y),
	filho(Y,X).

descende(N1, X) :- setof(C, ascendentes(N1, C),X).


descendentes(N1, X) :- setof(C, ascendentes(C, N1), X).

pai(X,Y) :- filho(X,Y), homem(Y,_,_).

mae(X,Y) :- filho(X,Y), mulher(Y,_,_).

ascendentes(X, c(X,AP,AM)) :-
	pai(X,P),
	ascendentes(P,AP),
	mae(X,M),
	ascendentes(M,AM).

ascendentes(X,c(X,0,0)) :- homem(X,_,_), \+ filho(X,_).
ascendentes(X,c(X,0,0)) :- mulher(X,_,_), \+ filho(X,_).



