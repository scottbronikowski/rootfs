//Motor control implementation (MAIN ONLY) for Gumstix using Sabertooth 2x12 motor controllers
//Adapted from http://www.cplusplus.com/forum/unices/45760/
//Author: Scott Bronikowski
//Date: 27 January 2014


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
using namespace std;
   

int main(int argc, char* argv[])
{
  int arg1, arg2;
  switch (argc) {
  case 1:  //stop if no arguments given
    mc_stop();
    printf("Stopping motors.\n");
    break;
  case 2:  //these are the named speed commands
    printf("Attempting to execute command %s...",argv[1]);
    if (strcmp(argv[1], STOP) == 0) {
      mc_stop();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FWD1) == 0) {
      mc_forward_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FWD2) == 0) {
      mc_forward_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FWD3) == 0) {
      mc_forward_3();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FWD4) == 0) {
      mc_forward_4();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], REV1) == 0) {
      mc_reverse_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], REV2) == 0) {
      mc_reverse_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], REV3) == 0) {
      mc_reverse_3();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], REV4) == 0) {
      mc_reverse_4();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FR1) == 0) {
      mc_forward_right_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FR2) == 0) {
      mc_forward_right_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FL1) == 0) {
      mc_forward_left_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], FL2) == 0) {
      mc_forward_left_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], RR1) == 0) {
      mc_reverse_right_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], RR2) == 0) {
      mc_reverse_right_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], RL1) == 0) {
      mc_reverse_left_1();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], RL2) == 0) {
      mc_reverse_left_2();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], PR) == 0) {
      mc_pivot_right();
      printf("success.\n");
      return 0;}
    if (strcmp(argv[1], PL) == 0) {
      mc_pivot_left();
      printf("success.\n");
      return 0;}
    else {
      //if we get here, the command has not been recognized
      printf("FAILED\n");
      printf("Unrecognized command.  Valid commands are: %s, %s, %s, %s, %s, %s, %s, %s, %s, \
%s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n",STOP,FWD1,FWD2,FWD3,FWD4,REV1,REV2,REV3,REV4,FR1,FR2,
	     FL1,FL2,RR1,RR2,RL1,RL2,PR,PL);//***TO FINISH
      //printf("strcmp = %d\n",strcmp(argv[1], STOP));
      return -1;}
    break;
  case 3:
   arg1 = atoi(argv[1]);
   arg2 = atoi(argv[2]);
   if ((arg1 > 255) || (arg1 < 0) || (arg2 > 255) || (arg2 < 0)){
     printf("Input values out of range.  Stopping motors.\n");
     mc_stop();
     return -1;
   }
   send_to_motors(arg1, arg2);
   printf("Sending values %i, %i to motors.\n",arg1,arg2);
   break;
  default:
    printf("Too many arguments given.\n");
    return -1;
    break;
  }
  return 0;
}
