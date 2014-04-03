# CustomImageEx makefile

CC = g++
OUTPUTNAME = CustomImageEx${D}
INCLUDE = -I../../include -I/usr/include/flycapture -I/root/jpeg-compressor
LIBS = -L../../lib -lflycapture${D} `imlib2-config --cflags --libs` `pkg-config opencv --cflags --libs` -L/usr/local/lib -lsnappy
CFLAGS = -D__STDC_CONSTANT_MACROS

OUTDIR = ../../bin

OBJS = CustomImageEx.o jpge.o

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS}
	mv ${OUTPUTNAME} ${OUTDIR}

%.o: %.cpp
	${CC} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp

clean_obj:
	rm -f ${OBJS}	@echo "all cleaned up!"

clean:
	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
