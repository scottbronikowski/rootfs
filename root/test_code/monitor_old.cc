//Implementation for monitor of rear bump switch and send data over socket
//client code adapted from http://www.linuxhowtos.org/C_C++/socket.htm
//Author: Scott Bronikowski
//Date: 6 February 2014

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
//#include "bump_switch.h"
#include "monitor.h"
#include <stdlib.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

using namespace std;

void error(const char *msg)
{
    perror(msg);
    exit(EXIT_FAILURE);
}

int send_and_receive(char *out_buff, int sockfd)
{
  char in_buff[BUF_LEN];
  int n;
  printf("in send_and_receive, sockfd =%d\n", sockfd);
  n = write(sockfd,out_buff,strlen(out_buff));
  printf("n = %d\n",n);
  if (n < 0) {error("ERROR writing to socket");}
  else {printf("wrote to socket\n");}
  bzero(in_buff,BUF_LEN);
  n = read(sockfd,in_buff,BUF_LEN-1);
  if (n < 0) {error("ERROR reading from socket");}
  else {printf("read from socket\n");}
  printf("%s\n",in_buff);
  return 0;
}

int main(void)
{
  int file_desc, read_ret, gpio_num, sockfd;
  char readbuffer[read_size];
  struct sockaddr_in serv_addr;
  struct hostent* server;
  char tempmsg[BUF_LEN], in_buff[BUF_LEN], out_buff[BUF_LEN];
  bool first_connect = true;

  //open GPIO file
  file_desc = open(GPIO_FILE, O_RDONLY | O_NONBLOCK);
  if (file_desc < 0) {
    printf("ERROR: failed to open %s\n",GPIO_FILE);
    return -1;
  }
  //open socket
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0) 
      error("ERROR opening socket");
  server = gethostbyname(SERVER);
  if (server == NULL) {
      fprintf(stderr,"ERROR, no such host\n");
      exit(EXIT_FAILURE);
  }
  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  bcopy((char *)server->h_addr, 
       (char *)&serv_addr.sin_addr.s_addr,
       server->h_length);
  serv_addr.sin_port = htons(port_no);
    //now connect to server
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0)
    {
      strcpy(tempmsg, "Error connecting to server ");
      strcat(tempmsg, SERVER);
      error(tempmsg);
      //error("ERROR connecting");
    } 
    else
    {
      if (first_connect)
      {
	first_connect = false;
	printf("Now connected to %s\n",inet_ntoa(serv_addr.sin_addr));
      }
    }
  // while (1) //socket loop
  // {
    // //now connect to server
    // if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0)
    // {
    //   strcpy(tempmsg, "Error connecting to server ");
    //   strcat(tempmsg, SERVER);
    //   error(tempmsg);
    //   //error("ERROR connecting");
    // } 
    // else
    // {
    //   if (first_connect)
    //   {
    // 	first_connect = false;
    // 	printf("Now connected to %s\n",inet_ntoa(serv_addr.sin_addr));
    //   }
    // }
    while (1) //read loop
    {
      read_ret = read(file_desc,readbuffer,read_size);
      if (read_ret < 0) {
	//printf("Looping on read error.");
	continue;
      } else {
	//now we have a string in readbuffer, must parse it
	gpio_num = atoi(strtok(readbuffer," "));
	if (gpio_num == REAR_BUMP){
	  //bumped rear, so stop and go forward
	  mc_stop();
	  mc_forward_4();
	  usleep(move_time);
	  mc_stop();
	  printf("Local: %s", BUMP_MSG_REAR);
	  strcpy (out_buff, BUMP_MSG_REAR);
	  printf("calling send_and_receive\n");
	  if (send_and_receive(out_buff, sockfd) == 0){
	    printf("returned from send_and_receive\n");
	    //close(sockfd); 
	    //printf("closed sockfd\n");
	    //break;
	  }
	} else if (gpio_num == FRONT_BUMP){
	  //bumped front, so stop and go back
	  mc_stop();
	  mc_reverse_4();
	  usleep(move_time);
	  mc_stop();
	  printf("Local: I bumped something to the front.\n");
	}
      }
    } //end read loop
    //now broken out of switch loop...send_and_receive closed sockfd, so 
    //go back to socket loop and reopen
    printf("exited read loop\n");
    // } //end socket loop
  return 0;
}
