/*
 * Created by Max Shvayuk
 * 05.07.2018
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <time.h>
#include <wand/magick_wand.h>


/**
 * timespec_diff() - returns time difference in milliseconds for two timespecs.
 * @stop:	time after event.
 * @start:	time before event.
 *
 * Uses difftime() for time_t seconds calcultation.
 */

double timespec_diff(struct timespec *stop, struct timespec *start)
{
	double diff = difftime(stop->tv_sec, start->tv_sec);
	diff *= 1000;
	diff += (stop->tv_nsec - start->tv_nsec) / 1e6;
	return diff;
}



/**
 * resize_image() - resize an image using "graphicsmagick" API
 * @paht_to_image:	path to source image which will be resized
 * @paht_to_image:	path to output image
 * @width:		width in pixels of output image 
 * @height:		height in pixels of output image
 *
 */

int resize_image(char* src_image, char* result_image, unsigned long width, unsigned long height)
{
	MagickWand *magick_wand;
	MagickPassFail status = MagickPass;
	InitializeMagick("");
	magick_wand=NewMagickWand();
	const FilterTypes filter = BoxFilter;
	
	/* Read input image */
	if (status == MagickPass)		
		status = MagickReadImage(magick_wand,src_image);
	
	/* Resizing image */
	MagickResizeImage( magick_wand, width, height, filter, 1 );

	/* Write output file */
	if (status == MagickPass)		
		status = MagickWriteImage(magick_wand,result_image);
	
	/* Errors handling */
	if (status != MagickPass) {
		char *description;
		ExceptionType severity;
		description=MagickGetException(magick_wand,&severity);
		(void) fprintf(stderr,"%.1024s (severity %d)\n",
                     description,severity);
	}
	
	DestroyMagickWand(magick_wand);
	DestroyMagick();
	return (status == MagickPass ? 0 : 1);
}


int main(int argc, char *argv[])
{
	unsigned long rows = 0;
	unsigned long columns = 0;

	/* Parse arguments */
	if (argc < 5) goto exc_fewargs;
	if (argc > 5) goto exc_argtoomuch;
	
	columns = atol(argv[3]);
	rows = atol(argv[4]);
	if (rows <= 0 || columns <= 0 ) 
		goto exc_wrongsize;	
	
	char* src_image = strdup(argv[1]);
	char* result_image = strdup(argv[2]);
	if (src_image == NULL || result_image == NULL)			
		goto exc_malloc;	
	
	

	/* Resizing */
	struct timespec time_now, time_after;

	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_now);

	int status = 0;
	status = resize_image(src_image, result_image, columns, rows);
	if(0 != status)
		goto exc_resize;

	clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time_after);
	
	/* Print measured resizing time */
	printf("Resizing of image took %g ms\n", timespec_diff(&time_after, &time_now));
 	free(src_image);
 	free(result_image);
 	return 0;


	/* Exception handling */
	exc_fewargs:
	printf("Error: too few arguments provided\n");
	goto exc_usage;
	
	exc_wrongsize:
	printf("Error: size of width and height should be > 0\n");
	goto exc_usage;
 
	exc_argtoomuch:
	printf("Error: too much arguments\n");
	goto exc_usage;
	
	exc_usage:
	printf("Usage:\n%s <path_to_source_image> <path_to_output_image> <width_out_image> <height_out_image>\n", argv[0]);
	return 1;
	
	exc_resize:
	printf("Error: unexpected error during resizing image");
	goto free_memory;

	exc_malloc:
	printf("Error: could not allocate memory for strings\n");
	goto free_memory;
	
	free_memory:
	free(src_image);
	free(result_image);
	return 1;
}
