#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAXLETTERS 26
#define MAXESTADOS 100
#define MAXAUTOMATOS 20
#define MAXPALAVRA 129

struct automato
{
	short ligacoes[MAXLETTERS][MAXESTADOS];
	short inicial;
	short estados;
	short letras;
	short finais[MAXESTADOS + 1];
};


bool verifica(struct automato one, char palavra[MAXPALAVRA])
{
	char first;
	short inicial = one.inicial;
	for(short i = 0; i < MAXPALAVRA; i++)
	{
		first = palavra[i];
		if(first == '$')
			break;

		else
		{
			inicial = one.ligacoes[((short)first) - 97][inicial];
			
		}
	}
	
	for(short o = 1; o <= one.finais[0]; o++)
	{

		if(inicial == one.finais[o])
			return true;
	}
	return false;
}


int main(void)
{
	struct automato temp;
	struct automato automatos[MAXAUTOMATOS];
	short automat, estados, simbolos, estadoInicial, estadosFinais, final, cadaSimbolo;
	scanf("%hd", &automat);

	for(short i = 0; i < automat; i++)
	{
		scanf("%hd %hd %hd", &estados, &simbolos, &estadoInicial);
		temp.estados = estados;
		temp.letras = simbolos;
		temp.inicial = estadoInicial;
		scanf("%hd", &estadosFinais);
		//temp.quantosFinais = estadosFinais;
		temp.finais[0] = estadosFinais;
		for(short o = 1; o <= estadosFinais; o++)
		{
			scanf("%hd", &final);
			temp.finais[o] = final;

		}

		for(short k = 0; k < estados; k++)
		{
			for(short j = 0; j < simbolos;j++)
			{
				scanf("%hd", &cadaSimbolo);
				temp.ligacoes[j][k] = cadaSimbolo;
			}
		}

		automatos[i] = temp;
		

		//printf("%hd\n", temp.ligacoes[0][0]);
		//printf("%hd\n", temp.ligacoes[0][1]);
		//printf("%hd\n", temp.ligacoes[1][0]);
		//printf("%hd\n", temp.ligacoes[1][1]);
		
	}



	short which;
	char palavra[MAXPALAVRA];
	while(scanf("%hd", &which) != EOF)
	{
		scanf("%s", palavra);
		printf("\"");
		for(short i = 0; i < MAXPALAVRA; i++)
		{
			if(palavra[i] != '$')
				printf("%c", palavra[i]);
			else if(palavra[i] == '$')
				break;
		}
		printf("\"");
		if(verifica(automatos[which], palavra) == 1)
		{

			printf(" aceite\n");
		}
		else
			printf(" rejeitada\n");
	}


	return 0;
}