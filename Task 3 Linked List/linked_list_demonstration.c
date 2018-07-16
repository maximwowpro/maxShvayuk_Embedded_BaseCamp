/*
 * Writed by Max Shvayuk.
 * 13.07.2018
 */

#include <stdio.h>
#include <stdlib.h>
#include "linked_list.h"

int main(void)
{
	int error_checker = 0;
	
	/*Pointers to functions to work with struct Person in list`s nodes*/
	void (*print_func)(void *) = print_struct_Person;
	int  (*struct_free_func)(void *) = free_person;
	bool (*compare_ascending)(void *, void *) = compare_Person_ascending;
	bool (*compare_descending)(void *, void *) = compare_Person_descending;
	void * (*data_copy)(void *, void *) = data_copy_Person;
	bool (*find_help_func)(void *, void *) = find_equality_func_Person;
	
	
	printf("Let me demonstrate you my linked list:\n");
	printf("\n_______________________________________________\n");
	
	/*
	 * Create linked list with 5 nodes. Data = struct Person.
	 */
	
	struct List_node *head;
	
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

	head = nod5;
	
	/*Insert data into list nodes: */
	CREATE_LIST_NODE(nod1, per1, struct Person)
	CREATE_LIST_NODE(nod2, per2, struct Person)
	CREATE_LIST_NODE(nod3, per3, struct Person)
	CREATE_LIST_NODE(nod4, per4, struct Person)
	CREATE_LIST_NODE(nod5, per5, struct Person)	
	
	/*Test add_head_to_list() function: */
	error_checker = add_head_to_list(head, nod5);
	error_checker = add_head_to_list(head, nod4);
	error_checker = add_head_to_list(head, nod3);
	error_checker = add_head_to_list(head, nod2);
	error_checker = add_head_to_list(head, nod1);
	
	/*Print list: */
	printf("So, our list is:\n");
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");

	
	/*Test add_tail_to_list() function: */
	printf("Now lets add new node to the tail of list:\n");
	/*Create node for adding to tail: */
	struct Person *per_tail = malloc(sizeof(struct Person));
	struct List_node *nod_tail = malloc(sizeof(struct List_node));
	per_tail->name = "tail";
	per_tail->age = 6;
	CREATE_LIST_NODE(nod_tail, per_tail, struct Person)
	
	error_checker = add_tail_to_list(head, nod_tail);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");

	
	/*Test remove_list_head() function: */
	printf("Now lets delete list`s head:\n");
	error_checker = remove_list_head(head, struct_free_func);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test remove_list_tail() function: */
	printf("Now lets delete list`s tail:\n");
	error_checker = remove_list_tail(head, struct_free_func);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test count_list_nodes() function: */
	printf("Now lets count list`s nodes:\n");
	printf("Our linked list contains %i nodes\n", 
	       error_checker = count_list_nodes(head) );
	printf("\n_______________________________________________\n");
	
	
	/*Test find_list_node() function: */
	printf("Now lets find struct Person with such fields:\n"
	       "age = 3; name = \"333\"\n");	
	struct List_node *target_node = 
		find_list_node(head, per3, find_help_func);
	printf("Node, found by find_list_node() is:\n");
	/*
	 * Why do I use target_node->next->data instead of 
	 * target_node->data look in linked_list.h, in description of
	 * find_list_node() function.
	 */
	/*Print finded node: */
	print_func(target_node->next->data);
	printf("\n_______________________________________________\n");
	
	
	/*
	 * Test insert_node_to_preset_position() function: 
	 * Here I use pointer target_node(second element of list), received in
	 * test find_list_node() function.
	 */
	printf("Now lets insert struct Person with such fields:\n"
	       "age = 2018; name = \"inserting node\"\n"
	       "to the second node of list\n");
	/*Create this node: */
	struct Person *per_insert = malloc(sizeof(struct Person));
	struct List_node *nod_insert = malloc(sizeof(struct List_node));
	per_insert->name = "inserting node";
	per_insert->age = 2018;
	CREATE_LIST_NODE(nod_insert, per_insert, struct Person)
	/*Insert it: */
	error_checker = insert_node_to_preset_position
		(target_node, nod_insert);
	printf("And list after inserting node is:\n");
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*
	 * Test delete_preset_node() function: 
	 * Here I use pointer target_node(second element of list), received in
	 * test find_list_node() function.
	 */
	printf("Now lets delete second node of list\n");
	error_checker = delete_preset_node
		(target_node, struct_free_func);
	printf("And list after deleting node is:\n");
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test reverse_list() function: */
	printf("Now lets reverse list:\n");
	printf("Linked list after reversing is:\n");
	head = reverse_list(head);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test bubble_sort_list() ascending function: */
	printf("Now lets sort list in ascending:\n");
	printf("Linked list after sorting is:\n");
	bubble_sort_list(head, compare_ascending);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test bubble_sort_list() descending function: */
	printf("And now lets sort list in descending:\n");
	printf("Linked list after sorting is:\n");
	bubble_sort_list(head, compare_descending);
	traverse_list(head, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*
	 * Now the list is:
	 * 5->4->3->2->NULL
	 * I want to slice it and create a new list with nodes:
	 * 4->3->NULL
	 * using slice_list() function.
	 * To access pointers to nodes 4 and 3 (start and end of new list),
	 * I will use find_list_node() function.
	 */
	printf("Now lets test slice_list() function\n");
	struct List_node *start = find_list_node(head, per4, find_help_func);
	struct List_node *end = find_list_node(head, per3, find_help_func);
	/*
	 * Why do I use start->next and end->next instead of 
	 * start and end, look in linked_list.h, in description of
	 * find_list_node() function.
	 */
	struct List_node *head_slice = slice_list(start->next, end->next, data_copy);
	printf("And new list is:\n");
	traverse_list(head_slice, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*
	 * Now we have 2 lists :
	 * 5->4->3->2->NULL
	 * and
	 * 4->3->NULL
	 * using extend_2_lists() function i want to obtain next list:
	 * 5->4->3->2->4->3->NULL
	 * So, the head ot the second list will be the next 
	 * element after tail of first list.
	 */
	printf("Now lets test extend_2_lists() function\n"
		"I wil add second list after first:\n"
		"first = 5->4->3->2->NULL\n"
		"and second = 4->3->NULL\n"
		"Extended list should be: 5->4->3->2->4->3->NULL\n");
	struct List_node *head_extended = extend_2_lists(head, head_slice);
	printf("And new extended list is:\n");
	traverse_list(head_extended, print_func);
	printf("\n_______________________________________________\n");
	
	
	/*Test clear_list() function: */
	printf("And finally lets clear list:\n");
	printf("Linked list after sorting is:\n");
	error_checker = clear_list(&head_extended, struct_free_func);
	printf("\nAnd if we try traverse list, we have error:");
	traverse_list(head_extended, print_func);
	printf("\n_______________________________________________\n");
	
	return error_checker;
}
