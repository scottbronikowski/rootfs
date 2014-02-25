//second set of test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 25 February 2013

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include "C/FlyCapture2_C.h"
#include <sys/stat.h>
#include <Imlib2.h>
#include "RoverCamDefs.h"

//defines
//#define OUTPUT_DIR  "/tmp/images/" /*defined in RoverCamDefs.h */

//macros
#define check_point_grey(f) {						\
    fc2Error error = f;                                                 \
    if (error!=FC2_ERROR_OK) {						\
      fprintf(stderr, "%s:%d: Point Grey error %d\n", __FUNCTION__, __LINE__, error); \
      abort();                                                          \
    }                                                                   \
  }

#define point_grey_error(...) {				\
    fprintf(stderr, "%s:%d: ", __FUNCTION__, __LINE__);	\
    fprintf(stderr, __VA_ARGS__);			\
    fprintf(stderr, "\n");				\
    exit(-1);						\
  }


//structures
struct point_grey {
  fc2Context context;
  fc2PGRGuid guid;
  fc2Image raw_image, converted_image;
  char *name;
};

//prototypes
void PrintCameraInfo(fc2Context context);
int CheckSaving(char *dir);
struct point_grey *point_grey_setup(int num);
void *point_grey_malloc(size_t size);

void point_grey_stop_and_cleanup(struct point_grey *pg);
void AssignName(fc2Context context, char *name);
