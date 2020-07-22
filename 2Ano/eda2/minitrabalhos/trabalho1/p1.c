#include <stdio.h>
#include <stdbool.h>

bool primo(int num)
{
	for(int i = 2; i <= (num/2); i++)
	{
		if(num % i == 0)
			return false;
	} 
	return true;
}

int fact_primo(int num)
{
	
	int counter = 0;
	if(num == 0)
		return 0;

	if(num == 1)
		return 0;

	else if(primo(num))
	{
		counter +=1;
		return counter;
	}

	else
	{
		for(int i = 2; i <= (num/2); i++)
		{
			if(primo(i))
			{
				if(num % i == 0)
				{
					counter+=1;
					return (counter + (fact_primo((num/i))));
				}
			}
				
		}
	}

	return counter;
}

int main(void)
{
	short naturais;
	int numeros;
	scanf("%hd",&naturais);
	for(int u = 0; u < naturais; u++)
	{
		scanf("%d",&numeros);
		printf("%d: %d\n", numeros, fact_primo(numeros));

	}
	
	return 0;
}