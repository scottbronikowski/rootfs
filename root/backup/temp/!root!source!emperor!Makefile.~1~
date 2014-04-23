#makefile for run_cameras

CC = g++
OUTPUTNAME = run_cameras${D}

OPENCV_I = `pkg-config opencv --cflags`
IMLIB_I = `imlib2-config --cflags`
INCLUDE = -I../../include $(OPENCV_I) $(IMLIB_I)
OPENCV_L =  `pkg-config opencv --cflags --libs`
IMLIB_L = `imlib2-config --cflags --libs`
LIBS = -L../../lib -lflycapture${D} -L/usr/local/lib $(OPENCV_L) $(IMLIB_L)
CFLAGS = -D__STDC_CONSTANT_MACROS
OPTFLAGS = -Ofast -march=native -flto -fwhole-program
OUTDIR = ../../bin

OBJS = toollib-camera.o run_cameras.o

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS}
	mv ${OUTPUTNAME} ${OUTDIR}

run_cameras.o: run_cameras.cpp
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

toollib-camera.o: toollib-camera.cpp toollib-camera.h
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

.PHONY: clean

clean:
	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
