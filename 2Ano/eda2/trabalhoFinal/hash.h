#include <stdbool.h>

#define MAXPAIS 3
#define MAXALUNO 7
#define MAXHASH 947//fator carga 70%
#define ALUNOS 19999999//fator carga 50%
#define POW 2

struct aluno
{
    char id[MAXALUNO];
    short verifica;//utilizamos um short em vez de dois booleanos por questoes de facilidade de distincao do estado do aluno
    char pais[MAXPAIS];
};


struct pais
{
    int ativos;
    int completaram;
    int abandonaram;
    char id[MAXPAIS];
};

struct hashtable
{
	struct pais *htable[MAXHASH];
};

struct pais *new_pais(char *id);
struct aluno *new_aluno();
struct hashtable *new_hashtable();
void hash_destroy(struct hashtable *hashtable);
int hashCode(char *id);
int hashCode2(char *id);
bool hash_insert(struct hashtable *hashtable, char *id);
bool hash_insert_from_file(struct hashtable *hashtable, struct pais *pais);
struct pais *hash_find(struct hashtable *hashtable, char *id);