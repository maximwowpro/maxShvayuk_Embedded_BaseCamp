#define DEBUG

#ifdef DEBUG
#define LOG(function_name, problem_description, problem_variable)\
	printf("\nERROR: %s : %s %s\n", \
	       function_name, problem_description, problem_variable);
#else
#define LOG(...)
#endif

struct Matrix {
	unsigned int rows;
	unsigned int columns;
	int **ptr;
};


/* Error-related stuff */
enum _errors {
	E_OK = 0,
	E_FOPEN,
	E_FREAD,
	E_ALLOC,
	E_CPUSET,
	E_INCORRECT_MATRIX,
	E_NULL_POINTER
};

/* just print matrix */
int matrix_traverse(struct Matrix *matrix);

/* fill matrix by random ints which are <= max_number */
int matrix_fill_random(struct Matrix *matrix, unsigned int max_number);

/* need this 2 inline functions for calculating determinant*/
inline int cyclic_plus(int number, int max) {
	return ( ++number <= max ? number : 0 );
}

inline int cyclic_minus(int number, int max) {
	return ( --number >= 0 ? number : max );
}

/* calculating determinant of matrix and write it to *determinant */
int matrix_find_determinant(struct Matrix *matrix, int *determinant);
