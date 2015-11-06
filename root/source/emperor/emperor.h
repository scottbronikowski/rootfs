/*

  Header for main control program to run vader-rover for MANUAL driving.

  **THIS IS BUILT FROM A MERGE OF THE-FORCE AND EMPEROR-BEFORE-BARRIERS**

  Started with a merge of the old emperor and run-sensors programs, along with Dan's code in log_to_track.cpp to do Kalman filter position finding from sensor data.
  Then removed code dealing with listening for commands from game controller.
  Replaced that section with code that listens for a trace (series of waypoints) and drives to those waypoints automatically.

  Author: Scott Bronikowski
  Date: 16 October 2014

  Edited beginning on 28 October 2015 to add a second barrier to control the camera thread and ensure that this thread executes at exactly 10 Hz while the other threads execute at 50 Hz.

  CONVERTED starting 5 Nov 15 to put manual driving back in while keeping most other stuff the same.
*/

#ifndef EMPEROR_H
#define EMPEROR_H

//(from emperor)
#include "toollib-camera.h"
#include "motor_control.h"
#include "razor-imu.h"
#include <csignal>
#include <pthread.h>
//(from run-sensors)
#include <string>
#include <memory>
#include <tr1/functional>
#include <stdexcept>
#include <sstream>
#include <unistd.h>  
#include <termios.h> 
#include <fcntl.h>   
#include <errno.h>
#include <stdio.h>
#include <sys/time.h>
#include <cstring>
#include <sys/types.h>
#include "mNMEAParser.h"
//needed for Kalman filter
#include <opencv2/video/tracking.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <stdlib.h>

using namespace cv;

//defines
#define NEGATIVE_INFINITY (-1.0/0.0) //for my_exp
#ifndef TRUE
#define TRUE (0==0)
#endif
#ifndef FALSE
#define FALSE (0!=0)
#endif

#define MAX_THREADS 6//5 //changed to 6 b/c of bump switch thread 
//total number of barrier-ed threads (not including camera)

#define QUANTUM 1000

//macros
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

#define BARRIER2(t1, t2) {					\
    int retval = pthread_barrier_wait(&barrier2);            \
    if (retval!=0&&retval!=PTHREAD_BARRIER_SERIAL_THREAD) {     \
      task_error("%s %u can't wait on %s barrier2", t1, id, t2); \
    }                                                           \
  }



//global constants 
extern const double k_PI;
//(from emperor)
extern const int BACKLOG;
extern const char* k_CommandPort;
extern const int k_maxBufSize;
//used for buffer of trace points, replaces k_maxBufSize in send/receive
extern const int k_traceBufSize; 
extern const char* cmd_start_cameras;
extern const char* cmd_stop_cameras;
extern const char* cmd_forward_4;
extern const char* cmd_forward_3;
extern const char* cmd_forward_2;
extern const char* cmd_forward_1;
extern const char* cmd_stop;
extern const char* cmd_reverse_1;
extern const char* cmd_reverse_2;
extern const char* cmd_reverse_3;
extern const char* cmd_reverse_4;
extern const char* cmd_forward_right_1;
extern const char* cmd_forward_right_2;
extern const char* cmd_forward_left_1;
extern const char* cmd_forward_left_2;
extern const char* cmd_pivot_left_1;
extern const char* cmd_pivot_left_2;
extern const char* cmd_pivot_right_1;
extern const char* cmd_pivot_right_2;
extern const char* cmd_reverse_left_1;
extern const char* cmd_reverse_left_2;
extern const char* cmd_reverse_right_1;
extern const char* cmd_reverse_right_2;
extern const char* cmd_servo;
extern const char* pan_file;
extern const char* tilt_file;
extern const char* k_LogPort;
extern const int k_msg_buf_threshold;
//for bump switch monitoring
extern const int bump_move_time;
extern const int bump_read_size;
extern const int bump_front;
extern const int bump_rear;
extern const char* gpio_file;
//(from run-sensors)
extern const speed_t sensors_speed;
extern const char* encoders_file;
extern const char* imu_file;
extern const speed_t gps_speed;
extern const char* gps_file;
extern const char* GGA;
extern const char* RMC;
extern const char* k_imuLogPort;//using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
extern const int sensors_connect_timeout_ms;
extern const std::string encoders_init_string;
extern const std::string imu_init_string;

//for driving logic
extern const double k_distance_threshold;
extern const double k_angle_threshold_1;
extern const double k_angle_threshold_2;

//need to define these here because of g_msg_buf
extern const int k_LogBufSize = 256;
extern const int k_messages_per_second = 102; 
//if it's working right, there should be 50 IMU + 50 encoder + 2 GPS messages every second
extern const int k_msg_buf_size = k_messages_per_second * 1;
extern const int k_msg_buf_bytes = k_msg_buf_size * k_LogBufSize;

extern const int k_gpsWorkingBufSize;

//global vars 
//(from emperor)
extern int sockfd, log_sockfd;
extern int pan_fd, tilt_fd, motor_fd, gpio_fd;
//(from run-sensors)
extern int log_sensors_sockfd;
extern int encoders_fd;
extern size_t encoders_input_pos;
extern int imu_fd;
extern size_t imu_input_pos;
extern int gps_fd;
extern FILE* gps_file_ptr;
//for threading
extern int msg_count;
extern char g_msg_buf[k_msg_buf_bytes];
extern pthread_mutex_t msg_buf_and_count_lock;
//for motor command sending (set in motor_control_functions.cpp)
extern int g_motor_cmd_L;
extern int g_motor_cmd_R;
//for barriers
extern unsigned long int frame_number;
extern unsigned long int frame_number_cameras;
extern int running, halt;
extern unsigned int threads;
extern void *((*task[MAX_THREADS+1])(void *)); //+1 is for addition of camera thread
extern pthread_t thread[MAX_THREADS+1];
extern struct task_args task_args[MAX_THREADS+1];
extern pthread_mutex_t halt_mutex;
extern pthread_barrier_t barrier;
extern pthread_barrier_t barrier2;
extern int time_threads;
extern double fps;
extern int sensor_cam_ratio;
extern double fps2;
extern bool route_complete;

//structures
//(from run-sensors)
struct encoders_data_t {
  unsigned long timestamp;
  unsigned long dt;
  float ticks[2]; //left ticks is ticks[0], right is ticks[1]
};
struct imu_data_t {
  float data[15]; //yaw, pitch, roll, adjusted yaw, adjusted mag_heading, raw mag_heading, accel x, accel y, accel z, mag x, mag y, mag z, gyro x, gyro y, gyro z
  unsigned long timestamp;
  unsigned long dt;
};
//struct for x,y points (locations)
struct location_t {
  double x;
  double y;
};
//struct for x,y,theta triples (robot poses)
struct pose_t {
  double x;
  double y;
  double theta;
};
//for barriers
struct task_args {
  unsigned int id;
};

//prototypes 
//(from emperor)
void emperor_terminator(int signum);
int emperor_parse_and_execute(char* msgbuf);
int emperor_log_data(char* databuf, int log_fd);
double emperor_current_time(void);
//(from run-sensors)
bool sensors_open_serial_port(int &fd, const char* filename, 
			      const speed_t speed, const int bytes_per_read = 1);
bool sensors_set_blocking_io(int fd);
bool sensors_set_nonblocking_io(int fd);
bool sensors_is_io_blocking(int fd);
long sensors_elapsed_ms(struct timeval start, struct timeval end);
bool sensors_init(int fd, const std::string init_string, size_t &input_pos);
bool sensors_read_token(const std::string &token, char c, size_t &input_pos);
bool encoders_read_data(encoders_data_t* data); 
bool imu_read_data(imu_data_t* out_data);
double sensors_current_time(void);
bool sensors_send_data(char* msgbuf, int num_messages);
int gps_read_data(char* logbuf);

//(from data-analysis.cpp)
double my_exp(double x);
double sigmoid(double x, double a, double b);
double normalize_orientation(double angle);
double orientation_plus(double x, double y);
double orientation_minus(double x, double y);
double AngleBetween(pose_t robot, location_t point);

//from Dan's log_to_track.cpp
Mat ComputeTransitionMatrix(Mat state,float dt);

KalmanFilter execute_time_step(KalmanFilter KF,
			       Mat TransitionModel,
			       Mat MeasurementModel,
			       Mat ControlModel,
			       Mat measurement,
			       Mat control);

//new stuff
double DistanceBetween(pose_t robot, location_t point);

//for barriers
void *task_malloc(size_t size);
void start_barrier_threads(void);
void stop_barrier_threads(void);

void initialize_imu(unsigned int id);
void write_imu(unsigned int id);
void read_imu(unsigned int id);
void finalize_imu(unsigned int id);
void *imu_task(void *args);

void initialize_encoders(unsigned int id);
void write_encoders(unsigned int id);
void read_encoders(unsigned int id);
void finalize_encoders(unsigned int id);
void *encoders_task(void *args);


void initialize_gps(unsigned int id);
void write_gps(unsigned int id);
void read_gps(unsigned int id);
void finalize_gps(unsigned int id);
void *gps_task(void *args);

void initialize_buffer_and_send(unsigned int id);
void write_buffer_and_send(unsigned int id);
void read_buffer_and_send(unsigned int id);
void finalize_buffer_and_send(unsigned int id);
void *buffer_and_send_task(void *args);

//KF/move thread
void initialize_estimate_and_move(unsigned int id);
void write_estimate_and_move(unsigned int id);
void read_estimate_and_move(unsigned int id);
void finalize_estimate_and_move(unsigned int id);
void *estimate_and_move_task(void *args);

//new camera thread 30Oct15
void initialize_cameras(unsigned int id);
void write_cameras(unsigned int id);
void read_cameras(unsigned int id);
void finalize_cameras(unsigned int id);
void *cameras_task(void *args);

//new bump switch thread 5Nov15
void initialize_bump_switches(unsigned int id);
void write_bump_switches(unsigned int id);
void read_bump_switches(unsigned int id);
void finalize_bump_switches(unsigned int id);
void *bump_switches_task(void *args);


ssize_t readLine(int fd, void *buffer, size_t n);
int fd_set_blocking(int fd, int blocking);


#endif
