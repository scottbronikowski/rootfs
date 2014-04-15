/*
  Main program to run rover cameras and send images to workstation across network
  in an infinite loop.
  Includes signal handling to end the program cleanly from a SIGINT

  Author: Scott Bronikowski
  Date: 14 April 2014
 */

#include "toollib-camera.h"
#include <csignal>

using namespace FlyCapture2;

//global variables -- needed for signal_handler to do cleanup
PointGrey_t* PG;
unsigned int numCameras;

void signal_handler(int signum)
{
  //printf("received signal %d\n", signum);
  PGR_StopAndCleanup(PG, numCameras);
  printf("Image transfer stopped...exiting\n" );
  exit(signum);
}


int main(int /*argc*/, char** /*argv*/)
{
  BusManager busMgr;
  //unsigned int 
  numCameras = PGR_Init(&busMgr);
  if ( numCameras < 1 )
  {
    printf( "Insufficient number of cameras... exiting\n" );
    return -1;
  }
  //PointGrey_t* 
  PG = new PointGrey_t[numCameras];
  if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
  {
    printf("Error starting cameras\n");
    PGR_StopAndCleanup(PG, numCameras);
    return -1;
  }
  if (Network_StartCameras(PG, numCameras) != 0)
  {
    printf("Error starting network\n"); //don't return here
  }
  //setup completed
  printf("Rover: Image transfer commencing.\n");

  //register signal handler for termination
  signal(SIGINT, signal_handler);
  signal(SIGTERM, signal_handler);

  while(1)
  {
    for (unsigned int i = 0; i < numCameras; i++)
    {
      PGR_GetFrame(&PG[i]);
      OpenCV_CompressFrame(&PG[i]);
      OpenCV_SendFrame(&PG[i]);
    }
  }
    
  //cleanup -- now done in signal_handler
  // PGR_StopAndCleanup(PG, numCameras);
  // printf( "Done!\n" );
  return 0;
}
