#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define MAX 1001

struct stack
{
	int top;
	int array[MAX];
};

struct stack *stack_constuct()
{
	struct stack *name = malloc(sizeof(struct stack));
	name->top = -1;
	return name;
	
}

int pop(struct stack *list)
{
	if(list->top != -1)
	{
		int result = list->array[list->top];
		list->top = list->top - 1;
		return result;
	}
	return -1;
}

void push(struct stack *list, int num)
{
	if((list->top + 1) < MAX)
	{
		list->top = list->top + 1;
		list->array[list->top] = num;
	}
	
}

void execute(struct stack *list, char operation)
{
	int num1;
	int num2;

	if(operation == '~')
	{
		num1 = pop(list);
		push(list, (num1 * -1));
	}

	else
	{
		num1 = pop(list);
		num2 = pop(list);
		switch(operation)
		{
			case '+':
				
				push(list, (num2 + num1));
				break;
			
			case '-':
				push(list, (num2 - num1));
				break;

			case '*':
				push(list, (num2 * num1));
				break;

			case '/':
				if(num1 == 0)
				{
					printf("divisao por 0\n");
					list->top = -1;
					break;
				}
				push(list, (num2 / num1));
				break;

			default:
				break;

		}
	}

		
}

int main(void)
{
	
	char line[MAX] = {'\0'};
	int result;
	while(scanf("%s", line) != EOF)
	{
		struct stack *new = stack_constuct();
		for(int i = 0; line[i] != '\0'; i++)
		{
			if(isdigit(line[i]) )
			{
				result = line[i] - '0';
				push(new, result);
			}

			else
			{
				execute(new, line[i]);
				if(new->top == -1)
				{
					break;
				}
			}
		}
		
		if(new->top != -1)
			printf("%d\n", pop(new));
		free(new);
	}

	return 0;

}
