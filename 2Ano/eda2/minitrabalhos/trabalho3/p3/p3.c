#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>
#include "linkedlist.h"

#define MAX 1001

int execute(struct list *root, char operation)
{
	int result;
	if(operation == '~')
	{
		result = root->num * -1;
		root->num = result;
		
		return result;
	}

	else
	{
		switch(operation)
		{
			case '+':
				result = (root->proximo->num) + (root->num);
				root->num = result;
				if(root->proximo->proximo == NULL)
					root->proximo = NULL;
			
				else
					root->proximo = root->proximo->proximo;
				
			
				return result;
				
			case '-':
				result = (root->proximo->num) - (root->num);
				root->num = result;
				if(root->proximo->proximo == NULL)
					root->proximo = NULL;
			
				else
					root->proximo = root->proximo->proximo;
				
				return result;

			case '*':
				result = (root->proximo->num) * (root->num);
				root->num = result;
				if(root->proximo->proximo == NULL)
					root->proximo = NULL;
			
				else
					root->proximo = root->proximo->proximo;
				
			
				return result;

			case '/':
				if(root->num == 0)
				{
					printf("divisao por 0\n");
					root->empty = true;
					break;
				}

				result = (root->proximo->num) / (root->num);

				root->num = result;
				if(root->proximo->proximo == NULL)
					root->proximo = NULL;
			
				else
					root->proximo = root->proximo->proximo;
				
			
				return result;

			default:
				break;

		}
	}

	return 0;
}


int main(void)
{ 
	char line[MAX] = {'\0'};
	
	int result;
	while(scanf("%s", line) != EOF)
	{

		struct list *new = list_constuct();
		for(int i = 0; line[i] != '\0'; i++)
		{
			if(isdigit(line[i]) )
			{
				result = line[i] - '0';
				new = adicionar(new, result);
			}

			else
			{
				result = execute(new, line[i]);
				if(new->empty == true)
				{
					break;
				}
			}
		}
		
		if(new->empty != true)
			printf("%d\n", result);
		free(new);
		
	}

	return 0;

}