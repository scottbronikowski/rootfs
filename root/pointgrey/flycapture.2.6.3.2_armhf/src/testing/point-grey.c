// darpa-wrap gcc -Wall -I${HOME}/darpa-collaboration/include/`architecture-path`/flycapture -o point-grey -std=gnu99 point-grey.c point-grey-cpp.o `imlib2-config --cflags --libs` -pthread ~/darpa-collaboration/lib/`architecture-path`/libflycapture*

#include "point-grey.h"

/* global variables */

Imlib_Image raw_frame;
unsigned int frame_number, height, width;
double fps;
pthread_mutex_t halt_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_barrier_t barrier;
int running = FALSE, halt = FALSE, time_threads = FALSE;
/* needs work: initializer assumes MAX_THREADS==1 */
void *((*client_task[MAX_THREADS])(void *)) = {&client_camera_task};
/* needs work: initializer assumes MAX_THREADS==1 */
void *((*server_task[MAX_THREADS])(void *)) = {&server_camera_task};
pthread_t thread[MAX_THREADS];
struct task_args task_args[MAX_THREADS];
unsigned int threads = MAX_THREADS;

/* stuff */

void *point_grey_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) point_grey_error("Out of memory");
  return p;
}

double current_time(void) {
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) point_grey_error("gettimeofday failed");
  /* needs work: Will it convert division into multiplication? */
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

/* point grey */

struct point_grey *point_grey_setup(void) {
  point_grey_set_white_balance(RED_BALANCE, BLUE_BALANCE);
  struct point_grey *point_grey =
    (struct point_grey *)point_grey_malloc(sizeof(struct point_grey));
  check_point_grey(fc2CreateContext(&point_grey->context));
  unsigned int nr_of_cameras;
  check_point_grey(fc2GetNumOfCameras(point_grey->context, &nr_of_cameras));
  if (!nr_of_cameras) point_grey_error("No Point Grey cameras");
  check_point_grey(fc2GetCameraFromIndex(point_grey->context,
					 0,
					 &point_grey->guid));
  check_point_grey(fc2Connect(point_grey->context, &point_grey->guid));
  /* hardwired
     see fc2ColorProcessingAlgorithm for different algorithms,
     compromise between speed and quality */
  check_point_grey(fc2SetDefaultColorProcessing(FC2_IPP));
  /* hardwired
     FC2_VIDEOMODE_640x480Y8 or FC2_VIDEOMODE_1280x960Y8 */
  /* FC2_FRAMERATE_15 or FC2_FRAMERATE_30 */
  check_point_grey(fc2SetVideoModeAndFrameRate(point_grey->context,
					       FC2_VIDEOMODE_1280x960Y8,
					       FC2_FRAMERATE_15));
  check_point_grey(fc2CreateImage(&point_grey->raw_image));
  check_point_grey(fc2CreateImage(&point_grey->converted_image));
  return point_grey;
}

void point_grey_start(struct point_grey *point_grey) {
  for (unsigned int retries = 0; retries<100; retries++) {
    int result = fc2StartCapture(point_grey->context);
    switch (result) {
    case 0:
      if (retries!=0)
        fprintf(stderr, "Point Grey error 33 happened %u times\n", retries);
      return;
    case FC2_ERROR_ISOCH_START_FAILED:    /* error 33 */
      if (usleep(100000)) point_grey_error("Call to usleep failed"); /* 0.1s */
      break;
    default:
      point_grey_error("Unhandled error starting Point Grey camera %d", result);
    }
  }
  point_grey_error("Too many retries starting Point Grey");
}

void point_grey_stop(struct point_grey *point_grey) {
  check_point_grey(fc2StopCapture(point_grey->context));
}

void point_grey_cleanup(struct point_grey *point_grey) {
  check_point_grey(fc2DestroyContext(point_grey->context));
  check_point_grey(fc2DestroyImage(&point_grey->raw_image));
  check_point_grey(fc2DestroyImage(&point_grey->converted_image));
  free(point_grey);
}

Imlib_Image point_grey_fetch_frame(struct point_grey *point_grey) {
  check_point_grey(fc2RetrieveBuffer(point_grey->context,
                                     &point_grey->raw_image));
  check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,
                                     &point_grey->raw_image,
				     &point_grey->converted_image));
  return
    imlib_create_image_using_copied_data(point_grey->converted_image.cols,
                                         point_grey->converted_image.rows,
                                         (unsigned int *)
                                         point_grey->converted_image.pData);
}

void *client_camera_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  char *hostname = "upplysingaoflun.ecn.purdue.edu";
  short int port = 3600;
  int sock;
  struct sockaddr_in address;
  struct in_addr inaddr;
  struct hostent *host;
  int retval, retries = 1000;
  if (inet_aton(hostname, &inaddr)) {
    host = gethostbyaddr((char *)&inaddr, sizeof(inaddr), AF_INET);
  }
  else host = gethostbyname(hostname);
  if (!host) point_grey_error("error looking up host");
 l:
  if ((sock = socket(PF_INET, SOCK_STREAM, 0))<0) {
    point_grey_error("Call to socket failed");
  }
  address.sin_family = AF_INET;
  address.sin_port = htons(port);
  /* needs work: should we use sizeof(address.sin_addr) or host->h_length */
  /* needs work: should we cast the first arg to (char *) */
  memcpy(&address.sin_addr, host->h_addr_list[0], sizeof(address.sin_addr));
  while ((retval = connect(sock,
			   (struct sockaddr *)&address,
			   sizeof(address)))<0&&
	 errno==EINTR);
  if (retval<0) {
    if (errno==ECONNREFUSED&&retries>0) {
      if (usleep(QUANTUM)) point_grey_error("Call to usleep failed");
      retries--;
      if (close(sock)) point_grey_error("Call to close failed");
      goto l;
    }
    point_grey_error("Call to connect failed");
  }
  /* start frame source */
  frame_number = 0;
  struct point_grey *point_grey = point_grey_setup();
  point_grey_start(point_grey);
  /* This ignores the first frame, just for camera, not for video, just to get
     the height and width to preallocate storage and let the camera start up.
  */
  Imlib_Image first_frame = point_grey_fetch_frame(point_grey);
  imlib_context_set_image(first_frame);
  imlib_free_image_and_decache();
  if (usleep((int)floor(1000000.0/fps))!=0) point_grey_error("usleep failed");
  height = HEIGHT;
  width = WIDTH;
  BARRIER("camera", "initialize");
  double last = current_time();
  /* per-frame loop */
  while (TRUE) {
    /* Check for signal from GUI. */
    pthread_mutex_lock(&halt_mutex);
    if (halt) running = FALSE;
    pthread_mutex_unlock(&halt_mutex);
    if (running) {
      /* get frame */
      if (raw_frame!=NULL) {
	imlib_context_set_image(raw_frame);
	// dynamic allocation
	imlib_free_image_and_decache();
      }
      Imlib_Image big_frame = point_grey_fetch_frame(point_grey);
      imlib_context_set_image(big_frame);
      raw_frame =
	imlib_create_cropped_scaled_image(0, 0,
					  imlib_image_get_width(),
					  imlib_image_get_height(),
					  WIDTH, HEIGHT);
      imlib_free_image_and_decache();
      /* send frame to server */
      imlib_context_set_image(raw_frame);
      size_t count = height*width*4;
      unsigned char *frame =
	(unsigned char *)imlib_image_get_data_for_reading_only();
      while (count>0) {
	ssize_t retval = write(sock, frame, count);
	if (retval<=0) point_grey_error("Call to write failed");
	count -= retval;
	frame += retval;
      }
    }
    BARRIER("camera", "before pipeline");
    frame_number++;
    if (!running) break;
    BARRIER("camera", "after pipeline");
    /* spin to sync to frame rate */
    double now = current_time();
    if (now-last>=1.0/fps) {
      fprintf(stderr,
	      "client camera can't keep up in frame %u, overused: %lf\n",
	      frame_number, fps*(now-last)-1.0);
    }
    else if (time_threads) {
      printf("unused client camera thread time in frame %u: %lf\n",
	     frame_number, 1.0-fps*(now-last));
    }
    while (TRUE) {
      double now = current_time();
      if (now-last>=1.0/fps) {
	last = now;
	break;
      }
      if (usleep(QUANTUM)) point_grey_error("Call to usleep failed");
    }
  }
  BARRIER("camera", "finalize");
  /* free resources */
  point_grey_stop(point_grey);
  point_grey_cleanup(point_grey);
  if (close(sock)) point_grey_error("Call to close failed");
  return NULL;
}

void *server_camera_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  short int port = 3600;
  int optval = 1;
  int sock, conn;
  struct sockaddr_in address;
  socklen_t addrlength = sizeof(address);
  if ((sock = socket(PF_INET, SOCK_STREAM, 0))<0) {
    point_grey_error("Call to socket failed");
  }
  setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval));
  address.sin_family = AF_INET;
  /* needs work: should we cast the first arg to (char *) */
  memset(&address.sin_addr, 0, sizeof(address.sin_addr));
  address.sin_addr.s_addr = INADDR_ANY;
  address.sin_port = htons(port);
  if (bind(sock, (struct sockaddr *)&address, sizeof(address))) {
    point_grey_error("Call to bind failed");
  }
  if (listen(sock, 5)) point_grey_error("Call to listen failed");
  while ((conn = accept(sock, (struct sockaddr *)&address, &addrlength))<0&&
         errno==EINTR);
  if (conn<0) point_grey_error("Call to accept failed");
  /* needs work: should get from client */
  height = HEIGHT;
  width = WIDTH;
  /* start frame source */
  frame_number = 0;
  BARRIER("camera", "initialize");
  double last = current_time();
  /* per-frame loop */
  while (TRUE) {
    /* Check for signal from GUI. */
    pthread_mutex_lock(&halt_mutex);
    if (halt) running = FALSE;
    pthread_mutex_unlock(&halt_mutex);
    /* get frame */
    if (raw_frame!=NULL) {
      imlib_context_set_image(raw_frame);
      // dynamic allocation
      imlib_free_image_and_decache();
    }
    // dynamic allocation
    raw_frame = imlib_create_image(width, height);
    imlib_context_set_image(raw_frame);
    unsigned char *data = (unsigned char *)imlib_image_get_data();
    unsigned char *frame = data;
    size_t count = height*width*4;
    while (count>0) {
      ssize_t retval = read(conn, frame, count);
      if (retval==-1) point_grey_error("Call to read failed");
      if (retval==0) {
	running = FALSE;
	break;
      }
      count -= retval;
      frame += retval;
    }
    imlib_image_put_back_data((DATA32 *)data);
    /* wait until threads idle as late as possible before pipelining to
       give them as much time as possible to finish
       we used to report here which tasks were not done */
    BARRIER("camera", "before pipeline");
    if (!running) break;
    /* increment frame number while threads are idle since they access it;
       we have a bug if it overflows */
    frame_number++;
    /* start up hog threads as soon as possible after pipelining to give them
       as much time as possible to finish */
    BARRIER("camera", "after pipeline");
    /* spin to sync to frame rate */
    double now = current_time();
    if (now-last>=1.0/fps) {
      fprintf(stderr,
	      "camera can't keep up in frame %u, overused: %lf\n",
	      frame_number, fps*(now-last)-1.0);
    }
    else if (time_threads) {
      printf("unused camera thread time in frame %u: %lf\n",
	     frame_number, 1.0-fps*(now-last));
    }
    while (TRUE) {
      double now = current_time();
      if (now-last>=1.0/fps) {
	last = now;
	break;
      }
      if (usleep(QUANTUM)) point_grey_error("Call to usleep failed");
    }
  }
  BARRIER("camera", "finalize");
  if (close(conn)) point_grey_error("Call to close failed");
  if (close(sock)) point_grey_error("Call to close failed");
  return NULL;
}

void start_client_threads(void) {
  /* Wait for server to start. */
  if (usleep(1000000)) point_grey_error("Call to usleep failed");
  if (running) point_grey_error("threads already running");
  if (pthread_barrier_init(&barrier, NULL, threads)) {
    point_grey_error("Can't create a barrier");
  }
  running = TRUE;
  for (unsigned int id = 0; id<threads; id++) {
    if (client_task[id]!=&client_camera_task) {
      task_args[id].id = id;
    }
  }
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setstacksize(&attributes, 10*1024*1024); /* hardwired 10MB */
  for (unsigned int id = 0; id<threads; id++) {
    if (pthread_create(&thread[id], &attributes, client_task[id],
		       (void *)&task_args[id])) {
      point_grey_error("Can't start thread %u", id);
    }
  }
  pthread_attr_destroy(&attributes);
}

void start_server_threads(void) {
  if (running) point_grey_error("threads already running");
  if (pthread_barrier_init(&barrier, NULL, threads)) {
    point_grey_error("Can't create a barrier");
  }
  running = TRUE;
  for (unsigned int id = 0; id<threads; id++) {
    if (server_task[id]!=&server_camera_task) {
      task_args[id].id = id;
    }
  }
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setstacksize(&attributes, 10*1024*1024); /* hardwired 10MB */
  for (unsigned int id = 0; id<threads; id++) {
    if (pthread_create(&thread[id], &attributes, server_task[id],
		       (void *)&task_args[id])) {
      point_grey_error("Can't start thread %u", id);
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
	point_grey_error("Can't join thread %u", id);
      }
    }
    pthread_barrier_destroy(&barrier);
    halt = FALSE;
  }
}

int main(void) {
  return EXIT_SUCCESS;
}
