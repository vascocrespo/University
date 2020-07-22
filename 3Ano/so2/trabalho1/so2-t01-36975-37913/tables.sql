Drop Table utilizador CASCADE;

create table utilizador(
	Email VARCHAR(128),
	Id SERIAL UNIQUE,
	PRIMARY KEY (Id)
);

Drop Table produto CASCADE;

create table produto(
	NomeProduto VARCHAR(128),
	PRIMARY KEY(NomeProduto)
);

Drop Table loja CASCADE;

create table loja(
	NomeLoja VARCHAR(128),
	PRIMARY KEY (NomeLoja)
);

Drop Table LojaProduto CASCADE;

create table LojaProduto(
	Nome_Loja VARCHAR (128) REFERENCES loja(NomeLoja),
	Nome_Produto VARCHAR(128) REFERENCES produto(NomeProduto),
	PRIMARY KEY (Nome_Loja,Nome_Produto)
);

Drop Table necessidades CASCADE;

create table necessidades(
	Id_utilizador integer REFERENCES utilizador(Id),
	Nome_Produto VARCHAR(128) REFERENCES produto(NomeProduto),
	PRIMARY KEY (Id_utilizador,Nome_Produto)
);

Drop Table respostas CASCADE;

create table respostas(
	Nome_Produto VARCHAR(128) REFERENCES produto(NomeProduto),
	Nome_Loja VARCHAR (128) REFERENCES loja(NomeLoja),
	PRIMARY KEY(Nome_Loja,Nome_Produto)
);