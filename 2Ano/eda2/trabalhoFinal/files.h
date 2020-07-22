FILE *openfile(char nome[]);
int readfileAluno(FILE *file, int x, struct aluno *a);
void writefileAluno(FILE *file, int x, struct aluno *a);
void readfilePais(FILE *file, int x, struct pais *a);
void writefilePais(FILE *file, int x, struct pais *a);