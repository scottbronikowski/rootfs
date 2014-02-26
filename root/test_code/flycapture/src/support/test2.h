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
#include <sys/time.h>
#include <Imlib2.h>
#include <string.h>
#include "RoverCamDefs.h"

//defines
//#define OUTPUT_DIR  "/tmp/images/" /*defined in RoverCamDefs.h */
#ifndef TRUE
#define TRUE (0==0)
#endif
#ifndef FALSE
#define FALSE (0!=0)
#endif
#define QUANTUM 1000
#define HEIGHT 480
#define WIDTH 640
#define RED_BALANCE 400
#define BLUE_BALANCE 800


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
  char name[512];
};

//prototypes
void PrintBuildInfo(void);
void PrintCameraInfo(fc2Context context);
int CheckSaving(char *dir);
unsigned int point_grey_init(void);
struct point_grey *point_grey_setup(int num);
void *point_grey_malloc(size_t size);
void point_grey_start(struct point_grey *pg);
void point_grey_stop(struct point_grey *pg);
void point_grey_cleanup(struct point_grey *pg);
void AssignName(fc2Context context, char *name);
Imlib_Image point_grey_get_frame(struct point_grey *pg);
Imlib_Image point_grey_get_frame_with_start_stop(struct point_grey *pg);
void SaveImlibImage(Imlib_Image temp_image, char *name);
double current_time(void);
