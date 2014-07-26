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

#include "toollib-camera.h" //for network stuff
#include <csignal>

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
extern const char* k_imuLogPort;//using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
extern const int k_LogBufSize;
extern const int sensors_connect_timeout_ms;
extern const std::string encoders_init_string;
extern const std::string imu_init_string;

//global variables
extern int log_sensors_sockfd;
extern int encoders_fd;
extern size_t encoders_input_pos;
extern int imu_fd;
extern size_t imu_input_pos;

//prototypes
bool sensors_open_serial_port(int &fd, const char* filename);
bool sensors_set_blocking_io(int fd);
bool sensors_set_nonblocking_io(int fd);
bool sensors_is_io_blocking(int fd);
long sensors_elapsed_ms(struct timeval start, struct timeval end);
bool sensors_init(int fd, const std::string init_string, size_t &input_pos);
bool sensors_read_token(const std::string &token, char c, size_t &input_pos);
bool encoders_read_data(encoders_data_t* data); 
bool imu_read_data(imu_data_t* data);
double sensors_current_time(void);
int sensors_log_data(char* databuf);
void sensors_terminator(int signum);
bool sensors_handler(void);

#endif //RUNENCODERS_H
