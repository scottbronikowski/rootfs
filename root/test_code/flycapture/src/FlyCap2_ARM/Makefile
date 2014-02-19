# A more complex Makefile

ifeq ($(PLATFORM),arm)
	CC = /work/netcdrom/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi-g++
else
	CC = g++
endif

ifeq ($(PLATFORM),arm)
	STRIP = /work/netcdrom/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi-strip
else
	STRIP = strip
endif

GCHNAME = Precompiled.h.gch
#GCH_INCLUDES = `pkg-config --cflags gtkmm-2.4` `pkg-config --cflags libglademm-2.4` `pkg-config --cflags giomm-2.4`

GCH_INCLUDES = -I../../include -I/usr/include/flycapture `pkg-config --cflags gtkmm-2.4` `pkg-config --cflags giomm-2.4` `pkg-config --cflags libglademm-2.4` 

INCLUDE = -I../../include ${GCH_INCLUDES} #-I/usr/include/flycapture 

#LIBS = -L../../lib -lflycapture${D} -lflycapturegui${D} -lpthread `pkg-config --libs gthread-2.0` `pkg-config --libs giomm-2.4` `pkg-config gtkmm-2.4 --libs` `pkg-config libglademm-2.4 --libs`
LIBS = -L../../lib -lflycapture${D} -lflycapturegui${D} `pkg-config --libs gtkmm-2.4` `pkg-config --libs giomm-2.4` `pkg-config --libs libglademm-2.4` `pkg-config --libs gthread-2.0`

NAME = FlyCap2${D}

XMLNAME = FlyCap2

OUTDIR = ../../bin

OBJS = main.o FlycapWindow.o FrameRateCounter.o ImageDrawingArea.o InformationPane.o HistogramWindow.o HistogramDrawingArea.o SaveImageFileChooserDialog.o

all: ${GCHNAME} ${NAME} glade

${GCHNAME}: Precompiled.h
	${CC} ${CFLAGS} ${GCH_INCLUDES} -Wall -c Precompiled.h

${NAME}: ${OBJS}
	${CC} -Wall -o ${NAME} ${OBJS} ${LIBS} -export-dynamic
ifneq (${D}, d)
	${STRIP} --strip-unneeded ${NAME}
endif
	mv ${NAME} ${OUTDIR}/${NAME}

%.o: %.cpp
	${CC} ${CFLAGS} ${INCLUDE} -Wall -c $*.cpp 

glade:
	cp ${XMLNAME}.glade ${OUTDIR}/${XMLNAME}.glade

clean_obj:
	rm -f ${OBJS} Precompiled.h.gch

clean:
	rm -f ${OUTDIR}/${NAME} ${OBJS} Precompiled.h.gch
