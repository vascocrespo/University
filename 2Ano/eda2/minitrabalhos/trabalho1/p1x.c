#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool primo(unsigned int num)
{
	for(int i = 2; i <= sqrt(num); i++)
	{
		if(num % i == 0)
			return false;
	} 
	return true;
}

void fact_primo(unsigned int num, short stay)
{
	
	if(num == 0)
	{
		printf("\n");
	}

	else if(num == 1)
		printf("\n");

	else if(primo(num))
	{
		printf(" %u\n", num);
	}

	else
	{
		for(int i = stay; i <= sqrt(num); i++)
		{
			if(primo(i))
			{
				if(num % i == 0)
				{
					printf(" %d", i);
					fact_primo(num/i, i);
					break;
				}
			}
				
		}
	}

}

int main(void)
{
	short naturais;
	unsigned int numeros;
	scanf("%hd",&naturais);
	for(int u = 0; u < naturais; u++)
	{
		scanf("%u",&numeros);
		printf("%u:", numeros);
		fact_primo(numeros, 2);

	}
	
	return 0;
}