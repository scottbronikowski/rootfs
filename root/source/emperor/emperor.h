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

//global vars

//structures

//prototypes
void emperor_signal_handler(int signum);
int emperor_start_server(const char* PORT);
int emperor_accept_connection(int sockfd);
#endif
