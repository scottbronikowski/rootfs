/*

  Header for main control program to run vader-rover for automated driving.
  Started with a merge of the old emperor and run-sensors programs, along with Dan's code in log_to_track.cpp to do Kalman filter position finding from sensor data.
  Then removed code dealing with listening for commands from game controller.
  Replaced that section with code that listens for a trace (series of waypoints) and drives to those waypoints automatically.

  Author: Scott Bronikowski
  Date: 16 October 2014
*/

#ifndef THE_FORCE_H
#define THE_FORCE_H

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


//defines

//global constants 
//(from emperor)
extern const int BACKLOG;
extern const char* k_CommandPort;
extern const int k_maxBufSize;
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
//extern const int k_LogBufSize;
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
//need to define these here because of g_msg_buf
extern const int k_LogBufSize = 256;
extern const int k_messages_per_second = 102; 
//if it's working right, there should be 50 IMU + 50 encoder + 2 GPS messages every second
extern const int k_msg_buf_size = k_messages_per_second * 1;
extern const int k_msg_buf_bytes = k_msg_buf_size * k_LogBufSize;

//global vars 
//(from emperor)
extern int sockfd, log_sockfd;
extern int cam_thread_should_die, gpio_thread_should_die;
extern pthread_t cam_thread, gpio_thread;
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
extern pthread_t producer_threads[3];
extern pthread_t consumer_thread;
extern bool producer_threads_should_die;
extern bool consumer_thread_should_die;
extern char g_msg_buf[k_msg_buf_bytes];
extern pthread_mutex_t msg_buf_and_count_lock;
//**THIS IS PROBABLY WHERE I NEED TO DECLARE MY PIPE VARIABLES

//structures
//(from run-sensors)
struct encoders_data_t {
  unsigned long timestamp;
  unsigned long dt;
  float cm[2]; //left cm traveled is cm[0], right is cm[1]
};
struct imu_data_t {
  float data[15]; //yaw, pitch, roll, adjusted yaw, adjusted mag_heading, raw mag_heading, accel x, accel y, accel z, mag x, mag y, mag z, gyro x, gyro y, gyro z
  unsigned long timestamp;
  unsigned long dt;
};

//prototypes 
//(from emperor)
//void emperor_signal_handler(int signum);
void the_force_terminator(int signum);
void* emperor_run_cameras(void* args);
void* emperor_monitor_bump_switches(void* args);
int emperor_parse_and_execute(char* msgbuf);
int emperor_log_data(char* databuf, int log_fd);
double emperor_current_time(void);
//(from run-sensors)
bool run_sensors_setup(void);
void run_sensors_start(void);
void* producer_imu(void* args);
void* producer_encoders(void* args);
void* producer_gps(void* args);
void* consumer(void* args);
bool sensors_open_serial_port(int &fd, const char* filename, 
			      const speed_t speed, const int bytes_per_read = 1);
bool sensors_set_blocking_io(int fd);
bool sensors_set_nonblocking_io(int fd);
bool sensors_is_io_blocking(int fd);
long sensors_elapsed_ms(struct timeval start, struct timeval end);
bool sensors_init(int fd, const std::string init_string, size_t &input_pos);
bool sensors_read_token(const std::string &token, char c, size_t &input_pos);
bool encoders_read_data(encoders_data_t* data); 
bool imu_read_data(imu_data_t* data);
double sensors_current_time(void);
int sensors_log_data(char* logbuf);
bool sensors_send_data(char* msgbuf, int num_messages);
void sensors_terminator(int signum);
int gps_read_data(char* logbuf);
#endif

