#makefile for emperor

CC = g++
OUTPUTNAME = emperor${D}

OPENCV_I = `pkg-config opencv --cflags`
IMLIB_I = `imlib2-config --cflags`
INCLUDE = -I../../include $(OPENCV_I) $(IMLIB_I)
OPENCV_L =  `pkg-config opencv --cflags --libs`
IMLIB_L = `imlib2-config --cflags --libs`
LIBS = -L../../lib -lflycapture${D} -L/usr/local/lib $(OPENCV_L) $(IMLIB_L)
CFLAGS = -D__STDC_CONSTANT_MACROS
OPTFLAGS = -Ofast -march=native -flto -fwhole-program
OUTDIR = ../../bin
CAMDIR = ../camera
CAMFILES = ${CAMDIR}/toollib-camera.cpp ${CAMDIR}/toollib-camera.h
MOTORDIR = ../motor_control
MOTORFILES = ${MOTORDIR}/motor_control_functions.cpp ${MOTORDIR}/motor_control.h
MONDIR = ../monitor
MONFILES = ${MONDIR}/monitor.cpp ${MONDIR}/monitor.h

OBJS = ${CAMDIR}/toollib-camera.o \
       ${MOTORDIR}/motor_control_functions.o \
       emperor.o
	#${MONDIR}/monitor.o \

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS}
	mv ${OUTPUTNAME} ${OUTDIR}

emperor.o: emperor.cpp emperor.h
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

${CAMDIR}/toollib-camera.o: ${CAMFILES}
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

${MOTORDIR}/motor_control_functions.o: ${MOTORFILES}
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

# ${MONDIR}/monitor.o: ${MONFILES}
# 	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

.PHONY: clean

clean:
	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
