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
extern int log_imu_sockfd;

//prototypes
void run_imu_terminator(int signum);
int run_imu_log_data(char* databuf, int log_fd);
double run_imu_current_time(void);
void run_imu_handler(int signum);
void run_imu_sigaction(void);
void run_imu_interrupt_on(int rate);

#endif //RUNIMU_H
