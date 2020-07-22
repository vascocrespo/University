#include <stdio.h>
#include "hash.h"
#include "files.h"
#define PAISES 947

//funcao para abrir um ficheiro
FILE *openfile(char *nome)
{
	
	FILE *file=fopen(nome,"rb+");
	
	if(file==NULL)
		file=fopen(nome,"wb+");

	return file;
}

//funcao para ler um aluno na posicao x, retorna o resultado de fread para saber se a leitura foi um sucesso
int readfileAluno(FILE *file, int x, struct aluno *a)
{
    fseek(file, x*sizeof(struct aluno), SEEK_SET);
    return fread(a, sizeof(struct aluno), 1, file);
}

//funcao para escrever um aluno na posicao x
void writefileAluno(FILE *file, int x, struct aluno *a)
{
	fseek(file , x*sizeof(struct aluno) , SEEK_SET);
	fwrite(a , sizeof(struct aluno) , 1 , file);
}

//funcao para ler um pais na posicao x
void readfilePais(FILE *file, int x, struct pais *a)
{
    fseek(file, x*sizeof(struct pais), SEEK_SET);
    fread(a, sizeof(struct pais), 1, file);
}

//funcao para escrever um pais na posicao x
void writefilePais(FILE *file, int x, struct pais *a)
{
	fseek(file , x*sizeof(struct pais) , SEEK_SET);
	fwrite(a , sizeof(struct pais) , 1 , file);
}

