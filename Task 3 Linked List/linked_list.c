#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "linked_list.h"


int add_head_to_list(struct List_node *old_head, struct List_node *new_head) {
	struct List_node *tmp = malloc(sizeof(*old_head));
	if(NULL == tmp) {
		printf("ERROR: can`t allocate memory for \
		struct List_node *tmp  in function add_head_to_list()!\n");
		return 1;
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
	struct List_node *ptr;
	ptr = head;
	if(NULL == ptr) {
		printf("ERROR: can`t allocate memory for \
		struct List_node *ptr  in function add_tail_to_list()!\n");
		return 1;
	}
	while(NULL != ptr->next)
		ptr = ptr->next;

	ptr->next = new_tail;
	return 0;
}

void remove_list_head(struct List_node *head, void(*struct_free_func)(void *)) {
	struct List_node *second_node = head->next;
	struct_free_func(head->data);
	head->data = second_node->data;
	head->next = second_node->next;
	free(second_node);
	return;
}
	
void remove_list_tail(struct List_node *head, void(*struct_free_func)(void *)) {
	struct List_node *ptr = head;
	while(NULL != ptr->next->next) {
		ptr = ptr->next;
		print_struct_Person(ptr->data);
	}
	struct_free_func(ptr->next->data);
	free(ptr->next);
	ptr->next = NULL;
	return;
}


void print_struct_Person(void *struct_to_print) {
	if(NULL != (struct Person *)struct_to_print) 
		printf("struct Person:\nname=%s, age=%i\n",
			((struct Person *)(struct_to_print))->name,
			((struct Person *)(struct_to_print))->age);	
	return;
}


void traverse_list(struct List_node *list_head, void (*print_struct)(void*) ) {
	struct List_node *ptr = list_head;
	int counter = 0;
	printf("\nTraversing list:\n");
	while(NULL != ptr && counter < 10)
	{
		printf("linked list node №%i: \n", counter);
		print_struct(ptr->data);
		printf("\n");
		ptr = ptr->next;
		counter++;
	}
	return;
}

int count_list_nodes(struct List_node *list_head) {
	struct List_node *ptr = list_head;
	int counter = 0;
	while(NULL != ptr) {
		ptr = ptr->next;
		counter++;
	}
	
	return counter;
}

void free_person(void *struct_to_free) {
	((struct Person *)struct_to_free)->name = "";
	((struct Person *)struct_to_free)->age = 0;
	return;
}

int clear_list(struct List_node *list_head, void(*struct_free_func)(void *) ) {
	struct List_node *ptr = list_head;
	struct List_node *tmp_ptr = ptr;
	int counter = 0;
	printf("\nCleaning list:\n");
	while(NULL != ptr)
	{
		printf("Cleaning node №%i: \n", counter);
		struct_free_func(ptr->data);
		free(ptr->data);
		ptr = ptr->next;
		free(tmp_ptr);
		tmp_ptr = ptr;
		counter++;
	}
	return 0;
}

bool find_equality_func_Person(void *data_person, void *values_to_find) {
	bool is_equally = false;
	int age_to_find = ((struct Person *)values_to_find)->age;
	char *name_to_find = ((struct Person *)values_to_find)->name;
	
	if(NULL != ((struct Person *)data_person) ) {		
		if(((struct Person *)data_person)->age == age_to_find &&
		((struct Person *)data_person)->name == name_to_find )
			is_equally = true;
	}
	return is_equally;
}


struct List_node * find_list_node(struct List_node *head, void *values_to_find, 
        bool(*struct_find_equality_func)(void *, void *) ) {
	struct List_node *ptr = head;
	if( true == struct_find_equality_func(ptr->data, values_to_find) ) {
		struct List_node *tmp_ptr = malloc(sizeof(struct List_node));
		tmp_ptr->next = ptr;
		return tmp_ptr;
	}
	
	while(NULL != ptr) {
		print_struct_Person(ptr->data);
		if(NULL != ptr->next) {
			if( true == 
			struct_find_equality_func(ptr->next->data, values_to_find) ) {
				return ptr;
			}
		}
		ptr = ptr->next;
	}
	
	printf("\nCan`t find such node at the list\n");
	return NULL;

}
	

void insert_node_to_preset_position
(struct List_node *prev_node, struct List_node *node_to_insert) {
	node_to_insert->next = prev_node->next;
	prev_node->next = node_to_insert;
	return;
}


void delete_preset_node(struct List_node *prev_node, void(*struct_free_func)(void *)) {
	struct List_node *delete_node = prev_node->next;
	prev_node->next = delete_node->next;
	
	struct_free_func(delete_node->data);
	free(delete_node);
	return;
}

struct List_node * reverse_list(struct List_node *head) {
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

void bubble_sort_list(struct List_node *head, bool(*compare_func)(void *, void *) ) {
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
	return;
}



int main(void) 
{
	int error_checker = 0;
	void (*print_func)(void *) = print_struct_Person;
	void (*struct_free_func)(void *) = free_person;
	bool (*compare_ascending)(void*, void *) = compare_Person_ascending;
	bool (*compare_descending)(void*, void *) = compare_Person_descending;
	
	
	struct List_node *head = malloc(sizeof(struct List_node));
	
	struct Person *per1 = malloc(sizeof(struct Person));
	struct List_node *nod1 = malloc(sizeof(struct List_node));
	per1->name = "111";
	per1->age = 1;
	
	struct Person *per2 = malloc(sizeof(struct Person));
	struct List_node *nod2 = malloc(sizeof(struct List_node));
	per2->name = "222";
	per2->age = 2;
	
	struct Person *per3 = malloc(sizeof(struct Person));
	struct List_node *nod3 = malloc(sizeof(struct List_node));
	per3->name = "333";
	per3->age = 3;
	
	struct Person *per4 = malloc(sizeof(struct Person));
	struct List_node *nod4 = malloc(sizeof(struct List_node));
	per4->name = "444";
	per4->age = 4;
	
	struct Person *per5 = malloc(sizeof(struct Person));
	struct List_node *nod5 = malloc(sizeof(struct List_node));
	per5->name = "555";
	per5->age = 5;
	
	struct Person *per6 = malloc(sizeof(struct Person));
	struct List_node *nod6 = malloc(sizeof(struct List_node));
	per6->name = "666";
	per6->age = 6;
	
	head = nod5;
	
	CREATE_LIST_NODE(nod1, per1, struct Person)
	CREATE_LIST_NODE(nod2, per2, struct Person)
	CREATE_LIST_NODE(nod3, per3, struct Person)
	CREATE_LIST_NODE(nod4, per4, struct Person)
	CREATE_LIST_NODE(nod5, per5, struct Person)
	CREATE_LIST_NODE(nod6, per6, struct Person)

//	printf(" max adr=%i  new1->data=%i, new1->next=%i\n",(int)new1, (int)new1->data, (int)new1->next);
//	printf("oleg adr=%i lol2->data=%i, lol2->next=%i\n\n",(int)lol2, (int)lol2->data, (int)lol2->next);
	
	error_checker = add_head_to_list(head, nod5);
	error_checker = add_head_to_list(head, nod4);
	error_checker = add_head_to_list(head, nod3);
	error_checker = add_head_to_list(head, nod2);
	error_checker = add_head_to_list(head, nod1);

//	printf(" max adr=%i  new1->data=%i, new1->next=%i\n",(int)new1, (int)new1->data, (int)new1->next);
//	printf("oleg adr=%i lol2->data=%i, lol2->next=%i\n\n",(int)lol2, (int)lol2->data, (int)lol2->next);
	
	traverse_list(head, print_func);

	printf("\n__________________________________\n");
	
	//error_checker = add_tail_to_list(head, nod6);
	
	//printf("\n__________________________________\n");
	
	//traverse_list(head, print_func);
	
	//printf("\n__________________________________\n");
	
	//clear_list(head, free_person);
	
	//printf("\n__________________________________\n");

	
// 	struct Person *per7 = malloc(sizeof(struct Person));
// 	struct List_node *nod7 = malloc(sizeof(struct List_node));
// 	per7->name = "777";
// 	per7->age = 7;
// 	CREATE_LIST_NODE(nod7, per7, struct Person)
	//printf("\n\npointer_next 777 =%i\n\n", (int)nod6->next);

/*
	if (true == find_equality_func_Person(nod7->data, per7) )
 		printf("\nis equal\n");
	
	print_struct_Person(head->data);
	*/
	//bool(*equal_func_person)(void *, void *) = find_equality_func_Person;
	
	//struct List_node *tmp_ptr = find_list_node(head, per3, equal_func_person);
	
//	printf("\n__________________________________\n");
// 	if( NULL != tmp_ptr) {
// 		printf("\n\nqwerty\n\n");
// 		print_struct_Person(tmp_ptr->next->data);
// 	}
	//insert_node_to_preset_position(tmp_ptr, nod7);
	
// 	printf("\n__________________________________\n");
// 	
// 	traverse_list(head, print_func);
// 
// 	printf("\n__________________________________\n");
// 	
// 	delete_preset_node(tmp_ptr, struct_free_func);
// 	traverse_list(head, print_func);
// 		
// 	printf("\n__________________________________\n");
// 	
// 	remove_list_head(head, struct_free_func);
// 	traverse_list(head, print_func);
// 		
// 	printf("\n__________________________________\n");
// 	
// 	remove_list_tail(head, struct_free_func);
// 	traverse_list(head, print_func);
// 		
// 	printf("\n__________________________________\n");
// 	
// 	printf("\nlist contains %i nodes\n", count_list_nodes(head) );
// 	
	printf("\n\n\n__________________________________\n");
	
	head = reverse_list(head);
	traverse_list(head, print_func);

	printf("\n__________________________________\n");

	bubble_sort_list(head, compare_ascending);
	traverse_list(head, print_func);
	
	printf("\n__________________________________\n");
	
	
	bubble_sort_list(head, compare_descending);
	traverse_list(head, print_func);
	
	printf("\n__________________________________\n");
	return 0;
}













