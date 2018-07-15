#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include <stdbool.h>

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

void remove_list_head(struct List_node *head, void(*struct_free_func)(void *));
	
void remove_list_tail(struct List_node *head, void(*struct_free_func)(void *));

void print_struct_Person(void *struct_to_print);

void traverse_list(struct List_node *list_head, void (*print_struct)(void*) );

int count_list_nodes(struct List_node *list_head);

void free_person(void *struct_to_free);

int clear_list(struct List_node *list_head, void(*struct_free_func)(void *) );

bool find_equality_func_Person(void *data_person, void *values_to_find);

struct List_node * find_list_node(struct List_node *head, void *values_to_find,
	bool(*struct_find_equality_func)(void *, void *) );

void insert_node_to_preset_position
	(struct List_node *prev_node, struct List_node *node_to_insert);
	
void delete_preset_node(struct List_node *prev_node, void(*struct_free_func)(void *));

struct List_node * reverse_list(struct List_node *head);

void bubble_sort_list(struct List_node *head, bool(*compare_func)(void *, void *) );

bool compare_Person_ascending(void *first, void *second);//true = need swap

bool compare_Person_descending(void *first, void *second);//true = need swap

void swap_data(struct List_node *first, struct List_node *second);


#endif















