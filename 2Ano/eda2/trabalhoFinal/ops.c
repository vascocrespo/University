#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>//para utilizar a funcao pow
#include <stdbool.h>
#include "hash.h"
#include "files.h"
#include "ops.h"

//funcao para carregar a hashtable dos paises para a memoria central
struct hashtable *load(FILE *paisFile)
{
    struct pais *paisTemp = malloc(sizeof(struct pais));
    struct hashtable *paises = new_hashtable();
    
    while(fread(paisTemp,sizeof(struct pais),1,paisFile)==1)
    {
        struct pais *paisTemp2 = new_pais(paisTemp->id);
        paisTemp2->abandonaram = paisTemp->abandonaram;
        paisTemp2->ativos = paisTemp->ativos;
        paisTemp2->completaram = paisTemp->completaram;
        hash_insert_from_file(paises,paisTemp2);
    }
    return paises;
}

//funcao para guardar a hashtable apos as alteracoes(no fim da execucao)
void save(FILE *paisFile, struct hashtable *paises)
{
    struct pais *paisTemp = malloc(sizeof(struct pais));

    for(int i=0; i<MAXHASH; i++)
    {
        if(paises->htable[i]!=NULL)
        {
            strcpy(paisTemp->id, paises->htable[i]->id);
            paisTemp->abandonaram = paises->htable[i]->abandonaram;
            paisTemp->ativos = paises->htable[i]->ativos;
            paisTemp->completaram = paises->htable[i]->completaram;
            fwrite(paisTemp,sizeof(struct pais),1,paisFile);
        }
    }
    free(paisTemp);
}

//funcao auxiliar para inserir aluno na hashtable em memoria secundaria
int insert(FILE *alunos, char *id, char *pais, struct hashtable *paises, int hashcode)
{
    struct aluno *alunoNovo = new_aluno();

    strcpy(alunoNovo->id,id);
    alunoNovo->verifica = 1;
    strcpy(alunoNovo->pais,pais);

    fseek(alunos, hashcode*sizeof(struct aluno),SEEK_SET);
    fwrite(alunoNovo,sizeof(struct aluno), 1, alunos);
    
    struct pais *paisNovo = hash_find(paises, pais);
    
    if(paisNovo == NULL)
    {
        paisNovo = new_pais(pais);
        hash_insert(paises, pais);   
    }

    else
        paisNovo->ativos++;

    
    free(alunoNovo);
            
    return 1;
}

//inserir aluno na hastable de alunos na memoria secundaria
short add(FILE *alunos, char *id, char *pais, struct hashtable *paises)
{

    struct aluno *alunoTemp = new_aluno();

    int hashcode = hashCode2(id);
    int quad=1;
    int quadHash=hashcode;
    bool changable = true;
    int guardar;
    short read = readfileAluno(alunos,hashcode,alunoTemp);
    
    if(read==0)//nao foi lido nada
    {
        insert(alunos,id,pais,paises,hashcode);
        free(alunoTemp);
        return 1;
    }

    else//foi lido alguma coisa
    {
        while(read != 0 && alunoTemp->verifica!=0)//tratamento de colisoes
        {
            
            if(alunoTemp->verifica == 4 && changable == true)
            {
                guardar = quadHash;
                changable = false;
            }

            if(strcmp(alunoTemp->id,id) == 0 && alunoTemp->verifica != 4)
                return 0;

            quadHash=hashcode+pow(quad,POW);//quadratico
            quadHash = quadHash%ALUNOS;
            read = readfileAluno(alunos,quadHash,alunoTemp);
            quad++;
        }

        if(changable)
            insert(alunos,id,pais,paises,quadHash);

        else
            insert(alunos,id,pais,paises,guardar);
        
        free(alunoTemp);
        return 1;
    }

    free(alunoTemp);
    return -1;

}


//funcao para remover um aluno da hashtable na memoria secundaria
short remover(FILE *alunos, char *id, struct hashtable *paises)
{
    
    struct aluno *alunoTemp = new_aluno();

    int hashcode = hashCode2(id);
    int quad=1;
    int quadHash=hashcode;
    
    short read = readfileAluno(alunos,hashcode,alunoTemp);

    if(read==0)//nao foi lido nada
    {
        free(alunoTemp);
        return 0;
    }
        
    else//foi lido alguma coisa
    {
        while(alunoTemp->verifica !=0 && (strcmp(alunoTemp->id, id) != 0))
        {  
            if(read == 0)
                break;

            quadHash=hashcode+pow(quad,POW);
            quadHash = quadHash%ALUNOS;
            read = readfileAluno(alunos,quadHash,alunoTemp);
            quad++;
        }
    
    
        if(alunoTemp->verifica == 4 || alunoTemp->verifica==0)
        {
            free(alunoTemp);
            return 0;
        }

        else if(alunoTemp->verifica == 2)
        {
            free(alunoTemp);
            return 2;
        }
        else if(alunoTemp->verifica == 3)
        {
            free(alunoTemp);
            return 3;
        }

        else if(alunoTemp->verifica == 1)
        {
            alunoTemp->verifica = 4;
            fseek(alunos, -sizeof(struct aluno), SEEK_CUR);
            fwrite(alunoTemp,sizeof(struct aluno), 1, alunos);
            
            struct pais *paisNovo = hash_find(paises, alunoTemp->pais);
            
            paisNovo->ativos--;
        }

        free(alunoTemp);
        return 1;
        
    }
    free(alunoTemp);
    return -1;
}

//assinalar que um aluno terminou o curso
short terminou(FILE *alunos, char *id, struct hashtable *paises)
{
    struct aluno *alunoTemp = new_aluno();

    int hashcode = hashCode2(id);
    int quad=1;
    int quadHash=hashcode;
    
    short read = readfileAluno(alunos,hashcode,alunoTemp);

    if(read==0)
    {
        free(alunoTemp);
        return 0;
    }
    
    else
    {
        while(alunoTemp->verifica !=0 && strcmp(alunoTemp->id, id) != 0)
        {  
            
            if(read == 0)
                break;
            

            quadHash=hashcode+pow(quad,POW);
            quadHash = quadHash%ALUNOS;
            read = readfileAluno(alunos,quadHash,alunoTemp);
            quad++;
            
        }
        

        if(alunoTemp->verifica == 0 || alunoTemp->verifica == 4)
        {
            free(alunoTemp);
            return 0;
        }
            
        else if(alunoTemp->verifica == 3)
        {
            free(alunoTemp);
            return 2;
        }
        
        else if(alunoTemp->verifica == 2)
        {    
            free(alunoTemp);
            return 3;
        }

        else if(alunoTemp->verifica == 1)
        {
            alunoTemp->verifica = 3;
            fseek(alunos, -sizeof(struct aluno), SEEK_CUR);
            fwrite(alunoTemp, sizeof(struct aluno), 1, alunos);
            struct pais *paisChange = hash_find(paises, alunoTemp->pais);
            paisChange->completaram++;
            paisChange->ativos--;
            free(alunoTemp);
            return 1;
        }

    }
    
    free(alunoTemp);
    return -1;
}

//assinalar o abandono de um estudante
short abandonou(FILE *alunos, char *id, struct hashtable *paises)
{
    struct aluno *alunoTemp = new_aluno();

    int hashcode = hashCode2(id);
    int quad=1;
    int quadHash=hashcode;
    
    short read = readfileAluno(alunos,hashcode,alunoTemp);

    if(read==0)
    {
        free(alunoTemp);
        return 0;
    }
    
    else
    {
        while(alunoTemp->verifica !=0 && strcmp(alunoTemp->id, id) != 0)
        {  
            
            if(read == 0)
                break;

            quadHash=hashcode+pow(quad,POW);
            quadHash = quadHash%ALUNOS;
            read = readfileAluno(alunos,quadHash,alunoTemp);
            quad++;
            
        }

        if(alunoTemp->verifica == 0 || alunoTemp->verifica == 4)
        {
            free(alunoTemp);
            return 0;
        }
        

        else if(alunoTemp->verifica == 3)
        {
            free(alunoTemp);
            return 2;
        }
            
        
        else if(alunoTemp->verifica == 2)
        {
            free(alunoTemp);        
            return 3;
        }

        else if(alunoTemp->verifica == 1)
        {
            alunoTemp->verifica = 2;
            fseek(alunos, -sizeof(struct aluno), SEEK_CUR);
            fwrite(alunoTemp, sizeof(struct aluno), 1, alunos);
            struct pais *paisChange = hash_find(paises, alunoTemp->pais);
            paisChange->abandonaram++;
            paisChange->ativos--;
            free(alunoTemp);
            return 1;
        }
        
    }
    free(alunoTemp);
    return -1;

}

