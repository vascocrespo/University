int insert(FILE *alunos, char *id, char *pais, struct hashtable *paises, int hashcode);
short add(FILE *alunos, char *id, char *pais, struct hashtable *paises);
struct hashtable *load(FILE *paisFile);
void save(FILE *paisFile, struct hashtable *paises);
short remover(FILE *alunos, char *id, struct hashtable *paises);
short terminou(FILE *alunos, char *id, struct hashtable *paises);
short abandonou(FILE *alunos, char *id, struct hashtable *paises);