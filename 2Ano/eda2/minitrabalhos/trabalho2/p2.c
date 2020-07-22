#include <stdio.h>
#define SEQ 1000


void verificar(int array[], int num, int check)
{
	int inicio = 0;
	int fim = 0;
	int difference = SEQ + 1;
	for(int i = 0; i < num; i++)
	{
		int value = array[i];
		if(value == check)
			{
				inicio = i;
				fim = i;
				difference = 0;
				break;
			}
		else
		{
			for(int o = i + 1; o < num; o++)
			{

				value = value + array[o];

				if(value == check && (o - inicio < difference))
				{
					inicio = i;
					fim = o;
					difference = fim - inicio;
					break;
				}
			}	
		}
		
	}

	if(difference == SEQ + 1)
		printf("nenhuma subsequencia soma %d\n", check);

	else if(difference == 0)
		printf("s[%d] = %d\n", inicio + 1, check);

	else if(difference == 1)
		printf("s[%d] + s[%d] = %d\n", inicio + 1, fim + 1, check);

	else
		printf("s[%d] + ... + s[%d] = %d\n", inicio + 1, fim + 1,check);
		
}

int main(void)
{
	int num;
	int possiveis;
	int check;
	scanf("%d", &num);
	int array[num];

	for(int i = 0;i < num; i++)
	{
		scanf("%d", &possiveis);
		array[i] = possiveis;
	}

	scanf("%d", &check);

	verificar(array, num, check);
}