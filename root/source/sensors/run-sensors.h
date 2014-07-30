/*
  Header for standalone executable to run wheel encoders via Teensy board and Razor-IMU together

  Author: Scott Bronikowski
  Date: 23 July 2014
*/

#ifndef RUNSENSORS_H
#define RUNSENSORS_H

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

#include "toollib-camera.h" //for network stuff
#include <csignal>

#include <pthread.h>

//structures
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

//global constants (not declared elsewhere)
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
//need to define these here because of prototype for sensors_send_data
extern const int k_LogBufSize = 256;
extern const int k_messages_per_second = 102; 
//if it's working right, there should be 50 IMU + 50 encoder + 2 GPS messages every second
extern const int k_msg_buf_size = k_messages_per_second * 1;
extern const int k_msg_buf_bytes = k_msg_buf_size * k_LogBufSize;

//global variables
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

//prototypes
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
//int sensors_log_data(char* msgbuf, char* logbuf, const char* name);//old version, before g_msg_buf was global
int sensors_log_data(char* logbuf);
void sensors_terminator(int signum);
//bool sensors_handler(void);
int gps_read_data(char* logbuf);
bool sensors_send_data(char msgbuf[k_msg_buf_size * k_LogBufSize]);
#endif //RUNENCODERS_H
