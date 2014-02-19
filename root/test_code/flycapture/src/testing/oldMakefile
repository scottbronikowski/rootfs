# testcapture makefile
# To compile the debug verison need to overwrite CXXFLAGS variable to include -ggdb (??????)

CC = g++
OUTPUTNAME = testcapture${D}
INCLUDE = -I../../include -I/usr/include/flycapture
LIBS = -L../../lib -lflycapture${D} 

OUTDIR = ../../bin

OBJS = testcapture.o

${OUTPUTNAME}: ${OBJS}
	${CC} -o ${OUTPUTNAME} ${OBJS} ${LIBS} ${COMMON_LIBS} 
	mv ${OUTPUTNAME} ${OUTDIR}

%.o: %.cc
	${CC} ${CFLAGS} ${INCLUDE} -c $*.cc

clean_obj:
	rm -f ${OBJS}	@echo "all cleaned up!"

clean:
	rm -f ${OUTDIR}/${OUTPUTNAME} ${OBJS}	@echo "all cleaned up!"
