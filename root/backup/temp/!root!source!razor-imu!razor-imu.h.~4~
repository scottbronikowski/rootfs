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
#include <cstring>

//global constants
extern const speed_t razor_speed;
extern const char* imu_file;
extern const int razor_connect_timeout_ms;

//global vars
extern int gl_imu_fd;
extern size_t razor_input_pos; //not used outsize of razor-imu.cpp

//structures
struct razor_data_t {
  float data[15]; //yaw, pitch, roll, adjusted yaw, adjusted mag_heading, raw mag_heading, accel x, accel y, accel z, mag x, mag y, mag z, gyro x, gyro y, gyro z
  unsigned long timestamp;
  // float heading[3]; //raw yaw, adjusted yaw, mag_heading
  // float accel[3]; //x, y, z
  // float mag[3]; //x, y, z
  // float gyro[3]; //x, y, z
};

//prototypes
//external
bool razor_open_serial_port(void);
bool razor_init(void);
bool razor_read_data(razor_data_t* data);
//internal
bool razor_set_blocking_io(void);
bool razor_set_nonblocking_io(void);
bool razor_is_io_blocking(void);
long razor_elapsed_ms(struct timeval start, struct timeval end);
bool razor_read_token(const std::string &token, char c);

#endif //RAZORIMU_H
