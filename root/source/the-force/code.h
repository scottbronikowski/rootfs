#include <pthread.h>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef TRUE
#define TRUE (0==0)
#endif
#ifndef FALSE
#define FALSE (0!=0)
#endif

#define MAX_THREADS 2

#define task_error(...) {				\
    fprintf(stderr, "%s:%d: ", __FUNCTION__, __LINE__);	\
    fprintf(stderr, __VA_ARGS__);			\
    fprintf(stderr, "\n");				\
    exit(EXIT_FAILURE); 				\
  }

#define BARRIER(t1, t2) {					\
    int retval = pthread_barrier_wait(&barrier);                \
    if (retval!=0&&retval!=PTHREAD_BARRIER_SERIAL_THREAD) {     \
      task_error("%s %u can't wait on %s barrier", t1, id, t2); \
    }                                                           \
  }

struct task_args {
  unsigned int id;
};

extern unsigned int frame_number;
extern int running, halt;
extern unsigned int threads;
extern void *((*task[MAX_THREADS])(void *));
extern pthread_t thread[MAX_THREADS];
extern struct task_args task_args[MAX_THREADS];
extern pthread_mutex_t halt_mutex;
extern pthread_barrier_t barrier;
extern int time_threads;
extern double fps;

void *task_malloc(size_t size);
double current_time(void);
void initialize_TASK(unsigned int id);
void write_TASK(unsigned int id);
void read_TASK(unsigned int id);
void finalize_TASK(unsigned int id);
void *TASK_task(void *args);
void start_threads(void);
void stop_threads(void);
