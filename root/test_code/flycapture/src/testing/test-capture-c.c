//Test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 19 February 2013

#include <stdio.h>
#include "C/FlyCapture2_C.h"
#include "RoverCamDefs.h"
#include <sys/stat.h>
#include "point-grey.h"

//prototypes
//void PrintBuildInfo();
void PrintCameraInfo(fc2Context context);
//void SetTimeStamping(fc2Context context, BOOL enableTimeStamp);
//void GrabImages(fc2Context context, int numImagesToGrab);


int main(int argc, char** argv){

  int numPics = default_num_pics;
  if (argc < 2)
  {
    printf("Defaulting to %i pictures per camera.\n",numPics);
  }
  else
  {
    numPics = atoi(argv[1]);
    printf("Taking %i pictures per camera.\n",numPics);
  }

  //set up cameras, allocate memory, ID cameras, start cameras
  //printf("Starting main\n");
  fc2Error error;
  unsigned int numCameras = point_grey_init();
  char cam_string[numCameras][512];
  fc2CameraInfo camInfo;
  struct point_grey *point_grey[numCameras];
  //printf("numCameras = %d\n",numCameras);

  //printf("Starting loop\n");
  for (int i = 0; i < numCameras; i++) {
    //printf("iteration %d\n",i);
    point_grey[i] = point_grey_setup(i);
    printf("context = %p\n",point_grey[i]->context);
    /* if (i > 0) */
    /* { */
    /*   point_grey[i]->context = point_grey[0]->context; */
    /* } */
    printf("context = %p\n",point_grey[i]->context);
    printf("finished point_grey_setup\n");
    PrintCameraInfo(point_grey[i]->context);
    error = fc2GetCameraInfo(point_grey[i]->context, &camInfo);
    if (error != FC2_ERROR_OK)
    {
      point_grey_error((char *) error );
      return -1;
    }
    if (camInfo.serialNumber == front_cam_serial)
    {
      printf("Front camera identified.\n");
      sprintf(cam_string[i], "Front camera: ");
    }
    else if (camInfo.serialNumber == pano_cam_serial)
    {
      printf("Panoramic camera identified.\n");
      sprintf(cam_string[i], "Panoramic camera: ");
    }
    else
    {
      printf("Serial number not recognized.\n");
      sprintf(cam_string[i], "ERROR!!!");
    }
    point_grey_start(point_grey[i]);
    printf("point_grey_start returned\n");
  }
  printf("finished loop\n");
  
  //do some stuff
  /* point_grey_start(point_grey[0]); */
  /* printf("started cam 0\n"); */
  /* point_grey_stop(point_grey[0]); */
  /* printf("stopped cam 0\n"); */
  /* point_grey_start(point_grey[1]); */
  /* printf("started cam 1\n"); */
  /* point_grey_stop(point_grey[1]); */
  /* printf("stopped cam 1\n"); */
  
  //cleanup
  for (int i = 0; i < numCameras; i++)
  {
    point_grey_stop(point_grey[i]);
    point_grey_cleanup(point_grey[i]);
  }
  printf("finished cleanup\n");
  return 0;
}

void PrintCameraInfo( fc2Context context )
{
    fc2Error error;
    fc2CameraInfo camInfo;
    error = fc2GetCameraInfo( context, &camInfo );
    if ( error != FC2_ERROR_OK )
    {
        // Error
    }

    printf(
        "\n*** CAMERA INFORMATION ***\n"
        "Serial number - %u\n"
        "Camera model - %s\n"
        "Camera vendor - %s\n"
        "Sensor - %s\n"
        "Resolution - %s\n"
        "Firmware version - %s\n"
        "Firmware build time - %s\n\n",
        camInfo.serialNumber,
        camInfo.modelName,
        camInfo.vendorName,
        camInfo.sensorInfo,
        camInfo.sensorResolution,
        camInfo.firmwareVersion,
        camInfo.firmwareBuildTime );
}
