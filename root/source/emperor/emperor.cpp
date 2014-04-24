/*
  Implementation for main control program to run vader-rover

  Author: Scott Bronikowski
  Date: 23 April 2014
 */

#include "emperor.h"
#include <pthread.h>

//global constants
const int BACKLOG = 5;
const char* k_CommandPort = "1999";
const int k_maxBufSize = 50;
const char* cmd_start_cameras = "start_cameras";
const char* cmd_stop_cameras = "stop_cameras";
const char* cmd_pan = "pan ";
const char* pan_fd = "/dev/pwm10";
const char* cmd_tilt = "tilt ";
const char* tilt_fd = "/dev/pwm9";

//global variables
int sockfd;
int cam_thread_should_die = FALSE;
pthread_t cam_thread;

int main(int /*argc*/, char** /*argv*/)
{
  printf("Starting Emperor\n");
  printf("Please ensure that simple-gui.sc (viewer '()) is running on %s\n", k_Server);
  //start network stuff and wait for connection
  printf("Connecting to %s on port %s...\n", k_Server, k_CommandPort);
  sockfd = -1;
  while (sockfd == -1)
  {
    sockfd = ClientConnect(k_Server, k_CommandPort);
  }
  printf("success!\n");
  
  //register signal handler for termination
  signal(SIGINT, emperor_signal_handler);
  signal(SIGTERM, emperor_signal_handler);

  char msgbuf[k_maxBufSize];
  char prevmsgbuf[k_maxBufSize];
  memset(prevmsgbuf, 0, sizeof(prevmsgbuf));
  int retval;
  //loop on listening for commands
  while(1)
  {
    memset(msgbuf, 0, sizeof(msgbuf)); //clear buffer
    retval = recv(sockfd, &msgbuf, sizeof(msgbuf), 0);
    if (retval < 0)
    {
      printf("Error in recv\n");
      emperor_signal_handler(SIGTERM);
      return -1;
    }
    if (retval == 0)
    {
      printf("Sender closed connection\n");
      emperor_signal_handler(SIGTERM);
      return -1;
    }
    //if we get here, we have something useful in msgbuf, so do something with it
    if (strncmp(msgbuf, prevmsgbuf, k_maxBufSize) != 0) //received new command
    {
      printf("Received %d bytes: %s\n", retval, msgbuf);
      strncpy(prevmsgbuf, msgbuf, k_maxBufSize);
    }
    else //got a repeat of the last received command, so ignore it
      continue;
    //do stuff with commands received
    if (emperor_parse_and_execute(msgbuf) != 0)
      printf("Error in emperor_parse_and_execute\n");
    
  }

  //cleanup done in signal handler
  return 0;
}


void emperor_signal_handler(int signum)
{
  printf("received signal %d\n", signum);
  //cleanup socket
  close(sockfd);
  printf("socket closed, exiting\n");
  exit(signum);
}


void* emperor_run_cameras(void* args)
{
  BusManager busMgr;
  unsigned int numCameras = PGR_Init(&busMgr);
  if ( numCameras < 1 )
  {
    printf( "Insufficient number of cameras... exiting\n" );
    //return NULL;
    pthread_exit(NULL);
  }
  PointGrey_t* PG = new PointGrey_t[numCameras];
  if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
  {
    printf("Error starting cameras\n");
    PGR_StopAndCleanup(PG, numCameras);
    //return NULL;
    pthread_exit(NULL);
  }
  if (Network_StartCameras(PG, numCameras) != 0)
  {
    printf("Error starting network\n"); //don't return here
  }
  //setup completed
  printf("Rover: Image transfer commencing.\n");

  while(!cam_thread_should_die)
  {
    for (unsigned int i = 0; i < numCameras; i++)
    {
      PGR_GetFrame(&PG[i]);
      OpenCV_CompressFrame(&PG[i]);
      OpenCV_SendFrame(&PG[i]);
    }
  }
  //cleanup 
  PGR_StopAndCleanup(PG, numCameras);
  printf( "Cam thread done!\n" );
  //return NULL;
  pthread_exit(NULL);
}

int emperor_parse_and_execute(char* msgbuf)
{
  if (strncmp(msgbuf, cmd_start_cameras, k_maxBufSize) == 0)
  {
    printf("Matched start_cameras command\n");
    //do stuff
    cam_thread_should_die = FALSE;
    pthread_attr_t attributes;
    pthread_attr_init(&attributes);
    pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
    pthread_create(&cam_thread, &attributes, emperor_run_cameras, NULL);
    pthread_attr_destroy(&attributes);
    return 0;
  }
  if (strncmp(msgbuf, cmd_stop_cameras, k_maxBufSize) == 0)
  {
    printf("Matched stop_cameras command\n");
    //do stuff
    cam_thread_should_die = TRUE;
    pthread_join(cam_thread, NULL);
    printf("Cameras stopped\n");
    return 0;
  }  

  //if we get here without returning, it means we didn't match any commands
  printf("emperor_parse_and_execute error: no command matched msgbuf\n");
  return -1;
}

// int emperor_start_server(const char* PORT)
// {
//   int sockfd;
//   struct addrinfo hints, *servinfo, *p;
//   int yes=1;
//   int rv;
  
//   memset(&hints, 0, sizeof(hints));
//   hints.ai_family = AF_UNSPEC;
//   hints.ai_socktype = SOCK_STREAM;
//   hints.ai_flags = AI_PASSIVE; // use my IP
  
//   if ((rv = getaddrinfo(NULL, PORT, &hints, &servinfo)) != 0)
//     {
//       fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
//       return -1;
//     }
  
//   // loop through all the results and bind to the first we can
//   for(p = servinfo; p != NULL; p = p->ai_next) 
//     {
//       if ((sockfd = socket(p->ai_family, p->ai_socktype,
// 			   p->ai_protocol)) == -1) 
// 	{
// 	  perror("server: socket");
// 	  continue;
// 	}
    
//       if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes,
// 		     sizeof(int)) == -1) 
// 	{
// 	  perror("setsockopt");
// 	  exit(1);
// 	}
    
//       if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) 
// 	{
// 	  close(sockfd);
// 	  perror("server: bind");
// 	  continue;
// 	}
      
//       break;
//     }
  
//   if (p == NULL)  
//     {
//       fprintf(stderr, "server: failed to bind\n");
//       return -1;
//     }

//   freeaddrinfo(servinfo); // all done with this structure

//   if (listen(sockfd, BACKLOG) == -1) 
//     {
//       perror("listen");
//       exit(1);
//     } 
//   return sockfd;  
// }

// int emperor_accept_connection(int sockfd)
// {
//   struct sockaddr_storage their_addr; // connector's address information
//   socklen_t sin_size;
//   int new_fd, flags;
//   char s[INET6_ADDRSTRLEN];

//   //first set sockfd to nonblocking
//   if ((flags = fcntl(sockfd, F_GETFL, 0)) == -1)
//     flags = 0;
//   fcntl(sockfd, F_SETFL, flags | O_NONBLOCK);
  
//   sin_size = sizeof(their_addr);
//   new_fd = accept(sockfd, (struct sockaddr *)&their_addr, &sin_size);
//   if (new_fd == -1) 
//     return new_fd;
//   inet_ntop(their_addr.ss_family,
// 	    get_in_addr((struct sockaddr *)&their_addr),
// 	    s, sizeof(s));
//   printf("emperor server: got connection from %s\n", s);
//   return new_fd;
// }
