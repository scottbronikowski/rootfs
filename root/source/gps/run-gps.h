/*
  Header for standalone executable to run gps

  Author: Scott Bronikowski
  Date: 15 July 2014
*/

#ifndef RUNGPS_H
#define RUNGPS_H

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

//global constants (not declared elsewhere)
extern const speed_t gps_speed;
extern const char* gps_file;
extern const char* GGA;
extern const char* RMC;
//declared in emperor.h
extern const char* k_imuLogPort; //using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
extern const int k_LogBufSize;

//global variables
extern int gps_fd;
extern int log_gps_sockfd;
extern FILE* gps_file_ptr;

//prototypes
bool gps_open_serial_port(void);
bool gps_set_blocking_io(void);
bool gps_set_nonblocking_io(void);
bool gps_is_io_blocking(int fd);
void run_gps_terminator(int signum);
int run_gps_log_data(char* databuf, int log_fd);
double run_gps_current_time(void);

//void run_imu_handler(int signum);

#endif //RUNGPS_H
