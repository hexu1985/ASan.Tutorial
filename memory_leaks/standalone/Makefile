
RM = rm -f
CC = gcc
CFLAGS = -Wall -g -fsanitize=leak -fno-omit-frame-pointer
INCLUDES = 
LDFLAGS = -lasan 
LDPATH =

SOURCES = $(shell ls *.c)
PROGS = $(subst .c,,$(SOURCES))
#PROGS = $(SOURCES:%.c=%)

all: $(PROGS)
	@echo "PROGS = $(PROGS)" 

clean:
	$(RM) $(PROGS) *.o

:%.c
	$(CC) -o $@ $(CFLAGS) $(INCLUDE) $^ $(LDFLAGS) $(LDPATH)
