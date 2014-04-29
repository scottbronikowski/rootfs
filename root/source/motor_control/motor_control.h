//Header file for motor_control on Gumstix using Sabertooth 2x12 motor controllers in
//simplified serial mode
//Author: Scott Bronikowski
//Date: 27 January 2014

#ifndef MOTOR_CONTROL_H
#define MOTOR_CONTROL_H

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

//defines for port communication
#define SABER_BAUD_RATE B38400
#define SABER_PORT "/dev/ttyO0"
static const ssize_t write_size = 1;  //only writing one byte at a time

//defines for movement command strings
#define STOP "stop"
#define FWD1 "forward_1"
#define FWD2 "forward_2"
#define FWD3 "forward_3"
#define FWD4 "forward_4"
#define REV1 "reverse_1"
#define REV2 "reverse_2"
#define REV3 "reverse_3"
#define REV4 "reverse_4"
#define FR1  "forward_right_1"
#define FR2  "forward_right_2"
#define FL1  "forward_left_1"
#define FL2  "forward_left_2"
#define RR1  "reverse_right_1"
#define RR2  "reverse_right_2"
#define RL1  "reverse_left_1"
#define RL2  "reverse_left_2"
#define PR1  "pivot_right_1"
#define PR2  "pivot_right_2"
#define PL1  "pivot_left_1"
#define PL2  "pivot_left_2"


//constants for integers representing motor commands
static const int L_STOP = 64;
static const int R_STOP = 192;
static const int L_FWD_ABS_FULL = 127;
static const int R_FWD_ABS_FULL = 255;
static const int L_REV_ABS_FULL = 1;
static const int R_REV_ABS_FULL = 128;
static const float R_OFFSET_PCT = -0.005;  //-5% for right
static const int R_OFFSET = (int)(R_OFFSET_PCT * (R_FWD_ABS_FULL - R_STOP));
static const float L_OFFSET_PCT = 0.0;  //no change for left
static const int L_OFFSET = (int)(L_OFFSET_PCT * (L_FWD_ABS_FULL - L_STOP));

//Forward speeds
static const int L_FWD_FULL = L_FWD_ABS_FULL + L_OFFSET;
static const int R_FWD_FULL = R_FWD_ABS_FULL + R_OFFSET;

static const int L_FWD_1 = L_STOP + (L_FWD_FULL - L_STOP)/4; //quarter-speed
static const int R_FWD_1 = R_STOP + (R_FWD_FULL - R_STOP)/4; 

static const int L_FWD_2 = L_STOP + (L_FWD_FULL - L_STOP)/2; //half-speed
static const int R_FWD_2 = R_STOP + (R_FWD_FULL - R_STOP)/2;

static const int L_FWD_3 = L_STOP + 3*(L_FWD_FULL - L_STOP)/4; //three-quarter-speed
static const int R_FWD_3 = R_STOP + 3*(R_FWD_FULL - R_STOP)/4;

//Reverse speeds 
static const int L_REV_FULL = L_REV_ABS_FULL - L_OFFSET;
static const int R_REV_FULL = R_REV_ABS_FULL - R_OFFSET;

static const int L_REV_1 = L_STOP - (L_STOP - L_REV_FULL)/4; //quarter-speed
static const int R_REV_1 = R_STOP - (R_STOP - R_REV_FULL)/4;

static const int L_REV_2 = L_STOP - (L_STOP - L_REV_FULL)/2; //half-speed
static const int R_REV_2 = R_STOP - (R_STOP - R_REV_FULL)/2;

static const int L_REV_3 = L_STOP - 3*(L_STOP - L_REV_FULL)/4; //three-quarter-speed
static const int R_REV_3 = R_STOP - 3*(R_STOP - R_REV_FULL)/4;

//function prototypes
int initport(void); //initializes UART port to send data to motors
void motor_write(int fd, int L_speed, int R_speed);  //new send command
void motor_stop(int fd);
void motor_forward_1(int fd);
void motor_forward_2(int fd);
void motor_forward_3(int fd);
void motor_forward_4(int fd);
void motor_reverse_1(int fd);
void motor_reverse_2(int fd);
void motor_reverse_3(int fd);
void motor_reverse_4(int fd);
void motor_forward_right_1(int fd);
void motor_forward_right_2(int fd);
void motor_forward_left_1(int fd);
void motor_forward_left_2(int fd);
void motor_reverse_right_1(int fd);
void motor_reverse_right_2(int fd);
void motor_reverse_left_1(int fd);
void motor_reverse_left_2(int fd);
void motor_pivot_right_1(int fd);
void motor_pivot_left_1(int fd);
void motor_pivot_right_2(int fd);
void motor_pivot_left_2(int fd);

//OLD functions
int mc_stop(void);
int mc_forward_1(void);
int mc_forward_2(void);
int mc_forward_3(void);
int mc_forward_4(void);
int mc_reverse_1(void);
int mc_reverse_2(void);
int mc_reverse_3(void);
int mc_reverse_4(void);
int mc_forward_right_1(void);
int mc_forward_right_2(void);
int mc_forward_left_1(void);
int mc_forward_left_2(void);
int mc_reverse_right_1(void);
int mc_reverse_right_2(void);
int mc_reverse_left_1(void);
int mc_reverse_left_2(void);
int mc_pivot_right_1(void);
int mc_pivot_left_1(void);
int mc_pivot_right_2(void);
int mc_pivot_left_2(void);
int send_to_motors(int L_speed, int R_speed); //sends integer values to motors
int send_message(int retval); //sends success or failure message
int mc_print(void); //prints motor control values
#endif
