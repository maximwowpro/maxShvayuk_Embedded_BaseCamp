TARGET=linked_list_demonstration
DEPS=linked_list
DEPS:=$(addsuffix .o, $(DEPS))

CC=gcc
CFLAGS=-O2 -Wall -Wextra -Wpedantic 

.PHONY: all clean

all:	$(TARGET)

$(TARGET): $(DEPS)
	$(CC) $(CFLAGS) $(addsuffix .c, $(TARGET)) $(DEPS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $<

clean:
	@echo Tidying things up...
	-rm -f $(TARGET)
	-rm -f $(DEPS)
	-rm -f *.o $(TARGET)

	


