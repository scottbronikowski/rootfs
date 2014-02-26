# test-capture makefile
# To compile the debug verison need to overwrite CXXFLAGS variable to include -ggdb (??????)

CC = gcc
C++C = g++
OUTPUTNAME1 = c-test-capture
OUTPUTNAME2 = cpp-test-capture
INCLUDE = -I../../include -I/usr/include/flycapture
LIBS = -L../../lib -lflycapture${D} -L../../lib/C -lflycapture-c${D} -pthread `imlib2-config --cflags --libs` /usr/lib/libflycapture*
CFLAGS = -Wall -g
NOLINK = -c
STD = -std=gnu99

#OUTDIR = ../../bin

OBJS1 = point-grey-cpp.o point-grey.o test-capture-c.o
OBJS2 = point-grey-cpp.o point-grey.o test-capture-cpp.o

all: 	$(OUTPUTNAME1) $(OUTPUTNAME2) test test2
	@echo "{c-,cpp-}test-capture, test test2 have been compiled"

${OUTPUTNAME1}: ${OBJS1}
	${CC} ${CFLAGS} ${INCLUDE} -o ${OUTPUTNAME1} ${OBJS1} ${LIBS} ${COMMON_LIBS} 
#	mv ${OUTPUTNAME} ${OUTDIR}

${OUTPUTNAME2}: ${OBJS2}
	${C++C} ${CFLAGS} ${INCLUDE} -o ${OUTPUTNAME2} ${OBJS2} ${LIBS} ${COMMON_LIBS}

test-capture-cpp.o: test-capture-cpp.cpp point-grey.o point-grey-cpp.o point-grey.h RoverCamDefs.h
	${C++C} ${CFLAGS} ${NOLINK} ${INCLUDE} test-capture-cpp.cpp #point-grey.o point-grey-cpp.o ${LIBS}

test-capture-c.o: test-capture-c.c point-grey.o point-grey-cpp.o point-grey.h RoverCamDefs.h
	${CC} ${CFLAGS} ${NOLINK} ${INCLUDE} ${STD} test-capture-c.c #point-grey.o point-grey-cpp.o ${LIBS}

point-grey.o: point-grey.c point-grey-cpp.o point-grey.h
	${CC} ${CFLAGS} ${NOLINK} ${INCLUDE} ${STD} point-grey.c #point-grey-cpp.o ${LIBS}

point-grey-cpp.o: point-grey-cpp.cpp point-grey.h
	${C++C} ${CFLAGS} ${NOLINK} ${INCLUDE} point-grey-cpp.cpp #${LIBS}

clean_obj:
	rm -f ${OBJS1} ${OBJS2}	@echo "objects all cleaned up!"

test: test.c
	gcc -Wall -g -I../../include -I/usr/include/flycapture ${STD} -o test test.c -L../../lib/C -lflycapture-c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`

test2: test2.c test2.h RoverCamDefs.h
	gcc -Wall -g -I../../include -I/usr/include/flycapture ${STD} -o test2 test2.c -L../../lib/C -lflycapture-c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`

clean:
#	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
	rm -f ${OUTPUTNAME1} ${OBJS1} ${OUTPUTNAME2} ${OBJS2} test test2	@echo "all cleaned up!"
