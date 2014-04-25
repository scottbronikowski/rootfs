/*
  Header for main control program to run vader-rover

  Author: Scott Bronikowski
  Date: 23 April 2014
 */

#ifndef EMPEROR_H
#define EMPEROR_H

#include "toollib-camera.h"
#include "motor_control.h"
#include "monitor.h"
#include <csignal>

//defines

//global constants
extern const int BACKLOG;
extern const char* k_CommandPort;
extern const int k_maxBufSize;
extern const char* cmd_start_cameras;
extern const char* cmd_stop_cameras;
extern const char* cmd_servo;
//extern const char* cmd_pan;
extern const char* pan_file;
//extern const char* cmd_tilt;
extern const char* tilt_file;

//global vars
extern int sockfd;
extern int cam_thread_should_die;
extern pthread_t cam_thread;
extern int pan_fd, tilt_fd;

//structures

//prototypes
void emperor_signal_handler(int signum);
void* emperor_run_cameras(void* args);
int emperor_parse_and_execute(char* msgbuf);


#endif
