//Implementation for monitor of rear bump switch and send data over socket
//client code adapted from http://www.linuxhowtos.org/C_C++/socket.htm
//Author: Scott Bronikowski
//Date: 7 February 2014

#include "monitor.h"

using namespace std;


int main(void)
{
  int file_desc, read_ret, gpio_num;
  char readbuffer[read_size], msg_buf[BUF_LEN];

  file_desc = open(GPIO_FILE, O_RDONLY | O_NONBLOCK);
  if (file_desc < 0) {
    printf("ERROR: failed to open %s\n",GPIO_FILE);
    return -1;
  }

  while (1) 
  {
    read_ret = read(file_desc,readbuffer,read_size);
    if (read_ret < 0) {
      //printf("Looping on read error.");
      usleep(10000); /*sleep for 0.01s--should probably change this to polling
		     or asynchronous IO*/
      continue;
    } else {
       //now we have a string in readbuffer, must parse it
      bzero(msg_buf, BUF_LEN);//zero out the message buffer
      gpio_num = atoi(strtok(readbuffer," "));
      if (gpio_num == REAR_BUMP)
      {
	//bumped rear, so stop and go forward
	mc_stop();
	mc_forward_4();
	usleep(move_time);
	mc_stop();
	//printf("Local: %s", BUMP_MSG_REAR);
	strcpy(msg_buf, BUMP_MSG_REAR);
      } 
      else if (gpio_num == FRONT_BUMP)
      {
	//bumped front, so stop and go back
	mc_stop();
	mc_reverse_4();
	usleep(move_time);
	mc_stop();
	//printf("Local: %s", BUMP_MSG_FRONT);
	strcpy(msg_buf, BUMP_MSG_FRONT);
      }
      //message is in msg_buf, now send it
      if (send_and_receive(msg_buf) < 0)
	printf("Local: %s\n",msg_buf);
    }
  }
  return 0;
}

void error(const char *msg)
{
    perror(msg);
    //exit(0);
}

int send_and_receive(const char *msg)
{
    int sockfd, portno, n;
    struct sockaddr_in serv_addr;
    struct hostent *server;
    char buffer[BUF_LEN];

    portno = port_no;
    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) 
    {
      error("ERROR opening socket");
      return -1;
    }
    server = gethostbyname(SERVER);
    if (server == NULL) 
    {
      error("Error, no such host");
      return -1;
      //fprintf(stderr,"ERROR, no such host\n");
      //exit(0);
    }
    bzero((char *) &serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
	  (char *)&serv_addr.sin_addr.s_addr,
	  server->h_length);
    serv_addr.sin_port = htons(portno);
    bzero(buffer,BUF_LEN);
    if (connect(sockfd,(struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0)
    {
      strcpy(buffer, "Error connecting to server ");
      strcat(buffer, SERVER);
      error(buffer);
      return -1;
      //        error("ERROR connecting");
    }
    // else
    //   printf("Connected to %s\n",inet_ntoa(serv_addr.sin_addr));
    
    strcpy(buffer, msg);
    printf("Sending to %s: %s",inet_ntoa(serv_addr.sin_addr),buffer);
    n = write(sockfd,buffer,strlen(buffer));
    if (n < 0) 
      error("ERROR writing to socket");
    bzero(buffer, BUF_LEN);
    n = read(sockfd,buffer,BUF_LEN-1);
    if (n < 0) 
      error("ERROR reading from socket");
    printf("%s\n",buffer);
    close(sockfd);
    return 0;
}
