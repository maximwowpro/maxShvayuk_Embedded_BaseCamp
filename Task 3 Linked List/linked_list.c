#include <stdio.h>
#include <stdlib.h>
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
	while(NULL != ptr)
	{
		printf("linked list node №%i: \n", counter);
		print_struct(ptr->data);
		printf("\n");
		ptr = ptr->next;
		counter++;
	}
	return;
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



int main(void) 
{
	int error_checker = 0;
	void (*print_func)(void *) = print_struct_Person;
	void (*struct_free_func)(void *) = free_person;
	
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
	
	head = nod1;
	
	CREATE_LIST_NODE(nod1, per1, struct Person)
	CREATE_LIST_NODE(nod2, per2, struct Person)
	CREATE_LIST_NODE(nod3, per3, struct Person)
	CREATE_LIST_NODE(nod4, per4, struct Person)
	CREATE_LIST_NODE(nod5, per5, struct Person)
	CREATE_LIST_NODE(nod6, per6, struct Person)

//	printf(" max adr=%i  new1->data=%i, new1->next=%i\n",(int)new1, (int)new1->data, (int)new1->next);
//	printf("oleg adr=%i lol2->data=%i, lol2->next=%i\n\n",(int)lol2, (int)lol2->data, (int)lol2->next);
	
	error_checker = add_head_to_list(head, nod2);
	error_checker = add_head_to_list(head, nod3);
	error_checker = add_head_to_list(head, nod4);
	error_checker = add_head_to_list(head, nod5);
	
//	printf(" max adr=%i  new1->data=%i, new1->next=%i\n",(int)new1, (int)new1->data, (int)new1->next);
//	printf("oleg adr=%i lol2->data=%i, lol2->next=%i\n\n",(int)lol2, (int)lol2->data, (int)lol2->next);
	
	traverse_list(head, print_func);

	printf("\n__________________________________\n");
	
	error_checker = add_tail_to_list(head, nod6);
	
	printf("\n__________________________________\n");
	
	traverse_list(head, print_func);
	
	printf("\n__________________________________\n");
	
	clear_list(head, free_person);
	
	printf("\n__________________________________\n");

	return 0;
}













