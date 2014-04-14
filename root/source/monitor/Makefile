#makefile for monitor (bump switches)

CC = g++
INCLUDE = -I../../include 
OPTFLAGS = -Ofast -march=native -flto -fwhole-program
MOTORDIR = ../motor_control/
OUTDIR = ../../bin

all: monitor

monitor: monitor.o motor_control_functions.o
	$(CC) -o monitor monitor.o motor_control_functions.o
	mv monitor $(OUTDIR)

monitor.o: monitor.cpp monitor.h
	$(CC) $(OPTFLAGS) $(INCLUDE) -Wall -c monitor.cpp

motor_control_functions.o: $(MOTORDIR)motor_control_functions.cpp $(MOTORDIR)motor_control.h
	$(CC) $(OPTFLAGS) $(INCLUDE) -Wall -c $(MOTORDIR)motor_control_functions.cpp

.PHONY: clean

clean:
	rm -f monitor monitor.o motor_control_functions.o
	@echo "cleanup complete"




