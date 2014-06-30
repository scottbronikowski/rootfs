/*
  Header for standalone executable to run razor-imu

  Author: Scott Bronikowski
  Date: 30 June 2014
*/

#ifndef RUNIMU_H
#define RUNIMU_H

#include "razor-imu.h"
//#include "emperor.h" //can't include b/c main
#include "toollib-camera.h" //for network stuff
#include <csignal>

//global constants (not declared elsewhere)
extern const int run_imu_rate;
//declared in emperor.h
extern const char* k_imuLogPort;
extern const int k_LogBufSize;

//global variables

//prototypes
void run_imu_terminator(int signum);

#endif //RUNIMU_H
