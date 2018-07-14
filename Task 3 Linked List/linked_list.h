#ifndef LINKED_LIST_H
#define LINKED_LIST_H

struct List_node {
	struct List_node *next;
	void *data;
};

struct Person {
	int age;
	char* name;
};

/**
 * list_node - ptr to struct List_node
 * data_struct - ptr to Person
 * data_struct_name - for example "struct Person"
 */

#define CREATE_LIST_NODE(list_node, data_struct, data_struct_name) \
	list_node->next = NULL; \
	list_node->data = malloc(sizeof(data_struct_name)); \
	if(NULL == list_node->data) { \
		printf("ERROR: can`t allocate memory for data in \
		macro CREATE_LIST_NODE()!\n"); \
	} \
	*((data_struct_name *)(list_node->data)) = *(data_struct);
	

int add_head_to_list(struct List_node *old_head, struct List_node *new_head);
	
int add_tail_to_list(struct List_node *head, struct List_node *new_tail);

void print_struct_Person(void *struct_to_print);

void traverse_list(struct List_node *list_head, void (*print_struct)(void*) );

void free_person(void *struct_to_free);

int clear_list(struct List_node *list_head, void(*struct_free_func)(void *) );


#endif















