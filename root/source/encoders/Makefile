#makefile for run-encoders

CC = g++
OUTPUTNAME = run-encoders${D}

OPENCV_I = `pkg-config opencv --cflags`
IMLIB_I = `imlib2-config --cflags`
INCLUDE = -I../../include $(OPENCV_I) $(IMLIB_I)
OPENCV_L =  `pkg-config opencv --cflags --libs`
IMLIB_L = `imlib2-config --cflags --libs`
LIBS = -L../../lib -L/usr/local/lib -lpthread -lflycapture${D} $(OPENCV_L) $(IMLIB_L) 
CFLAGS = -D__STDC_CONSTANT_MACROS
OPTFLAGS = -Ofast -march=native -flto -fwhole-program
OUTDIR = ../../bin
CAMDIR = ../camera
CAMFILES = ${CAMDIR}/toollib-camera.cpp ${CAMDIR}/toollib-camera.h
# MOTORDIR = ../motor_control
# MOTORFILES = ${MOTORDIR}/motor_control_functions.cpp ${MOTORDIR}/motor_control.h
# IMUDIR = ../razor-imu
# IMUFILES = ${IMUDIR}/razor-imu.cpp ${IMUDIR}/razor-imu.h
# EMPDIR = ../emperor
# EMPFILES = ${EMPDIR}/emperor.cpp ${EMPDIR}/emperor.h

OBJS =	${CAMDIR}/toollib-camera.o \
	run-encoders.o
#${IMUDIR}/razor-imu.o \
#${EMPDIR}/emperor.o \
# ${MOTORDIR}/motor_control_functions.o \
#${MONDIR}/monitor.o \

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS}
	mv ${OUTPUTNAME} ${OUTDIR}

run-encoders.o: run-encoders.cpp run-encoders.h
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp 

# ${EMPDIR}/emperor.o: ${EMPFILES}
# 	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp 

${CAMDIR}/toollib-camera.o: ${CAMFILES}
	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp -o ${CAMDIR}/toollib-camera.o

# ${MOTORDIR}/motor_control_functions.o: ${MOTORFILES}
# 	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp -o ${MOTORDIR}/motor_control_functions.o

# ${IMUDIR}/razor-imu.o: ${IMUFILES}
# 	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp -o ${IMUDIR}/razor-imu.o

# ${MONDIR}/monitor.o: ${MONFILES}
# 	${CC} ${OPTFLAGS} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

.PHONY: clean

clean:
	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
