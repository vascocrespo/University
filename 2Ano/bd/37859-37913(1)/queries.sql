--QUERIES
--Saber a contagem das pessoas inscritas na seguradora
select count(distinct nome)
from pessoa;

--Saber o modelo dos carros que nao tiveram acidentes
select distinct modelo
from carro
where niv not in( select niv 
		  from participacao);

--Saber o modelo e o seu respetivo ano dos carros inferiores a 2009
select modelo, ano
from carro
where ano <2009;

--Saber a soma do valor pago pelos acidentes na Rua do Raimundo
select sum(valor_danos)
from acidente, participacao
where acidente.numero_relatorio = participacao.numero_relatorio
and local = 'Rua do Raimundo';

--Saber o endereco de todas as pessoas que tem um carro com o ano inferior a 2009
select endereco
from pessoa Natural join carro Natural join tem
where ano < 2009;

--Saber o nome das pessoas que tiveram 1 ou mais acidentes
select distinct nome
from pessoa, participacao
where pessoa.id_condutor = participacao.id_condutor;

--Saber o nome e o carro das pessoas que excederam o valor dos danos de 100 € num unico acidente
select nome, modelo
from pessoa Natural join carro Natural join participacao
where valor_danos > 100;

--Saber o nome das pessoas que tiveram um ou mais acidentes na Praca 1º de Maio
select nome
from pessoa Natural join participacao Natural join acidente
where local = 'Praca 1º de Maio';

--Executar a view previamente criada
select *
from public.v;