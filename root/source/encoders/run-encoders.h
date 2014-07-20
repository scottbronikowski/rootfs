/*
  Header for standalone executable to run wheel encoders via Teensy board

  Author: Scott Bronikowski
  Date: 19 July 2014
*/

#ifndef RUNENCODERS_H
#define RUNENCODERS_H

//#include "razor-imu.h"
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

//global constants (not declared elsewhere)
extern const speed_t encoders_speed;
extern const char* encoders_file;
//declared in emperor.h
extern const char* k_imuLogPort;//using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
extern const int k_LogBufSize;
extern const int encoders_connect_timeout_ms;

//global variables
extern int log_encoders_sockfd;
extern int encoders_fd;
extern FILE* encoders_file_ptr;
extern size_t encoders_input_pos;

//prototypes
bool encoders_open_serial_port(void);
bool encoders_init(void); 
bool encoders_read_data(encoders_data_t* data); 
bool encoders_set_blocking_io(void);
bool encoders_set_nonblocking_io(void);
bool encoders_is_io_blocking(int fd);
void run_encoders_handler(int signum); 
void run_encoders_terminator(int signum);
int run_encoders_log_data(char* databuf, int log_fd);
double run_encoders_current_time(void);
long encoders_elapsed_ms(struct timeval start, struct timeval end);
bool encoders_read_token(const std::string &token, char c);
#endif //RUNENCODERS_H
