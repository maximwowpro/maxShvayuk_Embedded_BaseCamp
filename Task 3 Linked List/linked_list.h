/*
 * Writed by Max Shvayuk.
 * 13.07.2018
 */

#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include <stdbool.h>


/**
 * struct List_node - a simple node of linked list.
 * @next: pointer to the next node of linked list
 * @data: pointer to any data, which is embedded to linked list.
 *
 * You can add any data to this linked list, because @data has a type void *.
 */
struct List_node {
	struct List_node *next;
	void *data;
};



/**
 * struct Person - just a simple struct to demonstrate work of linked list.
 * @age: int number value
 * @name: char* string
 */
struct Person {
	int age;
	char* name;
};



/**
 * CREATE_LIST_NODE() - macro for creating node of linked list with any
 * 			type of data.
 * @list_node: ptr to struct List_node
 * @data_struct: ptr to variable or struct, which should be embedded
 * 		 to @list_node , at the field "data".
 * @data_struct_name: the type of @data_struct. For example "struct Person".
 * 
 * This macro do next things:
 * - set @list_node->next to NULL value
 * - allocate the memory for @list_node->data. The size of allocated memory 
 * depends of @data_struct_name.
 * - copy @data_struct value to @list_node->data. 
 * Note that the memory occupied by @data_struct is not freed, you
 * should free() it by yourself.
 */
#define CREATE_LIST_NODE(list_node, data_struct, data_struct_name) \
	list_node->next = NULL; \
	list_node->data = malloc(sizeof(data_struct_name)); \
	if(NULL == list_node->data) { \
		printf("ERROR: can`t allocate memory for data in \
		macro CREATE_LIST_NODE()!\n"); \
	} \
	*((data_struct_name *)(list_node->data)) = *(data_struct);
	
	

/**
 * add_head_to_list() - add a new node to head(begin) of existing linked list
 * @old_head: ptr to the head of linked list 
 * 	      (will be the second element after this function`s work).
 * @new_head: ptr to list node, which will be the head of linked list
 * 	      after this function`s work.
 * 
 * Return: 0 - OK
 * 	  -1 - @old_head or @new_head == NULL
 * 	  -2 - can`t allocate memory for "tmp" pointer
 */
int add_head_to_list(struct List_node *old_head, struct List_node *new_head);



/**
 * add_tail_to_list() - add a new node to the tail(end) of existing linked list
 * @head: ptr to the head of linked list.
 * @new_tail: ptr to list node, which will be the new tail of linked list
 * 	      after this function`s work.
 * 
 * Add a @new_tail to the end of existing linked list.
 * This new tail "next" field will point to NULL.
 * 
 * Return: 0 - OK
 * 	  -1 - @head or @new_tail == NULL
 */
int add_tail_to_list(struct List_node *head, struct List_node *new_tail);



/**
 * remove_list_head() - remove a head of existing linked list.
 * @head: ptr to the head of linked list.
 * @struct_free_func: ptr to the function, which correctly 
 * 		     frees memory in @head->data struct.
 * 		     For example, free_person() function.
 * 
 * Remove a head of linked list.
 * A second node of this linked list becomes a new head.
 * Free memory, which was allocated for data in first node.
 * 
 * Return: 0 - OK
 * 	  -1 - @head or @struct_free_func == NULL
 */
int remove_list_head(struct List_node *head, int(*struct_free_func)(void *));



/**
 * remove_list_tail() - remove a tail of existing linked list.
 * @head: ptr to the head of linked list.
 * @struct_free_func: ptr to the function, which correctly 
 * 		      frees memory in list_tail->data struct.
 * 		      For example, free_person() function.
 * 
 * Return: 0 - OK
 * 	  -1 - @head or @struct_free_func == NULL
 */
int remove_list_tail(struct List_node *head, int(*struct_free_func)(void *));


/**
 * free_person() - correctly frees memory, occupied by "struct Person".
 * @struct_to_free: ptr to the struct Person, which should be deleted.
 * 
 * Set all fields of @struct_to_free to zeros.
 * 
 * Return: 0 - OK
 * 	  -1 - @struct_to_free == NULL
 */
int free_person(void *struct_to_free);



/**
 * traverse_list() - print all list
 * @list_head: ptr to the head of linked list.
 * @print_struct: ptr to the function, which correctly 
  	          print all fields of list_node->data.
 * 		  For example, print_struct_Person() function.
 * Return: 0 - OK
 * 	  -1 - @list_head or @print_struct == NULL
 */
int traverse_list(struct List_node *list_head, void (*print_struct)(void*) );



/**
 * print_struct_Person() - print all fields by struct Person.
 * @struct_to_print: ptr to the struct Person, which should be printed.
 * 
 * If there is nothing to print (struct_to_print ptr == NULL), 
 * the error message will be printed.
 */
void print_struct_Person(void *struct_to_print);



/**
 * count_list_nodes() - return the number of nodes in linked list
 * @list_head: ptr to the head of linked list.
 * 
 * If @list_head == NULL, prints error message.
 * 
 * Return:
 * * -1 - error code. Notify that @list_head == NULL.
 * * Any positive number. - number of nodes in linked list.
 */
int count_list_nodes(struct List_node *list_head);



/**
 * clear_list() - delete all nodes of linked list.
 * @list_head: ptr to the head of linked list.
 * @struct_free_func: ptr to the function, which correctly 
 * 		      frees memory in list_node->data struct.
 * 		      For example, free_person() function.
 * 
 * If @list_head == NULL, prints error message.
 * 
 * Return:
 * * -1 - error code. Notify that @list_head or @struct_free_func == NULL.
 * *  0 - OK.
 */
int clear_list(struct List_node **list_head, int(*struct_free_func)(void *) );



/**
 * find_list_node() - finding a node with preset parameters in linked list
 * @head: ptr to the head of linked list.
 * @values_to_find: ptr to data with parameters that must be in the target node
 * @struct_find_equality_func: ptr to the function, which compares to identity
 *	two nodes. For example, find_equality_func_Person compares two 
 *      "struct Person" variables.
 * 
 * If @list_head == NULL, prints error message.
 * Note that this function returns NOT the pointer to the required variable,
 * but the pointer to variable, which is previously to required in linked list.
 *
 * For example, linked list:
 * node1->node2->node3->node4->node5->NULL
 * If you will search "node3", this function will returns you ptr to "node2".
 * To access node3, use node2->next.
 * 
 * If the required value is the head of the list, function creates empty node.
 * In this node "data" == NULL, and "next" ptr is pointed to head of list.
 * For example, linked list:
 * node1->node2->node3->node4->node5->NULL
 * If you will search "node1", this function creates empty_node with
 * suhc parameters:
 * "empty_node->data" == NULL
 * "empty_node->next" == node1
 * 
 * Return:
 * * NULL - Notify that there were some problems.
 * * pointer to node, which is previosly to required  - OK.
 */
struct List_node * find_list_node(struct List_node *head, void *values_to_find,
	bool(*struct_find_equality_func)(void *, void *) );



/**
 * find_equality_func_Person() - compares to identity
 *			    	 two struct Person variables.
 * @data_person: ptr to the struct Person which sgould be checked to
 * 		 identity with values_to_find.
 * @values_to_find: ptr to the struct Person with required parameters.
 * 
 * 
 * Return:
 * * -1 - error code. Notify that @list_head == NULL.
 * *  0 - OK.
 */
bool find_equality_func_Person(void *data_person, void *values_to_find);



/**
 * insert_node_to_preset_position() - insert a new node to preset position
 * 				      in linked list.
 * @prev_node: ptr to the node that is previosly to the place where 
 * 	       @node_to_insert should be inserted.
 * @node_to_insert: ptr to new node, which shoul be inserted to 
 * 		    linked list.
 * 
 * For example, linked list:
 * node1->node2->node3->node4->node5->NULL
 * If you want insert new node to the position of node3, you need use:
 * insert_node_to_preset_position(node2, node_to_insert);
 * 
 * Return:
 * * -1 - error code. Notify that @prev_node or @node_to_insert == NULL.
 * *  0 - OK.
 */
int insert_node_to_preset_position
	(struct List_node *prev_node, struct List_node *node_to_insert);



/**
 * delete_preset_node() - delete a node from preset position
 * @prev_node: ptr to the node that is previosly to the place 
 * 	       from we shold delete node.
 * @struct_free_func: ptr to the function, which correctly 
 * 		      frees memory in list_node->data struct.
 * 		      For example, free_person() function.
 * 
 * For example, linked list:
 * node1->node2->node3->node4->node5->NULL
 * If you want delete node3, you need use:
 * delete_preset_node(node2, struct_free_func);
 * 
 * Return:
 * * -1 - error code. Notify that @prev_node or @struct_free_func == NULL.
 * *  0 - OK.
 */
int delete_preset_node(struct List_node *prev_node, int(*struct_free_func)(void *));



/**
 * reverse_list() - reverse linked list
 * @head: ptr to the head of the linked list.
 * 
 * For example, linked list:
 * node1->node2->node3->node4->node5->NULL
 * After using this function it will be:
 * node5->node4->node3->node2->node1->NULL* 
 * 
 * !!! Notify that this function changes memory adress of the head of the list 
 * and returns it.
 * 
 * Return:
 * * NULL - something goes wrong.
 * * Pointer to the new head of linked list.
 */
struct List_node * reverse_list(struct List_node *head);



/**
 * bubble_sort_list() - bubble sort algorithm implementation for linked list.
 * @head: ptr to the head of the linked list.
 * @compare_func: function that compares two variables. Should be implemented
 * 		  for every new data type. 
 * 		  For example, here you can see
 * 		  compare_Person_ascending() and 
 * 		  compare_Person_descending() 
 * 		  for compairing 2 "struct Person" structs.
 * 
 * This function uses swap_data() function.
 * 
 * Return:
 * * -1 - error code. Notify that @head or @compare_func == NULL.
 * *  0 - OK.
 */
int bubble_sort_list(struct List_node *head, bool(*compare_func)(void *, void *) );



/**
 * compare_Person_ascending() - compares 2 "struct Person" 
 * 				structs using "age" field.
 * @first:  ptr to the first struct Person
 * @second: ptr to the second struct Person
 * 
 * true returns if we will should swap structs in sort function.
 * If first of second pointers == NULL, print error message, but not
 * abort function.
 * Return:
 * * true  - if first->age > second->age
 * * false - if first->age < second->age
 */
bool compare_Person_ascending(void *first, void *second);//true = need swap



/**
 * compare_Person_descending() - compares 2 "struct Person" 
 * 				 structs using "age" field.
 * @first:  ptr to the first struct Person
 * @second: ptr to the second struct Person
 * 
 * true returns if we will should swap structs in sort function.
 * If first of second pointers == NULL, print error message, but not
 * abort function.
 * 
 * Return:
 * * true  - if first->age < second->age
 * * false - if first->age > second->age
 */
bool compare_Person_descending(void *first, void *second);//true = need swap



/**
 * swap_data() - swap 2 first->data and second->data.
 * @first:  ptr to the first list node
 * @second: ptr to the second list node
 * 
* If first of second pointers == NULL, print error message, but not
 * abort function.
 * 
 * Return:
 * * true  - if first->age < second->age
 * * false - if first->age > second->age
 */
void swap_data(struct List_node *first, struct List_node *second);



/**
 * extend_2_lists() - "glue" together two linked lists.
 * @head1: ptr to the first list head
 * @head2: ptr to the second list head
 *
 * For example, linked list1 is:
 * head1->node2->node3->NULL
 * and linked list 2 is:
 * head2->node5->NULL
 * After using this function it will be:
 * head1->node2->node3->head2->node5->NULL
 * and function returns pointer to head1.
 * 
 * !!!Notify that this function NOT allocate memory for linked list 2 nodes.
 * It just set list1_tail_node->next to head2.
 * 
 * Return:
 * * NULL - if head1 or head2 == NULL.
 * * Pointer to the new head of extended linked list.
 */
struct List_node * extend_2_lists(struct List_node *head1, struct List_node *head2);



/**
 * slice_list() - creates a new derived list from part of maternal list.
 * @start: ptr to node of maternal list, which is the begin of derived list.
 * @end:   ptr to node of maternal list, which is the end of derived list.
 * @data_copy: ptr to function, which copies data from one memory
 * 	       adress to another. It depends on your 
 * 	       list_node->data data type.
 * 	       For example, data_copy_Person() function.
 * 
 * For example, linked list1 is:
 * node1->node2->node3->node4->node5->NULL
 * If we use:
 * slice_list(node2, node4, data_copy);
 * this function returns pointer to the head(node2) of derived list:
 * node2->node3->node4->NULL
 * 
 * This function allocates memory for derived linked list.
 * 
 * Return:
 * * NULL - if start or end == NULL, or if can`t allocate memory.
 * * Pointer to the head of derived linked list.
 */
struct List_node * slice_list(struct List_node *start, 
			      struct List_node *end, 
			      void * (*data_copy)(void *, void *) );



/**
 * data_copy_Person() - copying struct Person value
 * 			from one memory adress to another
 * 
 * @from: ptr to memory, from where we should copy
 * @end:  ptr to memory, where we should copy
 * 
 * This function allocates memory for @to and returns pointer to this memory.
 * 
 * Return:
 * * NULL - if @from == NULL, or if can`t allocate memory for @to.
 * * Pointer to the @to .
 */
void * data_copy_Person(void *from, void *to);


#endif
