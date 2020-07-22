#include <stdio.h>
#include <stdlib.h>
#define MAXNUM 1000000

struct head
{
	struct linkedList *node;
};

struct linkedList
{
	int num;
	struct linkedList *proximo;
};

struct head *head_construct()
{
	struct head *new = malloc(sizeof(struct head));
	new->node = NULL;
	return new;
}

struct linkedList *list_construct()
{
	struct linkedList *name = malloc(sizeof(struct linkedList));
	name->num = 0;
	name->proximo = NULL;
	return name;
} 


void add(struct head *lista, int two)
{

	struct linkedList *new = list_construct();
	new->num = two;
	if(lista->node == NULL)
	{
		lista->node = new;
		return;
	}
	struct linkedList *temp = lista->node;

	while(temp->proximo != NULL)
	{
		if(temp->num == two)
			return;
		temp = temp->proximo;
	}
	if(temp->num != two)
		temp->proximo = new;



}

void remover(struct head *lista, int two)
{
	if(lista->node != NULL)
	{
		struct linkedList *temp = lista->node;
		if(temp->num == two)
		{
			
			if(temp->proximo == NULL)
			{
				
				lista->node = NULL;
			}

			else
			{

				lista->node = temp->proximo;
			}
			free(temp);
			
		}

		else
		{
			while(temp->proximo != NULL)
			{
				if(temp->proximo->num == two)
				{
					free(temp->proximo);
					if(temp->proximo->proximo == NULL)
						temp->proximo = NULL;

					else
						temp->proximo = temp->proximo->proximo;
					return;
				}

				temp = temp->proximo;
			}


		}
	}
	
}

int percorre(struct head *cabeca)
{
	int num = 0;
	if(cabeca->node == NULL)
		return num;
	struct linkedList *temp = cabeca->node;
	num++;
	while(temp->proximo != NULL)
	{
		num++;
		temp = temp->proximo;
	}
	return num;
}

int main(void)
{
	struct head *par[MAXNUM];
	for(int i = 0; i < MAXNUM;i++)
	{
		par[i] = NULL;
	}
	
	int one;
	int two;
	char operation;
	
	while(scanf("%c ", &operation) != EOF)
	{
		
		switch(operation)
		{
			case 'p':
				
				scanf("%d %d", &one, &two);
				if(par[one] == NULL)
					par[one] = head_construct();

				add(par[one], two);
				break;
			
			case 'x':
				scanf("%d %d", &one, &two);

				if(par[one] != NULL)
					remover(par[one], two);
				
				break;
			
			case 'q':
				
				scanf("%d", &one);
				if(par[one] == NULL || par[one]->node == NULL)
					printf("%d %d\n", one, 0);
				
				

				else if(par[one]->node != NULL)
				{
					int num = percorre(par[one]);
					printf("%d %d", one, num);
					struct linkedList *new = par[one]->node;
					
					while(new->proximo != NULL)
					{
						printf(" %d", new->num);
						new = new->proximo;
						
						
					}
					printf(" %d\n", new->num);
				}


					
				break;
			
			default:
				break;
		}
	}

	return 0;
}