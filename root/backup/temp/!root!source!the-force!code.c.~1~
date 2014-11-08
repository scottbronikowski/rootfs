// gcc -o code code.c -std=gnu99 -lpthread

#include "code.h"

unsigned int frame_number;
int running = FALSE, halt = FALSE;
unsigned int threads = MAX_THREADS;
void *((*task[MAX_THREADS])(void *)) = {&TASK_task, &TASK_task};
pthread_t thread[MAX_THREADS];
struct task_args task_args[MAX_THREADS];
pthread_mutex_t halt_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_barrier_t barrier;
int time_threads = FALSE;
double fps;

void *task_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) task_error("Out of memory");
  return p;
}

double current_time(void) {
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) task_error("gettimeofday failed");
  /* needs work: Will it convert division into multiplication? */
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

void initialize_TASK(unsigned int id) {
}

// Tasks communicate through global variables.
// Each global variable is written by at most one task.
// It can be read by multiple tasks.
// Task only write their own global variables in write_TASK().
// No other task can read other task's global variables in write_TASK().
// They can only read variables in read_TASK().

void write_TASK(unsigned int id) {
}

void read_TASK(unsigned int id) {
}

void finalize_TASK(unsigned int id) {
}

void *TASK_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  {
    /* This block only needs to be in one three */
    frame_number = 0;
  }
  initialize_TASK(id);
  BARRIER("TASK", "initialize");
  while (TRUE) {
    {
      /* This block only needs to be in one three */
      pthread_mutex_lock(&halt_mutex);
      if (halt) running = FALSE;
      pthread_mutex_unlock(&halt_mutex);
    }
    BARRIER("TASK", "before pipeline");
    if (!running) break;
    write_TASK(id);
    BARRIER("TASK", "after pipeline");
    double last = current_time();
    read_TASK(id);
    double now = current_time();
    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("TASK %u can't keep up in frame %u, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused TASK %u thread time in frame %u: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }
  BARRIER("TASK", "finalize");
  finalize_TASK(id);
  return NULL;
}

void start_threads(void) {
  if (running) task_error("threads already running");
  if (pthread_barrier_init(&barrier, NULL, threads)) {
    task_error("Can't create a barrier");
  }
  running = TRUE;
  for (unsigned int id = 0; id<threads; id++) task_args[id].id = id;
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setstacksize(&attributes, 10*1024*1024); /* hardwired 10MB */
  for (unsigned int id = 0; id<threads; id++) {
    if (pthread_create(&thread[id], &attributes, task[id],
		       (void *)&task_args[id])) {
      task_error("Can't start thread %u", id);
    }
  }
  pthread_attr_destroy(&attributes);
}

void stop_threads(void) {
  /* needs work: Technically, can't access running here without a mutex. */
  if (running&&!halt) {
    pthread_mutex_lock(&halt_mutex);
    halt = TRUE;
    pthread_mutex_unlock(&halt_mutex);
    for (unsigned int id = 0; id<threads; id++) {
      if (pthread_join(thread[id], NULL)!=0) {
	task_error("Can't join thread %u", id);
      }
    }
    pthread_barrier_destroy(&barrier);
    halt = FALSE;
  }
}

int main(void) {
  start_threads();
  usleep(30*1000*1000);
  stop_threads();
}
