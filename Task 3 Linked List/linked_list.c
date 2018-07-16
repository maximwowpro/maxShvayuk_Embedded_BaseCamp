/*
 * Writed by Max Shvayuk.
 * 13.07.2018
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <malloc.h>
#include "linked_list.h"


int add_head_to_list(struct List_node *old_head, struct List_node *new_head) {
	if(NULL == old_head) {
		printf("\nERROR: add_head_to_list() : old_head == NULL\n");
		return -1;
	}
	if(NULL == new_head) {
		printf("\nERROR: add_head_to_list() : new_head == NULL\n");
		return -1;
	}	
	struct List_node *tmp = malloc(sizeof(*old_head));
	if(NULL == tmp) {
		printf("ERROR: can`t allocate memory for "
		"struct List_node *tmp  in function add_head_to_list()!\n");
		return -2;
	}
	tmp->next = old_head->next;
	tmp->data = old_head->data;
	old_head->data = new_head->data;
	old_head->next = new_head;
	new_head->data = tmp->data;
	new_head->next = tmp->next;
	free(tmp);
	return 0;
}

int add_tail_to_list(struct List_node *head, struct List_node *new_tail) {
	if(NULL == head) {
		printf("\nERROR: add_tail_to_list() : head == NULL\n");
		return -1;
	}
	if(NULL == new_tail) {
		printf("\nERROR: add_tail_to_list() : new_tail == NULL\n");
		return -1;
	}	
	struct List_node *ptr;
	ptr = head;

	while(NULL != ptr->next)
		ptr = ptr->next;

	ptr->next = new_tail;
	return 0;
}

int remove_list_head(struct List_node *head, int(*struct_free_func)(void *)) {
	if(NULL == head) {
		printf("\nERROR: remove_list_head() : head == NULL\n");
		return -1;
	}
	if(NULL == struct_free_func) {
		printf("\nERROR: remove_list_head() : "
		"struct_free_func == NULL\n");
		return -1;
	}	
	struct List_node *second_node = head->next;
	
	struct_free_func(head->data);
	head->data = second_node->data;
	head->next = second_node->next;
	free(second_node);
	return 0;
}
	
int remove_list_tail(struct List_node *head, int(*struct_free_func)(void *)) {
	if(NULL == head) {
		printf("\nERROR: remove_list_tail() : head == NULL\n");
		return -1;
	}
	if(NULL == struct_free_func) {
		printf("\nERROR: remove_list_tail() : "
		"struct_free_func == NULL\n");
		return -1;
	}
	struct List_node *ptr = head;
	while(NULL != ptr->next->next) {
		ptr = ptr->next;
	}
	struct_free_func(ptr->next->data);
	free(ptr->next);
	ptr->next = NULL;
	return 0;
}

int free_person(void *struct_to_free) {
	if(NULL == struct_to_free) {
		printf("\nERROR: free_person() : struct_to_free == NULL\n");
		return -1;
	}	
	((struct Person *)struct_to_free)->name = "";
	((struct Person *)struct_to_free)->age = 0;
	return 0;
}

int traverse_list(struct List_node *list_head, void (*print_struct)(void*) ) {
	if(NULL == list_head) {
		printf("\nERROR: traverse_list() : head == NULL\n");
		return -1;
	}
	if(NULL == print_struct) {
		printf("\nERROR: traverse_list() : "
		"print_struct == NULL\n");
		return -1;
	}
	struct List_node *ptr = list_head;
	int counter = 0;
	printf("\nTraversing list:\n");
	while(NULL != ptr)
	{
		printf("linked list node №%i: \n", counter);
		print_struct(ptr->data);
		printf("\n");
		ptr = ptr->next;
		counter++;
	}
	return 0;
}

void print_struct_Person(void *struct_to_print) {
	if(NULL == struct_to_print) {
		printf("\nERROR: print_struct_Person() : "
		"struct_to_print == NULL\n");
		return;
	}
	
	printf("struct Person:\nname=%s, age=%i\n",
	((struct Person *)(struct_to_print))->name,
	((struct Person *)(struct_to_print))->age);
	return;
}


int count_list_nodes(struct List_node *list_head) {
	if(NULL == list_head) {
		printf("\nERROR: count_list_nodes() : list_head == NULL\n");
		return -1;
	}
	
	struct List_node *ptr = list_head;
	int counter = 0;
	while(NULL != ptr) {
		ptr = ptr->next;
		counter++;
	}
	
	return counter;
}

int clear_list(struct List_node **list_head, int(*struct_free_func)(void *) ) {
	if(NULL == list_head) {
		printf("\nERROR: clear_list() : list_head == NULL\n");
		return -1;
	}
	if(NULL == struct_free_func) {
		printf("\nERROR: clear_list() : struct_free_func == NULL\n");
		return -1;
	}	
	struct List_node *ptr = *list_head;
	struct List_node *tmp_ptr = ptr;
	printf("\nCleaning list\n");
	while(NULL != ptr)
	{	
		struct_free_func(ptr->data);
		free(ptr->data);
		ptr = ptr->next;
		free(tmp_ptr);
		tmp_ptr = ptr;
	}
	*list_head = NULL;
	return 0;
}

struct List_node * find_list_node(struct List_node *head, void *values_to_find, 
        bool(*struct_find_equality_func)(void *, void *) ) {
	if(NULL == head) {
		printf("\nERROR: find_list_node() : head == NULL\n");
		return NULL;
	}
	/*
	 * If required node with values_to_find is the head of linked list, 
	 * creates new empty node.
	 * empty node->next == head.
	 */
	struct List_node *ptr = head;
	if( true == struct_find_equality_func(ptr->data, values_to_find) ) {
		struct List_node *empty_node = malloc(sizeof(struct List_node));
		empty_node->next = ptr;
		return empty_node;
	}
	
	while(NULL != ptr) {
		if(NULL != ptr->next) {
			if( true == 
			struct_find_equality_func
			(ptr->next->data, values_to_find) )
				return ptr;
		}
		ptr = ptr->next;
	}
	
	printf("\nCan`t find such node at the list\n");
	return NULL;

}

bool find_equality_func_Person(void *data_person, void *values_to_find) {
	if(NULL == data_person) {
	printf("\nERROR: find_equality_func_Person() : data_person == NULL\n");
	return false;
	}
	if(NULL == values_to_find) {
	printf("\nERROR: find_equality_func_Person() : "
		  "values_to_find == NULL\n");
	return false;
	}
	
	int age_to_find = ((struct Person *)values_to_find)->age;
	char *name_to_find = ((struct Person *)values_to_find)->name;
	
	if(((struct Person *)data_person)->age == age_to_find &&
	  ((struct Person *)data_person)->name == name_to_find )
		return true;
	
	return false;
}

int insert_node_to_preset_position
    (struct List_node *prev_node, struct List_node *node_to_insert) {
	if(NULL == prev_node) {
	printf("\nERROR: insert_node_to_preset_position():prev_node ==NULL\n");
	return -1;
	}
	if(NULL == node_to_insert) {
	printf("\nERROR: insert_node_to_preset_position() : "
		  "node_to_insert == NULL\n");
	return -1;
	}
	
	node_to_insert->next = prev_node->next;
	prev_node->next = node_to_insert;
	return 0;
}


int delete_preset_node(struct List_node *prev_node, 
			int(*struct_free_func)(void *)) {
	if(NULL == prev_node) {
	printf("\nERROR: delete_preset_node() : prev_node == NULL\n");
	return -1;
	}
	if(NULL == struct_free_func) {
	printf("\nERROR: delete_preset_node() : "
		  "struct_free_func == NULL\n");
	return -1;
	}
	
	struct List_node *delete_node = prev_node->next;
	prev_node->next = delete_node->next;
	
	struct_free_func(delete_node->data);
	free(delete_node);
	return 0;
}


struct List_node * reverse_list(struct List_node *head) {
	if(NULL == head) {
	printf("\nERROR: reverse_list() : head == NULL\n");
	return NULL;
	}
	struct List_node *prev = NULL;
	struct List_node *curr = head;
	struct List_node *next = NULL;
	
	while(NULL != curr) {
		next = curr->next;
		curr->next = prev;
		
		prev = curr;
		curr = next;
	}
	/*
	 * Now prev contains that value, which should be in head.
	 * So, we return pointer to prev`s value
	 */
	return prev;
}

int bubble_sort_list(struct List_node *head, bool(*compare_func)(void *, void *) ) {
	if(NULL == head) {
	printf("\nERROR: bubble_sort_list() : head == NULL\n");
	return -1;
	}
	if(NULL == compare_func) {
	printf("\nERROR: bubble_sort_list() : compare_func == NULL\n");
	return -1;
	}
	struct List_node *ptr = head;
	struct List_node *it;
	
	while(NULL != ptr) {
		it = head;
		while(NULL != it->next) {
			if( true == compare_func(it->data, it->next->data) )
				swap_data(it, it->next);
			it = it->next;
		}
		ptr = ptr->next;
	}
	return 0;
}

bool compare_Person_ascending(void *first, void *second) {//true = need swap
	if(first == NULL) 
		printf("\nERROR: first in compare_Person_ascending() is NULL\n");
	if(second == NULL) 
		printf("\nERROR: second in compare_Person_ascending() is NULL\n");
		
	return ( ((struct Person *)first)->age > ((struct Person *)second)->age );
}


bool compare_Person_descending(void *first, void *second) {//true = need swap
	if(first == NULL) 
		printf("\nERROR: first in compare_Person_descending() is NULL\n");
	if(second == NULL) 
		printf("\nERROR: second in compare_Person_descending() is NULL\n");
		
	return ( ((struct Person *)first)->age < ((struct Person *)second)->age );
}

void swap_data(struct List_node *first, struct List_node *second) {
	if(first == NULL) 
		printf("\nERROR: first in swap_data() is NULL\n");
	if(second == NULL) 
		printf("\nERROR: second in swap_data() is NULL\n");
		
	void *tmp = first->data;
	first->data = second->data;
	second->data = tmp;
	return;
}


struct List_node * extend_2_lists(struct List_node *head1, struct List_node *head2) {
	if(NULL == head1) {
	printf("\nERROR: extend_2_lists() : head1 == NULL\n");
	return NULL;
	}
	if(NULL == head2) {
	printf("\nERROR: extend_2_lists() : head2 == NULL\n");
	return NULL;
	}
	add_tail_to_list(head1, head2);
	return head1;
}


struct List_node * slice_list(struct List_node *start, 
			      struct List_node *end, 
			      void * (*data_copy)(void *, void *) ) {
	if(NULL == start) {
	printf("\nERROR: slice_list() : start == NULL\n");
	return NULL;
	}
	if(NULL == end) {
	printf("\nERROR: slice_list() : end == NULL\n");
	return NULL;
	}
	
	struct List_node *new_list_head = malloc(sizeof(struct List_node));
	if(NULL == new_list_head) {
		printf("\nERROR: can`t allocate memory for 'new_list_head' in"
		"slice_list() function\n");
		return NULL;
	}
	new_list_head->data = data_copy(start->data, new_list_head->data);

	/*
	 * ptr* - to iterates over maternal list (from start to end)
	 * tmp* - to iterates over derived list
	 */
	struct List_node *ptr = start->next;
	struct List_node *tmp;
	while(ptr != end->next) {
		tmp = malloc(sizeof(struct List_node));
		if(NULL == tmp) {
			printf("\nERROR: can`t allocate memory for 'tmp' in"
			"slice_list() func\n");
			return NULL;
		}
		tmp->data = data_copy(ptr->data, tmp->data);

		add_tail_to_list(new_list_head, tmp);
		ptr = ptr->next;
	}
	return new_list_head;
}


void * data_copy_Person(void *from, void *to) {
	if(NULL == from) {
		printf("\nERROR: data_copy_Person() : from == NULL\n");
		return NULL;
	}
	
	to = malloc(sizeof(struct Person));
	if(NULL == to) {
		printf("\nERROR: can`t allocate memory for 'to' in "
		"data_copy_Person() func\n");
		return NULL;
	}
	memmove(to, from, sizeof(struct Person));
	return to;
}
