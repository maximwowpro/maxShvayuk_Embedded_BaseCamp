TARGET=main
DEPS=matrix.h matrix.c
#DEPS:=$(addsuffix .o, $(DEPS))

CC=gcc
CFLAGS=-O2 -Wall -Wextra -Wpedantic -lpthread -lm

.PHONY: all clean

all:	$(TARGET)

$(TARGET): $(DEPS)
	clear
	clear
	$(CC) $(CFLAGS) $(addsuffix .c, $(TARGET)) $(DEPS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	@echo Tidying things up...
	-rm -f $(TARGET)

	


