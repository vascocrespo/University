#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>
#include <string.h>
#include "hash.h"

//tratamento de colisoes e linear dado ao tamanho reduzido da hashtable
//construtores
struct hashtable *new_hashtable()
{
	struct hashtable *sistema=malloc(sizeof(struct hashtable));
	if(sistema==NULL)
		return NULL;

	for(int i=0; i<MAXHASH; i++)
		sistema->htable[i]=NULL;

	return sistema;

}


struct pais *new_pais(char *id)
{
	struct pais *pais=malloc(sizeof(struct pais));
	strcpy(pais->id, id);
	pais->ativos=1;
	pais->completaram=0;
	pais->abandonaram=0;

	return pais;
}

struct aluno *new_aluno()
{
	struct aluno *alunoNovo = malloc(sizeof(struct aluno));
	alunoNovo->verifica = 0;
	return alunoNovo;
}

void hash_destroy(struct hashtable *hashtable)
{
	for(int i=0; i<MAXHASH; i++)
		free(hashtable->htable[i]);
	free(hashtable);
}

//hashcode djb2
int hashCode(char *nome)
{
	unsigned long hash = 5381;
	int c;
	while ((c = *nome++))
		hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
		
	return hash % MAXHASH;
}

int hashCode2(char *nome)
{
	unsigned long hash = 5381;
	int c;
	while ((c = *nome++))
		hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
		
	return hash % ALUNOS;
}

//hash insert memoria central
bool hash_insert(struct hashtable *hashtable, char *nome)
{
	int hashIndex = hashCode(nome);
	
	struct pais *pais = new_pais(nome);
	
	while(hashtable->htable[hashIndex] != NULL && strcmp(hashtable->htable[hashIndex]->id,nome) != 0)
	{
		hashIndex++;
		hashIndex = hashIndex % MAXHASH;
	}
	
	hashtable->htable[hashIndex] = pais;
	return true;
}

//hash insert da memoria secundaria para a memoria central
bool hash_insert_from_file(struct hashtable *hashtable, struct pais *pais)
{

	int hashIndex = hashCode(pais->id);
	
	while(hashtable->htable[hashIndex] != NULL && strcmp(hashtable->htable[hashIndex]->id,pais->id) != 0)
	{
		hashIndex++;
		hashIndex = hashIndex % MAXHASH;
	}

	hashtable->htable[hashIndex] = pais;
	return true;
}

//find na memoria central
struct pais *hash_find(struct hashtable *hashtable, char *nome)
{
	int hashIndex = hashCode(nome);

	
	while(hashtable->htable[hashIndex] != NULL)
	{
		if(strcmp(hashtable->htable[hashIndex]->id,nome) == 0)
		{
			return hashtable->htable[hashIndex];
		}
		
		hashIndex++;
		hashIndex = hashIndex % MAXHASH;
	}
	
	return NULL;
}