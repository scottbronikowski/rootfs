//Header file for bump switch monitor
//Author: Scott Bronikowski
//Date: 28 January 2014

#ifndef MONITOR_H
#define MONITOR_H

#include <stdio.h>   /* Standard input/output definitions */
#include <string.h>  /* String function definitions */
#include <unistd.h>  /* UNIX standard function definitions */
#include <fcntl.h>   /* File control definitions */
#include <errno.h>   /* Error number definitions */
#include <termios.h> /* POSIX terminal control definitions */
#include <sys/types.h>
#include <sys/stat.h>
#include <iostream>
#include <stdlib.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include "motor_control.h"


#define REAR_BUMP  184   //GPIO184
#define FRONT_BUMP 185   //GPIO185
#define GPIO_FILE  "/dev/gpio-event"

#define SERVER     "seykhl.ecn.purdue.edu"
const int port_no = 2222;

const int move_time = 25000;
const int read_size = 24;

#define BUMP_MSG_FRONT "I bumped something to the front.\n"
#define BUMP_MSG_REAR  "I bumped something to the rear.\n"
#define BUF_LEN 256



//prototypes
void error(const char *msg);
int send_and_receive(const char *msg);

#endif
