#include <stdlib.h>
#include <stdbool.h>
#include "linkedlist.h"



struct list *list_constuct()
{
	struct list *name = malloc(sizeof(struct list));
	name->proximo = NULL;
	name->empty = true;
	return name;
	
}

struct list *adicionar(struct list *root, int new)
{

	struct list *novo = list_constuct();

	novo->num = new;
	novo->empty = false;
	novo->proximo = root;
	return novo;

}

