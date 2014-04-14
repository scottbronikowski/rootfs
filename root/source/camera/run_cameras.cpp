/*
  Main program to run rover cameras and send images to workstation across network
  in an infinite loop.
  Includes signal handling to end the program cleanly from a SIGINT

  Author: Scott Bronikowski
  Date: 14 April 2014
 */

#include "toollib-camera.h"

using namespace FlyCapture2;

int main(int /*argc*/, char** /*argv*/)
{
    PrintBuildInfo();
    const int k_numImages = 100;
    BusManager busMgr;
    unsigned int numCameras = PGR_Init(&busMgr);
    printf( "Number of cameras detected: %u\n", numCameras );
    if ( numCameras < 1 )
    {
        printf( "Insufficient number of cameras... exiting\n" );
        return -1;
    }

    PointGrey_t* PG = new PointGrey_t[numCameras];
    if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
    {
      printf("Error starting cameras\n");
      PGR_StopAndCleanup(PG, numCameras);
      return -1;
    }

    if (Network_StartCameras(PG, numCameras) != 0)
    {
      printf("Error starting network\n");
      //return -1;
    }

    printf( "Grabbing %d images\n", k_numImages ); //setup completed

    double start = current_time();
    for ( int imageCount=0; imageCount < k_numImages; imageCount++ ) //main capture loop
    {
      for (unsigned int i = 0; i < numCameras; i++)
      {
	/* PGR functions */
	PGR_GetFrame(&PG[i]);
	//PGR_GetFrameRaw(&PG[i]);

	/* Imlib functions */
	// Imlib_GetFrame(&PG[i]);
	// //Imlib_GetFrameWithResize(&PG[i]);
	// imlib_context_set_image(PG[i].finalImage); //move this closer to imlib calls?

	/* OpenCV stuff */
	OpenCV_CompressFrame(&PG[i], imageCount);

	if (imageCount % 10 == 0)
	  printf("Captured %u-%d\n",PG[i].cameraInfo.serialNumber, imageCount);
	
	/* SENDING BLOCK */
	OpenCV_SendFrame(&PG[i]);
      }
    }

    double stop = current_time();
    //check elapsed time
    double elapsed = stop - start;
    double images_per_sec = (double)k_numImages / elapsed;
    printf( "\nFinished grabbing images\n" );
    printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
    	   k_numImages, elapsed, images_per_sec);
    
    /* SAVING BLOCK */
    // //grab and save one last image from each camera, after time has been measured
    // // Since this section of code saves images in the k_OutputDir folder,
    // // must ensure that this folder exists and we have permissions to write to it
    // if (CheckSaving(k_OutputDir) != 0)
    // {
    //   printf("Cannot save to %s, please check permissions\n",k_OutputDir);
    //   return -1;
    // }
    // for (unsigned int i = 0; i < numCameras; i++)
    // {
    //   /* PGR functions only*/
    //   PGR_GetFrame(&PG[i]);
    //   PGR_SaveImage(&PG[i]);

    //   /* now with Imlib functions */
    //   //Imlib_GetFrame(&PG[i]);
    //   //Imlib_SaveImage(&PG[i]);

    //   /* use OpenCV functions here */
    // }
    /* END SAVING BLOCK */

    PGR_StopAndCleanup(PG, numCameras);
    printf( "Done!\n" );
    return 0;
}
