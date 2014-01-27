//Header file for motor_control on Gumstix using Sabertooth 2x12 motor controllers in
//simplified serial mode
//Author: Scott Bronikowski
//Date: 27 January 2014

#ifndef MOTOR_CONTROL_H
#define MOTOR_CONTROL_H

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

//constants for integers representing motor commands
static const int L_STOP = 64;
static const int R_STOP = 192;

//Forward speeds
static const int L_FWD_FULL = 127;
static const int R_FWD_FULL = 255;

static const int L_FWD_1 = L_STOP + (L_FWD_FULL - L_STOP)/4; //quarter-speed
static const int R_FWD_1 = R_STOP + (R_FWD_FULL - R_STOP)/4; 

static const int L_FWD_2 = L_STOP + (L_FWD_FULL - L_STOP)/2; //half-speed
static const int R_FWD_2 = R_STOP + (R_FWD_FULL - R_STOP)/2;

static const int L_FWD_3 = L_STOP + 3*(L_FWD_FULL - L_STOP)/4; //three-quarter-speed
static const int R_FWD_3 = R_STOP + 3*(R_FWD_FULL - R_STOP)/4;

//Reverse speeds 
static const int L_REV_FULL = 1;
static const int R_REV_FULL = 128;

static const int L_REV_1 = L_STOP - (L_STOP - L_REV_FULL)/4; //quarter-speed
static const int R_REV_1 = R_STOP - (R_STOP - R_REV_FULL)/4;

static const int L_REV_2 = L_STOP - (L_STOP - L_REV_FULL)/2; //half-speed
static const int R_REV_2 = R_STOP - (R_STOP - R_REV_FULL)/2;

static const int L_REV_3 = L_STOP - 3*(L_STOP - L_REV_FULL)/4; //three-quarter-speed
static const int R_REV_3 = R_STOP - 3*(R_STOP - R_REV_FULL)/4;

//function prototypes
int mc_stop(void);
int mc_forward_1(void);
int mc_forward_2(void);
int mc_forward_3(void);
int mc_forward_4(void);
int mc_reverse_1(void);
int mc_reverse_2(void);
int mc_reverse_3(void);
int mc_reverse_4(void);


int send_to_motors(int L_speed, int R_speed); //sends integer values to motors

int initport(void); //initializes UART port to send data to motors

#endif
