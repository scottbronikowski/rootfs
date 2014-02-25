//second set of test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 25 February 2013

#include "test2.h"

int main(int argc, char** argv){
  if (CheckSaving(OUTPUT_DIR) != 0)
  {
    printf("ERROR!\n");
    return -1;
  }
  //now set up, start, and grab image from camera
  fc2Context tempContext;
  check_point_grey(fc2CreateContext(&tempContext));
  //check number of cameras
  unsigned int numCams;
  check_point_grey(fc2GetNumOfCameras(tempContext, &numCams));
  check_point_grey(fc2DestroyContext(tempContext));
  if (numCams == 0)
  { //no cameras
    printf("No cameras found, exiting.\n");
    return -1;
  } 
  else //multiple cameras
  {
    printf("Found %d cameras\n", numCams);
    //struct point_grey *pg_ptr[numCams];
    fc2Context contexts[numCams];
    fc2PGRGuid guid;
    fc2Image raw_image, converted_image;
    char camName[numCams][512];
    for (int i = 0; i < numCams; i++) //initialization loop
    {
      check_point_grey(fc2CreateContext(&contexts[i]));
      check_point_grey(fc2GetCameraFromIndex(contexts[i], i, &guid));
      check_point_grey(fc2Connect(contexts[i], &guid));
      check_point_grey(fc2SetDefaultColorProcessing(C_COLOR_PROC));
      check_point_grey(fc2SetVideoModeAndFrameRate(contexts[i],
						   C_VID_MODE,
						   C_F_RATE));
      PrintCameraInfo(contexts[i]);
      AssignName(contexts[i], camName[i]);
      
      /* pg_ptr[i] = point_grey_setup(i); */

      /* printf("completed point_grey_setup(%d)\n",i); */

      /* check_point_grey(fc2StartCapture(pg_ptr[i]->context)); */
      
      //NOT WORKING HERE BUT SHOULD
      //check_point_grey(fc2StartCapture(contexts[i]));

      printf("completed initialization loop iteration %d, %s\n",i,camName[i]);
    } // initialization loop
    check_point_grey(fc2CreateImage(&raw_image));
    check_point_grey(fc2CreateImage(&converted_image));
    Imlib_Image temp_image;
    printf("created images\n");

    //DOESN'T WORK
    /* fc2Context *pContexts = contexts; */
    /* fc2Error error = fc2StartSyncCapture(numCams, pContexts); */
    /* printf("startsynccapture returned\n"); */
      
    for (int i = 0; i < numCams; i++) //picture taking loop
    {
      check_point_grey(fc2StartCapture(contexts[i]));
      check_point_grey(fc2RetrieveBuffer(contexts[i],&raw_image));
      check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,&raw_image,
					 &converted_image));
      temp_image = imlib_create_image_using_copied_data(converted_image.cols,
							converted_image.rows,
							(unsigned int *)
							converted_image.pData);
      imlib_context_set_image(temp_image);
      char filename[512];
      sprintf(filename,"%s%stest.jpg",OUTPUT_DIR,camName[i]);
      imlib_save_image(filename);
      printf("Saved %s\n",filename);
      //image saved, now clean up
      imlib_free_image_and_decache();
      check_point_grey(fc2StopCapture(contexts[i]));
      //remove(filename);
      
    } //picture taking loop
    check_point_grey(fc2DestroyImage(&raw_image));
    check_point_grey(fc2DestroyImage(&converted_image));
    for (int i = 0; i < numCams; i++) //cleanup loop
    {
      //HAD TO MOVE INTO PICTURE TAKING LOOP
      //check_point_grey(fc2StopCapture(contexts[i]));

      check_point_grey(fc2DestroyContext(contexts[i]));
      printf("completed cleanup loop iteration %d\n",i);
      /* point_grey_stop_and_cleanup(pg_ptr[i]); */
      
      /* printf("completed point_grey_stop_and_cleanup(pg_ptr[%d])\n",i); */
    } //cleanup loop
      
  }


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

int CheckSaving(char *dir)
{
  struct stat sb;
  if (!(stat(dir, &sb) == 0 && S_ISDIR(sb.st_mode)))
  {
    if (mkdir(dir, S_IRWXU | S_IRGRP | S_IROTH | S_IXGRP | S_IXOTH) != 0)
    {
      printf("Error creating directory %s\n",dir);
      return -1;
    }
  }
  char tempFileName[512];
  sprintf(tempFileName, "%stest.txt",dir);
  FILE* tempFile = fopen(tempFileName, "w+");
  if (tempFile == NULL)
  {
    printf("Failed to create file in current folder.  Please check permissions.\n");
    return -1;
  }
  fclose(tempFile);
  remove(tempFileName);
  //if we get here, we know the directory exists and we can write to it
  return 0;
}

struct point_grey *point_grey_setup(int num)
{
  struct point_grey *pg =
    (struct point_grey *)point_grey_malloc(sizeof(struct point_grey));
  check_point_grey(fc2CreateContext(&pg->context));
  check_point_grey(fc2GetCameraFromIndex(pg->context,num,&pg->guid));
  check_point_grey(fc2Connect(pg->context,&pg->guid));
  check_point_grey(fc2SetDefaultColorProcessing(C_COLOR_PROC));
  check_point_grey(fc2SetVideoModeAndFrameRate(pg->context,
  					       C_VID_MODE,
  					       C_F_RATE));
  PrintCameraInfo(pg->context);
  check_point_grey(fc2CreateImage(&pg->raw_image));
  check_point_grey(fc2CreateImage(&pg->converted_image));
  return pg;
}


void *point_grey_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) point_grey_error("Out of memory");
  return p;
}

void point_grey_stop_and_cleanup(struct point_grey *pg) 
{
  check_point_grey(fc2StopCapture(pg->context));
  check_point_grey(fc2DestroyContext(pg->context));
  check_point_grey(fc2DestroyImage(&pg->raw_image));
  check_point_grey(fc2DestroyImage(&pg->converted_image));
  free(pg);
}


void AssignName(fc2Context context, char *name) 
{
  fc2CameraInfo camInfo;
  check_point_grey(fc2GetCameraInfo(context, &camInfo));
  if (camInfo.serialNumber == front_cam_serial)
  {
    printf("Front camera identified.\n");
    sprintf(name, "Front_camera_");
  }
  else if (camInfo.serialNumber == pano_cam_serial)
  {
    printf("Panoramic camera identified.\n");
    sprintf(name, "Panoramic_camera_");
  }
  else
  {
    printf("Serial number not recognized.\n");
    sprintf(name, "ERROR!!!");
  }
}
