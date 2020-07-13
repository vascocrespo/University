create table pessoa(
id_condutor varchar(4) primary key,
nome varchar(25),
endereco varchar(30)
);

create table carro(
niv varchar(17) primary key,
modelo varchar(25),
ano integer check(ano > 0)
);

create table acidente(
numero_relatorio integer check (numero_relatorio > 0) primary key,
data varchar(10),
local varchar(25)
);

create table tem(
id_condutor varchar(4),
niv varchar(17),
primary key (id_condutor,niv),
foreign key (id_condutor) references pessoa on delete restrict,
foreign key (niv) references carro on delete restrict
);

create table participacao(
numero_relatorio integer check(numero_relatorio >0),
niv varchar(17),
id_condutor varchar(4),
valor_danos integer check(valor_danos > 0),
primary key (numero_relatorio, niv, id_condutor),
foreign key (numero_relatorio) references acidente on delete restrict,
foreign key (niv) references carro on delete restrict,
foreign key (id_condutor) references pessoa on delete restrict
);

--view que ilustra uma querie que identifica o nome e o modelo do carro das pessoas que pagaram mais do que 100€ de valor de danos num unico acidente
create view public.v
as 
select nome, modelo
from pessoa Natural join carro Natural join participacao
where valor_danos > 100;
