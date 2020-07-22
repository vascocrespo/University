#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hash.h"
#include "files.h"
#include "ops.h"

#define IDALUNO 7//tamanho das strings
#define IDPAIS 3

int main(void)
{
    
    FILE *alunos = openfile("alunos.bin");
    FILE *paises = openfile("paises.bin");
    
    struct hashtable *hashPaises = load(paises);

    char input;
    char idNovo[IDALUNO];
    char paisNovo[IDPAIS];
    //scanf para procurar a instrucao
    while(scanf("%c ", &input))
    {
        switch(input)
        {
            case 'I'://INSERIR UM ESTUDANTE
                scanf("%s", idNovo);
                scanf("%s", paisNovo);
                
                short check=add(alunos, idNovo, paisNovo, hashPaises);
                if(check==0)
                    printf("+ estudante %s existe\n", idNovo);
                else if(check==-1)
                    printf("algo correu mal\n");
                
                break;

            case 'R'://REMOVER UM IDENTIFICADOR
                scanf("%s", idNovo);
                
                short ver = remover(alunos, idNovo, hashPaises);
                if(ver == 0)
                    printf("+ estudante %s inexistente\n", idNovo);
                    
                else if (ver == 2)
                    printf("+ estudante %s abandonou\n", idNovo);
                
                else if (ver == 3)
                    printf("+ estudante %s terminou\n", idNovo);

                break;

            case 'T'://ASSINALAR O TERMINO
                scanf("%s", idNovo);

                short check2 = terminou(alunos, idNovo, hashPaises);
                if(check2 == 0)
                    printf("+ estudante %s inexistente\n", idNovo);
                
                else if(check2 == 2)
                    printf("+ estudante %s terminou\n", idNovo);

                else if(check2 ==3)
                    printf("+ estudante %s abandonou\n", idNovo);
               
                break;

            case 'A'://ASSINALAR ABANDONO
                scanf("%s", idNovo);

                short check3 = abandonou(alunos, idNovo, hashPaises);
                if(check3 == 0)
                    printf("+ estudante %s inexistente\n", idNovo);
                
                else if(check3 == 2)
                    printf("+ estudante %s terminou\n", idNovo);

                else if(check3 ==3)
                    printf("+ estudante %s abandonou\n", idNovo);

                break;

            case 'P'://OBTER DADOS DE UM PAIS
                scanf("%s", paisNovo);
                
                struct pais *paisMudar=hash_find(hashPaises, paisNovo);

                if(paisMudar!=NULL)
                {
                    int total=(paisMudar->ativos)+(paisMudar->completaram)+(paisMudar->abandonaram);
                    if(total == 0)
                        printf("+ sem dados sobre %s\n", paisNovo);
                    
                    else
                        printf("+ %s - correntes: %d, diplomados: %d, abandonaram: %d, total: %d\n", paisMudar->id, paisMudar->ativos, paisMudar->completaram, paisMudar->abandonaram, total);
                }
                else
                    printf("+ sem dados sobre %s\n", paisNovo);

                break;

            case 'X'://ACABAR A EXECUÇÃO
                
                save(paises, hashPaises);

                fclose(paises);
                fclose(alunos);

                exit(0);

            default:
                break;
        }
    }

    return 0;

}