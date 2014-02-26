# test2 makefile

all: 	test2
	@echo "test2 has been compiled"

test2: test2.c test2.h RoverCamDefs.h
	gcc -Wall -g -I../../include -I/usr/include/flycapture -std=gnu99 -o test2 test2.c -L../../lib/C -lflycapture-c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`

clean:
	rm -f test2	
	@echo "all cleaned up!"
