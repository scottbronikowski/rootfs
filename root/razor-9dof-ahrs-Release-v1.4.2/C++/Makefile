# makefile for example
CC = g++
OUTPUTNAME = example${D}

LIBS = -L/usr/local/lib -lpthread
CFLAGS = -D__STDC_CONSTANT_MACROS -D_REENTRANT
OPTFLAGS = -Ofast -march=native -flto -fwhole-program

OBJS = 	RazorAHRS.o \
	Example.o

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS}

Example.o: Example.cpp
	${CC} ${OPTFLAGS} ${CFLAGS} -Wall -c $*.cpp 

RazorAHRS.o: RazorAHRS.cpp RazorAHRS.h
	${CC} ${OPTFLAGS} ${CFLAGS} -Wall -c $*.cpp 

.PHONY: clean

clean:
	rm -f ${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
