TARGET=resize_image_make
SOURCE=resize_image.c

CC=gcc
CFLAGS=-O2 `GraphicsMagickWand-config --cppflags --ldflags --libs`

.PHONY: all clean

all:	$(TARGET)

$(TARGET):
	@echo Compiling the program...
	$(CC) -o $(TARGET) $(SOURCE) $(CFLAGS)

clean:
	@echo Tidying things up...
	-rm -f $(TARGET)


