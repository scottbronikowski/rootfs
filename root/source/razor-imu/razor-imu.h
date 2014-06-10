/*
  Header for interface to Sparkfun 9DOF Razor IMU.  Based off RazorAHRS developed by Peter Bartz (https://github.com/ptrbrtz/razor-9dof-ahrs)

  Author: Scott Bronikowski
  Date: 6 June 2014
*/

#ifndef RAZORIMU_H
#define RAZORIMU_H

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

//global constants
extern const speed_t razor_speed;
extern const char* imu_file;
extern const int razor_connect_timeout_ms;

//global vars
extern int imu_fd;

//prototypes
bool razor_open_serial_port(void);
bool razor_init(void);
bool razor_set_blocking_io(void);
bool razor_set_nonblocking_io(void);
bool razor_is_io_blocking(void);
long razor_elapsed_ms(struct timeval start, struct timeval end);


#endif //RAZORIMU_H
