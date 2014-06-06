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


//prototypes
int razor_open_serial_port(const char* port);

#endif //RAZORIMU_H
