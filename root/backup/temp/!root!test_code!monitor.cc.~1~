//Implementation for monitor of rear bump switch
//Author: Scott Bronikowski
//Date: 28 January 2014

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
#include "motor_control.h"
#include "bump_switch.h"
using namespace std;


int main(void)
{
  int file_desc, read_ret, gpio_num;
  char readbuffer[read_size];
  //  struct timeval tv;

  file_desc = open(GPIO_FILE, O_RDONLY | O_NONBLOCK);
  if (file_desc < 0) {
    printf("ERROR: failed to open %s\n",GPIO_FILE);
    return -1;
  }
  //tv.tv_sec = 0;
  //tv.tv_usec = 0;

  while (1) 
  {
    read_ret = read(file_desc,readbuffer,read_size);
    if (read_ret < 0) {
      //printf("Looping on read error.");
      continue;
    } else {
      //printf("Read '%s'\n", readbuffer);
      //now we have a string in readbuffer, must parse it
      //printf("test: %i\n",readbuffer[0]);
      gpio_num = atoi(strtok(readbuffer," "));
      //printf("test2: %i\n",gpio_num);
      if (gpio_num == REAR_BUMP){
	//bumped rear, so stop and go forward
	mc_stop();
	mc_forward_4();
	usleep(move_time);
	mc_stop();
	printf("I bumped something to the rear.\n");
      } else if (gpio_num == FRONT_BUMP){
	//bumped front, so stop and go back
	mc_stop();
	mc_reverse_4();
	usleep(move_time);
	mc_stop();
	printf("I bumped something to the front.\n");
      }
    }
  }
  return 0;
}
