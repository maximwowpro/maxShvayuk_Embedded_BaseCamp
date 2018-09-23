TARGET=resize_image_make
SOURCE=resize_image

CC=gcc
CFLAGS=-O2 -save-temps `GraphicsMagickWand-config --cppflags --ldflags --libs`

.PHONY: all clean

all:	$(TARGET)

$(TARGET):
	@echo Compiling the program...
	@rm -rf tmp_files
	@mkdir tmp_files
	$(CC) -o $(TARGET) $(addsuffix .c, $(SOURCE)) $(CFLAGS)
	@cp ./*.i tmp_files
	@cp ./*.s tmp_files
	@cp ./*.o tmp_files
	@rm -f *.s *.i *.o

clean:
	@echo Tidying things up...
	-rm -f $(TARGET) *.s *.i *.o
	-rm -rf tmp_files


