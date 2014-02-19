# test-capture makefile
# To compile the debug verison need to overwrite CXXFLAGS variable to include -ggdb (??????)

CC = gcc
OUTPUTNAME = test-capture
INCLUDE = -I../../include -I/usr/include/flycapture
LIBS = -L../../lib -lflycapture${D} -L../../lib/C -lflycapture-c${D} -pthread `imlib2-config --cflags --libs` /usr/lib/libflycapture*
CFLAGS = -Wall -g
NOLINK = -c
STD = -std=gnu99

#OUTDIR = ../../bin

OBJS = point-grey-cpp.o point-grey.o test-capture-c.o

all: 	$(OUTPUTNAME)
	@echo "test-capture has been compiled"

${OUTPUTNAME}: ${OBJS}
	${CC} ${CFLAGS} ${INCLUDE} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS} 
#	mv ${OUTPUTNAME} ${OUTDIR}

test-capture-c.o: test-capture-c.c point-grey.o point-grey-cpp.o point-grey.h
	${CC} ${CFLAGS} ${NOLINK} ${INCLUDE} ${STD} test-capture-c.c point-grey.o point-grey-cpp.o ${LIBS}

point-grey.o: point-grey.c point-grey-cpp.o point-grey.h
	${CC} ${CFLAGS} ${NOLINK} ${INCLUDE} ${STD} point-grey.c point-grey-cpp.o ${LIBS}

point-grey-cpp.o: point-grey-cpp.cpp point-grey.h
	g++ ${CFLAGS} ${NOLINK} ${INCLUDE} point-grey-cpp.cpp ${LIBS}

clean_obj:
	rm -f ${OBJS}	@echo "all cleaned up!"

clean:
#	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
	rm -f ${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
