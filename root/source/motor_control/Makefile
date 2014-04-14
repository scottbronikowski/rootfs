#makefile for motor control

CC = g++
INCLUDE = -I../../include 
OPTFLAGS = -Ofast -march=native -flto -fwhole-program
#MOTORDIR = ../motor_control/
OUTDIR = ../../bin

all: motor_control

motor_control: motor_control.o motor_control_functions.o
	$(CC) -o motor_control motor_control.o motor_control_functions.o
	mv motor_control $(OUTDIR)

motor_control.o: motor_control.cpp motor_control.h
	$(CC) $(OPTFLAGS) $(INCLUDE) -Wall -c motor_control.cpp


motor_control_functions.o: motor_control_functions.cpp motor_control.h
	$(CC) $(OPTFLAGS) $(INCLUDE) -Wall -c motor_control_functions.cpp

.PHONY: clean

clean:
	rm -f motor_control motor_control.o motor_control_functions.o
	@echo "cleanup complete"




