struct list
{
	int num;
	bool empty;
	struct list *proximo;
};

struct list *list_constuct();
struct list *adicionar(struct list *root, int new);