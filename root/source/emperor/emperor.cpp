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
//const char* cmd_pan = "pan";
const char* cmd_servo = "servo";
const char* pan_file = "/dev/pwm10";
//const char* cmd_tilt = "tilt";
const char* tilt_file = "/dev/pwm9";

//global variables
int sockfd;
int cam_thread_should_die = TRUE; //cam thread not running
pthread_t cam_thread;
int pan_fd, tilt_fd;

int main(int /*argc*/, char** /*argv*/)
{
  printf("Starting Emperor\n");
  printf("Please ensure that simple-gui.sc (viewer '()) is running on %s\n", k_Server);
  pan_fd = open(pan_file, O_WRONLY);
  if (pan_fd < 1)
  {
    perror("pan:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
  tilt_fd = open(tilt_file, O_WRONLY);
  if (tilt_fd < 1)
  {
    perror("tilt:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
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
    retval = emperor_parse_and_execute(msgbuf);
    // if (retval != 0)
    //   printf("Error in emperor_parse_and_execute\n");
    
  }

  //cleanup done in signal handler
  return 0;
}


void emperor_signal_handler(int signum)
{
  printf("received signal %d\n", signum);
  //cleanup socket and file handles
  close(pan_fd);
  close(tilt_fd);
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
  if (strncmp(msgbuf, cmd_start_cameras, strlen(cmd_start_cameras)) == 0) //k_maxBufSize) == 0)
  { //start cameras
    printf("Matched start_cameras command\n");
    //do stuff
    if (cam_thread_should_die) //only start if not already running
    {
      cam_thread_should_die = FALSE;
      pthread_attr_t attributes;
      pthread_attr_init(&attributes);
      pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
      pthread_create(&cam_thread, &attributes, emperor_run_cameras, NULL);
      pthread_attr_destroy(&attributes);
    }
    return 0;
  }
  if (strncmp(msgbuf, cmd_stop_cameras, strlen(cmd_stop_cameras)) == 0) //k_maxBufSize) == 0)
  { //stop cameras
    printf("Matched stop_cameras command\n");
    //do stuff
    cam_thread_should_die = TRUE;
    pthread_join(cam_thread, NULL);
    printf("Cameras stopped\n");
    return 0;
  }  
  if (strncmp(msgbuf, cmd_servo, strlen(cmd_servo)) == 0)
  { //tilt 
    printf("Matched servo command\n");
    //do stuff
    char *servo, *tilt, *pan;
    servo = strtok(msgbuf, " _");
    tilt = strtok(NULL, " _");
    pan = strtok(NULL, " _");
    // printf("Parsed: cmd[0] = %s, cmd[1] = %s, cmd[2] = %s\n", cmd[0], cmd[1], cmd[2]);
    // printf("strlen: cmd[0] = %d, cmd[1] = %d, cmd[2] = %d\n", strlen(cmd[0]), strlen(cmd[1]), strlen(cmd[2]));
    //write commands to pan and tilt fds
    int retval;
    retval = write(tilt_fd, tilt, strlen(tilt));
    if(retval < 0)
      printf("error writing tilt\n");
    //printf("wrote tilt...");
    retval = write(pan_fd, pan, strlen(pan));
    if(retval < 0)
      printf("error writing pan\n");
    //printf("wrote pan\n");

  }
  //if we get here without returning, it means we didn't match any commands
  //printf("emperor_parse_and_execute error: no command matched msgbuf\n");
  return -1;
}

