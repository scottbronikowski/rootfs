//Header file for bump switch monitor
//Author: Scott Bronikowski
//Date: 28 January 2014

#ifndef BUMP_SWITCH_H
#define BUMP_SWITCH_H


#define REAR_BUMP  184   //GPIO184
#define FRONT_BUMP 185   //GPIO185
#define GPIO_FILE  "/dev/gpio-event"

const int move_time = 25000;
const int read_size = 24;


#endif
