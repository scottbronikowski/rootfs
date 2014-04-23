/*
  Implementation for main control program to run vader-rover

  Author: Scott Bronikowski
  Date: 23 April 2014
 */

#include "emperor.h"

//global constants
const int BACKLOG = 5;

//global variables



int main(int /*argc*/, char** /*argv*/)
{
  printf("Starting Emperor\n");
  //start network stuff and wait for connection

  //accept connection

  //loop on listening for commands

  //do stuff with commands received
 

  return 0;
}


void emperor_signal_handler(int signum)
{
  printf("received signal %d\n", signum);
  exit(signum);
}

int emperor_start_server(const char* PORT)
{
  int sockfd;
  struct addrinfo hints, *servinfo, *p;
  int yes=1;
  int rv;
  
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  hints.ai_flags = AI_PASSIVE; // use my IP
  
  if ((rv = getaddrinfo(NULL, PORT, &hints, &servinfo)) != 0)
    {
      fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
      return -1;
    }
  
  // loop through all the results and bind to the first we can
  for(p = servinfo; p != NULL; p = p->ai_next) 
    {
      if ((sockfd = socket(p->ai_family, p->ai_socktype,
			   p->ai_protocol)) == -1) 
	{
	  perror("server: socket");
	  continue;
	}
    
      if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
		     sizeof(int)) == -1) 
	{
	  perror("setsockopt");
	  exit(1);
	}
    
      if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) 
	{
	  close(sockfd);
	  perror("server: bind");
	  continue;
	}
      
      break;
    }
  
  if (p == NULL)  
    {
      fprintf(stderr, "server: failed to bind\n");
      return -1;
    }

  freeaddrinfo(servinfo); // all done with this structure

  if (listen(sockfd, BACKLOG) == -1) 
    {
      perror("listen");
      exit(1);
    } 
  return sockfd;  
}

int emperor_accept_connection(int sockfd)
{
  struct sockaddr_storage their_addr; // connector's address information
  socklen_t sin_size;
  int new_fd, flags;
  char s[INET6_ADDRSTRLEN];

  //first set sockfd to nonblocking
  if ((flags = fcntl(sockfd, F_GETFL, 0)) == -1)
    flags = 0;
  fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);
  
  sin_size = sizeof(their_addr);
  new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
  if (new_fd == -1) 
    return new_fd;
  inet_ntop(their_addr.ss_family,
	    get_in_addr((struct sockaddr *)&their_addr),
	    s, sizeof(s));
  printf("emperor server: got connection from %s\n", s);
  return new_fd;
}
