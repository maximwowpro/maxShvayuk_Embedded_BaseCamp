#define _GNU_SOURCE

#include "matrix.h"

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <unistd.h>
#include <time.h>
#include <math.h>
#include <sched.h>
#include <pthread.h>
#include <limits.h>

static const char help_str[] = {
  "[-h] -r ROWS -c COLUMNS "
  "-t NUM_THREADS -n ARRAY_SIZE\n"
  "Evaluate the time required to do a simple threaded operation of counting"
  "determinant of random - filled matrixes of INTs"
};

static cpu_set_t all_cores(void)
{
	cpu_set_t cpuset;
	pthread_t this = pthread_self();
	printf("main thread id = %i\n", (int)this);
	pthread_getaffinity_np(this, sizeof(cpu_set_t), &cpuset);
	int numcores = sysconf(_SC_NPROCESSORS_ONLN);
	printf("numcores = %i\n", numcores);
	for (int id = 0; id < numcores; id++) {
		printf("Core %d was %d\n", id, CPU_ISSET(id, &cpuset));
		CPU_SET(id, &cpuset);
	}
	pthread_setaffinity_np(this, sizeof(cpu_set_t), &cpuset);
	return cpuset;
}

/**
 * timespec_diff() - returns time difference in milliseconds for two timespecs.
 * @stop:	time after event.
 * @start:	time before event.
 *
 * Uses difftime() for time_t seconds calcultation.
 */
static double timespec_diff(struct timespec *stop, struct timespec *start)
{
	double diff = difftime(stop->tv_sec, start->tv_sec);
	diff *= 1000;
	diff += (stop->tv_nsec - start->tv_nsec) / 1e6;
	return diff;
}

struct thread_data {
	double spent_time; /* shared, time, spended by all threads */
	unsigned int rows;
	unsigned int columns;
	/* I use counter_threads variable to distribute tasks between threads, shared */
	unsigned int counter_threads;
	unsigned long long num_items;
	unsigned int num_threads;
	unsigned long long *completed_operations; /* analog of control summ, shared */
	pthread_mutex_t *lock; 
	
};

/* This function runs in each thread */
void *threadfunc(void *args)
{
	pthread_t this = pthread_self();
	struct thread_data *data = args;
	struct timespec start_time, end_time;
	
	pthread_mutex_lock(data->lock);		/* lock mutex*/
	int index = data->counter_threads;
	data->counter_threads++;
	pthread_mutex_unlock(data->lock);      	/* unlock mutex */
	
	long long begin_number = data->num_items / data->num_threads * index;
	long long last_number  = 
		data->num_items / data->num_threads + begin_number;
	unsigned long long completed_operations_local = 0;
	
	/* create matrix, allocate memory for it, fill matrix by random ints*/
	struct Matrix matrix;
	matrix.ptr = malloc(data->rows * sizeof(*(matrix.ptr)) );
	for(unsigned int i=0; i < data->columns; i++)
		matrix.ptr[i] = malloc(data->columns * sizeof(*(matrix.ptr[i])));
	matrix.rows = data->rows;
	matrix.columns = data->columns;
	int determinant = 0;
	matrix_fill_random(&matrix, 99);
	
	/******start local timewatch******/
	clock_gettime(CLOCK_REALTIME, &start_time);
	/*find determinant many times for random-filled matrix */
	for(long long i = begin_number; i < last_number; i++) {
		matrix_find_determinant(&matrix, &determinant);
		completed_operations_local++;
	}
	clock_gettime(CLOCK_REALTIME, &end_time);
	/*******stop local timewatch******/
	
	pthread_mutex_lock(data->lock);        /* lock mutex*/
	data->spent_time += timespec_diff(&end_time, &start_time);
	printf("thread\t%i: start=%lli\tend=%lli\tindex=%i\t"
	       "local_operations=%llu\tlocal_thread_time=%.2f\n",
	       (int)this, begin_number, last_number, index,
	       completed_operations_local, 
	       timespec_diff(&end_time, &start_time));
	*(data->completed_operations) += completed_operations_local;
	pthread_mutex_unlock(data->lock);      /* unlock mutex */
	
	return NULL;
}

int main (int argc, char *argv[])
{
	unsigned long long num_items = 0;
	int num_threads = 0;
	unsigned int rows = 0;
	unsigned int columns = 0;
	/* Parsing arguments */
	opterr = 0;
	int argopt;
	/* "hr:c:t:n:" means h,r,c,t,n switches, r, c, t, n require argument */
	while ((argopt = getopt(argc, argv, "hr:c:t:n:")) != -1) {
		switch(argopt) {
		case 'h':
			printf("Usage: %s %s\n", argv[0], help_str);
			exit(0);
		case 'r':
			rows = atoi(optarg);
			break;
		case 'c':
			columns = atoi(optarg);
			break;
		case 't':
			num_threads = atoi(optarg);
			break;
		case 'n':
			num_items = atoll(optarg);
			break;
		default:
			fprintf(stderr, "Unknown option '%s'\n", optarg);
			exit(EXIT_FAILURE);
		}
	}
	
	if (argc <= 1) {
		printf("Usage: %s %s\n", argv[0], help_str);
		exit(0);
	}
	if (num_threads <= 0 || num_items <= 0) {
		fprintf(stderr, "NUM_THREADS and ARRAY_SIZE are ints > 0\n");
		exit(EXIT_FAILURE);
	}
	if (rows <= 0 || columns <= 0) {
		fprintf(stderr, "ROWS and COLUMNS are ints > 0\n");
		exit(EXIT_FAILURE);
	}
	if (rows != columns) {
		fprintf(stderr, "ROWS and COLUMNS should be equally\n");
		exit(EXIT_FAILURE);
	}	

	/* Configure thread flags */
	pthread_attr_t thread_attrs;
	pthread_attr_init(&thread_attrs); /* fill with default attributes */
	// Set scheduler to FIFO for spawned threads
	pthread_attr_setschedpolicy(&thread_attrs, SCHED_FIFO);
	// Set maximum priority for main and other threads
	// As long as on Linux they compete for overall system resources
	pthread_setschedprio(pthread_self(), sched_get_priority_max(SCHED_FIFO));
	struct sched_param param;
	pthread_attr_getschedparam(&thread_attrs, &param);
	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
	pthread_attr_setschedparam(&thread_attrs, &param);
	cpu_set_t cpuset = all_cores();
	int ret = pthread_attr_setaffinity_np(&thread_attrs, sizeof(cpu_set_t), &cpuset);
	if (ret < 0)
		goto exc_aff;
	
	pthread_mutex_t mutex;
	pthread_mutex_init(&mutex, NULL);
	
	pthread_t *threads = malloc(num_threads * sizeof(*threads) );
	
	/* initialize thread_data */
	struct thread_data *data = malloc(sizeof(*data) );
	data->spent_time = 0.;
	data->rows = rows;
	data->columns = columns;
	data->counter_threads = 0;
	data->num_items = num_items;
	data->num_threads = num_threads;
	data->completed_operations = 
		malloc(sizeof(*(data->completed_operations) ) );
	*(data->completed_operations) = 0;
	data->lock = &mutex;

	struct timespec start_time, end_time;
	/******start global timewatch******/
	clock_gettime(CLOCK_REALTIME, &start_time);
	for(int i=0; i < num_threads; i++)
		pthread_create(&threads[i], &thread_attrs, threadfunc, data);

	printf("\nWaiting for threads...\n");
	for(int i=0; i < num_threads; i++)
		pthread_join(threads[i], NULL);
	
	clock_gettime(CLOCK_REALTIME, &end_time);
	/*******stop global timewatch******/
	
	double time_global = timespec_diff(&end_time, &start_time);
	double time_avg_thread = data->spent_time / num_threads;
	printf( "\nReport:\nMatrix size: %u * %u\nThreads: %i\n"
		"Number items: %llu\nOperations in threads(control summ): %llu"
	        "\nAverage thread time: %.2f ms\nAll program`s time: %.2f ms\n\n",
		rows, columns, num_threads, num_items,
		*data->completed_operations, time_avg_thread, time_global);
	
	pthread_mutex_destroy(&mutex);
	free(data->completed_operations);
	free(data);
	exc_aff:
		pthread_attr_destroy(&thread_attrs);
	return 0;
}
