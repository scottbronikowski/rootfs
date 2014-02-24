//Test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 19 February 2013

#include <stdio.h>
#include "C/FlyCapture2_C.h"
#include <sys/stat.h>
#include "point-grey.h"
#include <Imlib2.h>
#include "RoverCamDefs.h" /*included in point-grey.h*/

//prototypes
//void PrintBuildInfo();
void PrintCameraInfo(fc2Context context);
//void SetTimeStamping(fc2Context context, BOOL enableTimeStamp);
//void GrabImages(fc2Context context, int numImagesToGrab);


int main(int argc, char** argv){

  int numPics = default_num_pics;
  int write_flag = FALSE;
  if (argc < 2)
  {
    printf("Defaulting to %i pictures per camera, no saving.\n",numPics);
  }
  else
  {
    numPics = atoi(argv[1]);
    printf("Taking %i pictures per camera.\n",numPics);
    if ((argc == 3) && (strcmp(argv[2], "write") == 0))
    { //save the final image from each camera
      
      // Since this application saves images in the OUTPUT_DIR folder
      // we must ensure that the folder exists and we have permission 
      //to write to this folder. If we do not have permission, fail right away.
      struct stat sb;
      
      if (!(stat(OUTPUT_DIR, &sb) == 0 && S_ISDIR(sb.st_mode)))
      {
	//printf("Directory %s NOT found\n",OUTPUT_DIR);
	if (mkdir(OUTPUT_DIR, S_IRWXU | S_IRGRP | S_IROTH | S_IXGRP | S_IXOTH) != 0)
	{
	  printf("Error creating directory %s\n",OUTPUT_DIR);
	  return -1;
	}
      }
      // else
      // {
      //   printf("Directory %s NOT FOUND\n",OUTPUT_DIR);
      //}
      
      char tempFileName[512];
      sprintf(tempFileName, "%stest.txt",OUTPUT_DIR);
      FILE* tempFile = fopen(tempFileName, "w+");
      if (tempFile == NULL)
      {
	printf("Failed to create file in current folder.  Please check permissions.\n");
	return -1;
      }
      fclose(tempFile);
      remove(tempFileName);
      
      //if we get here, we know the directory exists and we can write to it
      write_flag = TRUE;
      printf("Saving final image.\n");
    }
    else
    {
      printf("NO saving.\n");
    }
  }

  //set up cameras, allocate memory, ID cameras, start cameras
  //printf("Starting main\n");
  fc2Error error;
  unsigned int numCameras = point_grey_init();
  char cam_string[numCameras][512];
  fc2CameraInfo camInfo;
  struct point_grey *point_grey[numCameras];
  //printf("numCameras = %d\n",numCameras);
  //fc2Context *contexts[numCameras];
  Imlib_Image temp_image;
  char filename[512];

  //printf("Starting loop\n");
  for (int i = 0; i < numCameras; i++) {
    //printf("iteration %d\n",i);
    point_grey[i] = point_grey_setup(i);
    //printf("context = %p\n",point_grey[i]->context);
    /* if (i > 0) */
    /* { */
    /*   point_grey[i]->context = point_grey[0]->context; */
    /* } */
    //printf("context = %p\n",point_grey[i]->context);
   

    //contexts[i] = &point_grey[i]->context;
    
    printf("finished point_grey_setup\n");
    
    PrintCameraInfo(point_grey[i]->context);
    error = fc2GetCameraInfo(point_grey[i]->context, &camInfo);
    if (error != FC2_ERROR_OK)
    {
      //point_grey_error((char *) error );
      point_grey_error("Call to fc2GetCameraInfo failed")
      return -1;
    }
    if (camInfo.serialNumber == front_cam_serial)
    {
      printf("Front camera identified.\n");
      sprintf(cam_string[i], "Front_camera_");
    }
    else if (camInfo.serialNumber == pano_cam_serial)
    {
      printf("Panoramic camera identified.\n");
      sprintf(cam_string[i], "Panoramic_camera_");
    }
    else
    {
      printf("Serial number not recognized.\n");
      sprintf(cam_string[i], "ERROR!!!");
    }
    point_grey_start(point_grey[i]);
    //printf("point_grey_start returned\n");
  }
  //printf("finished loop\n");
  printf("Camera initialization complete, moving to capture with %s at %s\n",
	 FC_VID_MODE_STR, FC_F_RATE_STR);
  
  //do some stuff

  // try fc2StartSyncCapture here
  /* error = fc2StartSyncCapture(numCameras,&contexts); */
  /* if (error != FC2_ERROR_OK) */
  /* { */
  /*   point_grey_error((char *) error ); */
  /*   return -1; */
  /* } */
  /* printf("startsynccapture success\n"); */

  /* point_grey_start(point_grey[0]); */
  /* printf("started cam 0\n"); */
  /* point_grey_stop(point_grey[0]); */
  /* printf("stopped cam 0\n"); */
  /* point_grey_start(point_grey[1]); */
  /* printf("started cam 1\n"); */
  /* point_grey_stop(point_grey[1]); */
  /* printf("stopped cam 1\n"); */
  double start = current_time();
  for (int j = 0; j < numPics; j++) //numPics loop
  {
    for (int i = 0; i < numCameras; i++) //numCameras loop
    {
      //point_grey_start(point_grey[i]);
      temp_image = point_grey_fetch_frame(point_grey[i]);
      
      imlib_context_set_image(temp_image);
      //point_grey_stop(point_grey[i]);
      //printf("%simage%d\n",cam_string[i],j);
      if ((j == (numPics - 1)) && (write_flag))
	{//save final image from each camera
	  sprintf(filename,"%s%sfinal.ppm",OUTPUT_DIR,cam_string[i]);
	  //temp_image->save(filename); /*PERL api, not C*/
	  imlib_save_image(filename);
	  printf("Saved %s\n",filename);
	}
      imlib_free_image_and_decache();
    } //numCameras loop
  } //numPics loop
  double stop = current_time();
  //check elapsed time
  double elapsed = stop - start;
  double images_per_sec = (double)numPics / elapsed;
  printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
	 numPics, elapsed, images_per_sec);
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
