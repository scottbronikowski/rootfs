//Header file for bump switch monitor
//Author: Scott Bronikowski
//Date: 28 January 2014

#ifndef BUMP_SWITCH_H
#define BUMP_SWITCH_H


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
