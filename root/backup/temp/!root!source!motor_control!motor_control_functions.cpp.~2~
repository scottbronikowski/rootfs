//Motor control implementation (FUNCTIONS ONLY) for Gumstix using Sabertooth 2x12 motor controllers
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
   


void motor_write(int fd, int L_speed, int R_speed)
{
  if(write(fd, &L_speed, write_size) != write_size)
  {
    perror("motor_write(L):");
    return;
  }
  tcdrain(fd);
  if (write(fd, &R_speed, write_size) != write_size)
  {
    perror("motor_write(R):");
    return;
  }
  tcdrain(fd);  
  return;
}

void motor_stop(int fd){motor_write(fd, L_STOP, R_STOP);}
void motor_forward_1(int fd){motor_write(fd, L_FWD_1, R_FWD_1);}
void motor_forward_2(int fd){motor_write(fd, L_FWD_2, R_FWD_2);}
void motor_forward_3(int fd){motor_write(fd, L_FWD_3, R_FWD_3);}
void motor_forward_4(int fd){motor_write(fd, L_FWD_FULL, R_FWD_FULL);}
void motor_reverse_1(int fd){motor_write(fd, L_REV_1, R_REV_1);}
void motor_reverse_2(int fd){motor_write(fd, L_REV_2, R_REV_2);}
void motor_reverse_3(int fd){motor_write(fd, L_REV_3, R_REV_3);}
void motor_reverse_4(int fd){motor_write(fd, L_REV_FULL, R_REV_FULL);}
void motor_forward_right_1(int fd){motor_write(fd, L_FWD_2, R_STOP);}
void motor_forward_right_2(int fd){motor_write(fd, L_FWD_3, R_FWD_1);}
void motor_forward_left_1(int fd){motor_write(fd, L_STOP, R_FWD_2);}
void motor_forward_left_2(int fd){motor_write(fd, L_FWD_1, R_FWD_3);}
void motor_reverse_right_1(int fd){motor_write(fd, L_REV_2, R_STOP);}
void motor_reverse_right_2(int fd){motor_write(fd, L_REV_3, R_REV_1);}
void motor_reverse_left_1(int fd){motor_write(fd, L_STOP, R_REV_2);}
void motor_reverse_left_2(int fd){motor_write(fd, L_REV_1, R_REV_3);}
void motor_pivot_right_1(int fd){motor_write(fd, L_FWD_2, R_REV_2);}
void motor_pivot_left_1(int fd){motor_write(fd, L_REV_2, R_FWD_2);}
void motor_pivot_right_2(int fd){motor_write(fd, L_FWD_3, R_REV_3);}
void motor_pivot_left_2(int fd){motor_write(fd, L_REV_3, R_FWD_3);}

int initport(void){
  int fd;
  fd_set input_fdset;
  struct termios old_flags; 
  struct termios term_attr;

    if ((fd = open(SABER_PORT, O_RDWR | O_NOCTTY | O_NDELAY)) == -1) 
        { 
        perror("terminal: Can't open device " SABER_PORT); 
        return fd; 
        } 
    /* configure RS232 */ 
    if (tcgetattr(fd, &term_attr) != 0) 
        { 
        perror("ERROR1: terminal: tcgetattr() failed"); 
        return -1; 
        } 
    /* save old flags */ 
    old_flags = term_attr; 
    cfsetispeed(&term_attr, SABER_BAUD_RATE); 
    cfsetospeed(&term_attr, SABER_BAUD_RATE); 
    cfmakeraw(&term_attr);

    term_attr.c_iflag = 0; 
    term_attr.c_oflag = 0; 
    term_attr.c_lflag = 0;
    term_attr.c_cflag = 0;
    term_attr.c_cc[VMIN] = 1;                 // finished after one bye 
    term_attr.c_cc[VTIME] = 0.01; // try 100ms  //8;             // or 800ms time out 

    term_attr.c_cflag &= ~(PARENB | CSTOPB | CSIZE); //added
    term_attr.c_cflag |= (SABER_BAUD_RATE | CS8 | CRTSCTS | CLOCAL | HUPCL);  // using flow control via CTS/RTS 

    term_attr.c_oflag |= (OPOST | ONLCR); 
    
    /* save old configuration */ 
    old_flags = term_attr; 
    term_attr.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG); 
                                                            
    if (tcsetattr(fd, TCSAFLUSH, &term_attr) != 0) 
        { 
	  perror("terminal: tcsetattr() failed"); 
	  return -1; 
        } 

    /* change standard input */ 
    // if (tcgetattr(STDIN_FILENO, &term_attr) != 0) 
    //     { 
    //     perror("ERROR2: terminal: tcgetattr() failed"); 
    //     return -1; 
    //     } 

    // if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &term_attr) != 0) 
    //     perror("terminal: tcsetattr() failed"); 
    
    if (tcgetattr(STDIN_FILENO, &term_attr) == 0)
      tcsetattr(STDIN_FILENO, TCSAFLUSH, &term_attr);

    FD_SET(fd, &input_fdset);                          /* Select the first channel 1 */ 

    return fd; 
}

//OLD functions
int mc_stop(void){return send_to_motors(L_STOP, R_STOP);}
int mc_forward_1(void){return send_to_motors(L_FWD_1, R_FWD_1);}
int mc_forward_2(void){return send_to_motors(L_FWD_2, R_FWD_2);}
int mc_forward_3(void){return send_to_motors(L_FWD_3, R_FWD_3);}
int mc_forward_4(void){return send_to_motors(L_FWD_FULL, R_FWD_FULL);}
int mc_reverse_1(void){return send_to_motors(L_REV_1, R_REV_1);}
int mc_reverse_2(void){return send_to_motors(L_REV_2, R_REV_2);}
int mc_reverse_3(void){return send_to_motors(L_REV_3, R_REV_3);}
int mc_reverse_4(void){return send_to_motors(L_REV_FULL, R_REV_FULL);}
int mc_forward_right_1(void){return send_to_motors(L_FWD_2, R_STOP);}
int mc_forward_right_2(void){return send_to_motors(L_FWD_3, R_FWD_1);}
int mc_forward_left_1(void){return send_to_motors(L_STOP, R_FWD_2);}
int mc_forward_left_2(void){return send_to_motors(L_FWD_1, R_FWD_3);}
int mc_reverse_right_1(void){return send_to_motors(L_REV_2, R_STOP);}
int mc_reverse_right_2(void){return send_to_motors(L_REV_3, R_REV_1);}
int mc_reverse_left_1(void){return send_to_motors(L_STOP, R_REV_2);}
int mc_reverse_left_2(void){return send_to_motors(L_REV_1, R_REV_3);}
int mc_pivot_right_1(void){return send_to_motors(L_FWD_2, R_REV_2);}
int mc_pivot_left_1(void){return send_to_motors(L_REV_2, R_FWD_2);}
int mc_pivot_right_2(void){return send_to_motors(L_FWD_3, R_REV_3);}
int mc_pivot_left_2(void){return send_to_motors(L_REV_3, R_FWD_3);}

int send_to_motors(int L_speed, int R_speed)
{
  int file_desc;

  file_desc = initport();
  if (file_desc < 0){
    perror("Error in initport() call.");
    return file_desc;
  }
  if(write(file_desc, &L_speed, write_size) != write_size)
  {
    perror("send_to_motors(L):");
    return -99;
  }
  tcdrain(file_desc);
  if(write(file_desc, &R_speed, write_size) != write_size)
  {
    perror("send_to_motors(R):");
    return -99;
  }
  tcdrain(file_desc);
  close(file_desc);
  return 0;   
}

int send_message(int retval) //sends success or failure message
{
  if (retval == 0) {
    printf("success.\n");
  } else {
    printf("FAILURE to execute.\n");
  }
  return retval;
}

int mc_print(void) //prints motor control values
{
  printf("L_FWD_FULL = %i\tR_FWD_FULL = %i\n",L_FWD_FULL,R_FWD_FULL);
  printf("L_FWD_3 = %i\tR_FWD_3 = %i\n",L_FWD_3,R_FWD_3);
  printf("L_FWD_2 = %i\tR_FWD_2 = %i\n",L_FWD_2,R_FWD_2);
  printf("L_FWD_1 = %i\tR_FWD_1 = %i\n",L_FWD_1,R_FWD_1);
  printf("L_STOP = %i\tR_STOP = %i\n",L_STOP,R_STOP);
  printf("L_REV_1 = %i\tR_REV_1 = %i\n",L_REV_1,R_REV_1);
  printf("L_REV_2 = %i\tR_REV_2 = %i\n",L_REV_2,R_REV_2);
  printf("L_REV_3 = %i\tR_REV_3 = %i\n",L_REV_3,R_REV_3);
  printf("L_REV_FULL = %i\tR_REV_FULL = %i\n",L_REV_FULL,R_REV_FULL);
  return 0;
}
