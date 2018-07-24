#include "matrix.h"

#include <stdio.h>
#include <stdlib.h>

int matrix_traverse(struct Matrix *matrix) {
	if(NULL == matrix) {
		LOG("matrix_traverse", "matrix pointer == NULL", "")
		return E_NULL_POINTER;
	}
	for(unsigned int i=0; i<matrix->rows; i++) {
		for(unsigned int j=0; j<matrix->columns; j++)
			printf(" %i ", matrix->ptr[i][j] );
		printf("\n");
	}
	return E_OK;
}

int matrix_fill_random(struct Matrix *matrix, unsigned int max_number) {
	if(NULL == matrix) {
		LOG("matrix_fill_random", "matrix pointer == NULL", "")
		return E_NULL_POINTER; 
	}
	for(unsigned int i=0; i<matrix->rows; i++) {
		for(unsigned int j=0; j<matrix->columns; j++) 
			matrix->ptr[i][j] = rand() % max_number + 10;		
	}
	return E_OK;
}

extern int cyclic_plus(int number, int max);

extern int cyclic_minus(int number, int max);


int matrix_find_determinant(struct Matrix *matrix, int *determinant) {
	if(NULL == matrix) {
		LOG("matrix_find_determinant", "matrix pointer == NULL", "")
		return E_NULL_POINTER;
	}	
	if(matrix->rows != matrix->columns) {
		LOG("matrix_find_determinant", "matrix isn`t square", "")
		return E_INCORRECT_MATRIX;
	}
	if(2 == matrix->rows) {
		*determinant = matrix->ptr[0][0] * matrix->ptr[1][1] - 
			       matrix->ptr[0][1] * matrix->ptr[1][0];
		return E_OK;
	}
	
	unsigned int row_start = 0;
	unsigned int col_start = 0;
	int row_tmp = row_start;
	int col_tmp = 0;
	int multi = 1; /* multiplication */
	int sum1 = 0;
	int sum2 = 0;
	
	for(; col_start < matrix->columns; col_start++) {
		multi = 1;
		col_tmp = col_start;
		for(unsigned int i=0; i < matrix->columns; i++) {
			
			multi *=  matrix->ptr[row_tmp][col_tmp];
			row_tmp = cyclic_plus(row_tmp, matrix->columns-1);
			col_tmp = cyclic_plus(col_tmp, matrix->columns-1);
		}
		sum1 += multi;
	}

	row_start = matrix->columns-1;
	row_tmp = row_start;
	col_start = 0;
	
	for(; col_start < matrix->columns; col_start++) {
		multi = 1;
		col_tmp = col_start;
		for(unsigned int i=0; i < matrix->columns; i++) {
			
			multi *=  matrix->ptr[row_tmp][col_tmp];
			
			row_tmp = cyclic_minus(row_tmp, matrix->columns-1);
			col_tmp = cyclic_plus (col_tmp, matrix->columns-1);
		}
		sum2 += multi;
	}
	
	*determinant = sum1 - sum2;
	return E_OK;
}
