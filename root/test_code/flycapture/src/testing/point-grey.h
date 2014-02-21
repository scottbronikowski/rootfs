#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <Imlib2.h>
#include <string.h>
#include <netdb.h>
#include <errno.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/time.h>
#include "C/FlyCapture2_C.h"

#include "RoverCamDefs.h"

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
#define MAX_THREADS 1

#define point_grey_error(...) {				\
    fprintf(stderr, "%s:%d: ", __FUNCTION__, __LINE__);	\
    fprintf(stderr, __VA_ARGS__);			\
    fprintf(stderr, "\n");				\
    exit(-1);						\
  }

#define BARRIER(t1, t2) {					\
    int retval = pthread_barrier_wait(&barrier);                \
    if (retval!=0&&retval!=PTHREAD_BARRIER_SERIAL_THREAD) {     \
      point_grey_error("%s %u can't wait on %s barrier", t1, id, t2); \
    }                                                           \
  }

#ifdef __cplusplus
#define check_point_grey(f) {                                           \
    Error error = f;                                                    \
    if (error!=PGRERROR_OK) {						\
      fprintf(stderr, "%s:%d: Point Grey error\n", __FUNCTION__, __LINE__); \
      error.PrintErrorTrace();                                          \
      abort();                                                          \
    }                                                                   \
  }
#else
#define check_point_grey(f) {						\
    fc2Error error = f;                                                 \
    if (error!=FC2_ERROR_OK) {						\
      fprintf(stderr, "%s:%d: Point Grey error %d\n", __FUNCTION__, __LINE__, error); \
      abort();                                                          \
    }                                                                   \
  }
#endif

/* structures */

struct task_args {
  unsigned int id;
};

struct point_grey {
  fc2Context context;
  fc2PGRGuid guid;
  fc2Image raw_image, converted_image;
};

/* global variables */

extern Imlib_Image raw_frame;
extern unsigned int frame_number, height, width;
extern double fps;
extern pthread_mutex_t halt_mutex;
extern pthread_barrier_t barrier;
extern int running, halt, time_threads;
extern void *((*client_task[MAX_THREADS])(void *));
extern void *((*server_task[MAX_THREADS])(void *));
extern pthread_t thread[MAX_THREADS];
extern struct task_args task_args[MAX_THREADS];
extern unsigned int threads;

/* cpp */

#ifdef __cplusplus
extern "C" {
#endif
void point_grey_set_white_balance(int red, int blue);

/* stuff */

void *point_grey_malloc(size_t size);

double current_time(void);

/* point grey */

unsigned int point_grey_init(void);

struct point_grey *point_grey_setup(int num);

void point_grey_start(struct point_grey *point_grey);

void point_grey_stop(struct point_grey *point_grey);

void point_grey_cleanup(struct point_grey *point_grey);

Imlib_Image point_grey_fetch_frame(struct point_grey *point_grey);

// void *client_camera_task(void *args);

void *server_camera_task(void *args);

#ifdef __cplusplus
}
#endif
