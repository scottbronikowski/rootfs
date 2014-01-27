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
using namespace std;
       
#define BAUDRATE B38400
#define PORT_0 "/dev/ttyO0"
//#define _POSIX_SOURCE 1 /* POSIX compliant source */

#define FALSE 0
#define TRUE 1
static int L_STOP = 64;
static int R_STOP = 192;

volatile int STOP=FALSE; 
int fd;
//ssize_t size = 9;
ssize_t size = 1;  //only writing one byte at a time
fd_set input_fdset;


int getbaud(int );
int initport(void );




// int main(void) {

// 	int counter, i;
// 	unsigned char Cmd[10];
// 	unsigned char Result[10];
// 	string in_str;
// 	int in_int, check;

	
// 	//printf("open USB0......\n");
// 	printf("opened " PORT_0 "...\n");
// 	printf("initPort: %d\n",initport());
// 	printf("baud after init  = %d\n", getbaud(fd));

	
// 	/*	Cmd[0] = 0x02;		//       Module 2
// 	Cmd[1] = 0x06;		//	Get Axis Parameter (GAP) 
// 	Cmd[2] = 0xD1;		//	209 Get Encoder Position
// 	Cmd[3] = 0x01;		//	Encoder number 1
// 	Cmd[4] = 0; Cmd[5] = 0; Cmd[6] = 0; Cmd[7] = 0;
// 	checksum(Cmd);*/
// 	while (1){
// 	  usleep(10000); //wait 10ms
// 	  cout << "Enter decimal value (0-255) to send to robot.  Enter 'q' to quit.: ";
// 	  getline(cin, in_str);
// 	  if (in_str == "q") break;
// 	  in_int = atoi(in_str.c_str());
// 	  if ((in_int > 255) || (in_int < 0)){
// 	    printf("Invalid input.\n");
// 	    continue;
// 	  }
// 	  printf("Sending decimal value %d\n",in_int);
// 	  //writeport(fd, in_int);
// 	  check = write(fd, &in_int, size);
// 	  printf("Check: %d\n", check);
// 	}

// 	/*	printf("write..."); 

// 	printf("%d bytes!\n",writeport(fd, Cmd));
	
// 	for(i = 0; i < 9; i++) printf("%d; ", Cmd[i]); printf("\n");
	
//        	usleep(500000);		// sleep 500 ms
	
// 	fcntl(fd, F_SETFL, FNDELAY); // don't block serial read
	
// 	printf("read...\n");
// 	printf("%d bytes\n", readport(fd,Result));
	
// 	printf("read    = ");	for(i = 0; i < 9; i++) printf("%d; ", Cmd[i]); printf("\n");*/

// 	close(fd);	
// 	//ssize_t size = 10;
// 	return 0;
// }

int error_stop()
{
  write(fd, &L_STOP, size);
  write(fd, &R_STOP, size);
}

int main(int argc, char* argv[])
{
  int arg1, arg2;

  initport();
  if (argc != 3) {
    printf("Incorrect number of arguments. Stopping motors.\n");
    error_stop();
    close(fd);
    return -1;
  }
  arg1 = atoi(argv[1]);
  arg2 = atoi(argv[2]);
  if ((arg1 > 255) || (arg1 < 0) || (arg2 > 255) || (arg2 < 0)){
    printf("Invalid input.  Stopping motors.\n");
    error_stop();
    close(fd);
    return -1;
  }
  write(fd, &arg1, size);
  write(fd, &arg2, size);
  close(fd);
  return 0;
}


int getbaud(int fd) 
{
	//printf("getbaud\n");
	struct termios termAttr;
	int inputSpeed = -1;
	speed_t baudRate;
	tcgetattr(fd, &termAttr);
	/* Get the input speed.                              */
	baudRate = cfgetispeed(&termAttr);
	switch (baudRate) {
		case B0:      inputSpeed = 0; break;
		case B50:     inputSpeed = 50; break;
		case B110:    inputSpeed = 110; break;
		case B134:    inputSpeed = 134; break;
		case B150:    inputSpeed = 150; break;
		case B200:    inputSpeed = 200; break;
		case B300:    inputSpeed = 300; break;
		case B600:    inputSpeed = 600; break;
		case B1200:   inputSpeed = 1200; break;
		case B1800:   inputSpeed = 1800; break;
		case B2400:   inputSpeed = 2400; break;
		case B4800:   inputSpeed = 4800; break;
		case B9600:   inputSpeed = 9600; break;
		case B19200:  inputSpeed = 19200; break;
		case B38400:  inputSpeed = 38400; break;
	}
	return inputSpeed;
}



int initport(void){
	struct termios old_flags; 
	struct termios term_attr;

    if ((fd = open(PORT_0, O_RDWR | O_NOCTTY | O_NDELAY)) == -1) 
        { 
        perror("terminal: Can't open device " PORT_0); 
        return(1); 
        } 
    /* configurare RS232 */ 
    if (tcgetattr(fd, &term_attr) != 0) 
        { 
        perror("terminal: tcgetattr() failed"); 
        return(1); 
        } 
    /* save old flags */ 
    old_flags = term_attr; 
    cfsetispeed(&term_attr, BAUDRATE); 
    cfsetospeed(&term_attr, BAUDRATE); 
    cfmakeraw(&term_attr);

	term_attr.c_iflag = 0; 
	term_attr.c_oflag = 0; 
	term_attr.c_lflag = 0;
	term_attr.c_cflag = 0;

 
    term_attr.c_cc[VMIN] = 1;                 // finished after one bye 
    term_attr.c_cc[VTIME] = 8;             // or 800ms time out 

    term_attr.c_cflag &= ~(PARENB | CSTOPB | CSIZE); //added
    term_attr.c_cflag |= (BAUDRATE | CS8 | CRTSCTS | CLOCAL | HUPCL);  // using flow control via CTS/RTS 


	term_attr.c_oflag |= (OPOST | ONLCR); 


	 /* save old configuration */ 

  old_flags = term_attr; 
  term_attr.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG); 

                                                            
    if (tcsetattr(fd, TCSAFLUSH, &term_attr) != 0) 
        { 
        perror("terminal: tcsetattr() failed"); 
        return(1); 
        } 

    /* change standard input */ 
    if (tcgetattr(STDIN_FILENO, &term_attr) != 0) 
        { 
        perror("terminal: tcgetattr() failed"); 
        return(1); 
        } 

    if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &term_attr) != 0) 
        perror("terminal: tcsetattr() failed"); 

    FD_SET(fd, &input_fdset);                          /* Select the first channel 1 */ 

    return 0; 
}
