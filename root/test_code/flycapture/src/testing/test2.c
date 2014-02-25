//second set of test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 25 February 2013

#include "test2.h"

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
      if (CheckSaving(OUTPUT_DIR) == 0)
      {
	write_flag = TRUE;
	printf("Saving final image.\n");
      }
    }
    else
    {
      printf("NO saving.\n");
    }
  }

  //now set up, start, and grab image from camera
  unsigned int numCams = point_grey_init();
  if (numCams == 0)
  { //no cameras
    printf("No cameras found, exiting.\n");
    return -1;
  } 
  //if we get here, we know we have at least 1 camera
  
  printf("Found %d cameras\n", numCams);
  struct point_grey *pg_ptr[numCams];
  for (int i = 0; i < numCams; i++) //initialization loop
  {
    pg_ptr[i] = point_grey_setup(i);
    //PrintCameraInfo(pg_ptr[i]->context);
    
    //NOT WORKING HERE BUT SHOULD
    //check_point_grey(fc2StartCapture(contexts[i]));
    
    printf("completed initialization loop iteration %d, %s\n",i,pg_ptr[i]->name);
  } // initialization loop
  
  Imlib_Image temp_image;
  
  //DOESN'T WORK
  /* fc2Context *pContexts = contexts; */
  /* fc2Error error = fc2StartSyncCapture(numCams, pContexts); */
  /* printf("startsynccapture returned\n"); */
  double start = current_time();
  for (int j = 0; j < numPics; j++) //loop through numPics
  {
    for (int i = 0; i < numCams; i++) //picture taking loop
    {
      temp_image = point_grey_get_frame_with_start_stop(pg_ptr[i]); 
      printf("%s image #%d\n",pg_ptr[i]->name,j);
      if ((j == (numPics - 1)) && write_flag)
      {//save the final image from each camera
	SaveImlibImage(temp_image, pg_ptr[i]->name);
      }
      else
      {
	imlib_context_set_image(temp_image);
	//this is where we would send the image
	imlib_free_image_and_decache();
      }
    } //picture taking loop
  }    
  double stop = current_time();
  //check elapsed time
  double elapsed = stop - start;
  double images_per_sec = (double)numPics / elapsed;
  printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
	 numPics, elapsed, images_per_sec);

  for (int i = 0; i < numCams; i++) //cleanup loop
  {
    //HAD TO MOVE INTO PICTURE TAKING LOOP
    //check_point_grey(fc2StopCapture(contexts[i]));
    
    point_grey_cleanup(pg_ptr[i]);
    //printf("completed cleanup loop iteration %d\n",i);
  } //cleanup loop  
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

unsigned int point_grey_init(void)
{
  fc2Context tempContext;
  check_point_grey(fc2CreateContext(&tempContext));
  unsigned int numCams;
  check_point_grey(fc2GetNumOfCameras(tempContext, &numCams));
  check_point_grey(fc2DestroyContext(tempContext));
  return numCams;
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
  AssignName(pg->context, pg->name);
  check_point_grey(fc2CreateImage(&pg->raw_image));
  check_point_grey(fc2CreateImage(&pg->converted_image));
  return pg;
}


void *point_grey_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) point_grey_error("Out of memory");
  return p;
}
void point_grey_stop(struct point_grey *pg)
{
  check_point_grey(fc2StopCapture(pg->context));
}

void point_grey_cleanup(struct point_grey *pg) 
{
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
    printf("\nFront camera identified.\n");
    sprintf(name, "Front_camera_");
  }
  else if (camInfo.serialNumber == pano_cam_serial)
  {
    printf("\nPanoramic camera identified.\n");
    sprintf(name, "Panoramic_camera_");
  }
  else
  {
    printf("\nSerial number not recognized.\n");
    sprintf(name, "ERROR!!!");
  }
}


Imlib_Image point_grey_get_frame(struct point_grey *pg)
{
  check_point_grey(fc2RetrieveBuffer(pg->context,&pg->raw_image));
  check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,
				     &pg->raw_image,
				     &pg->converted_image));
  
  return imlib_create_image_using_copied_data(pg->converted_image.cols,
					      pg->converted_image.rows,
					      (unsigned int *)
					      pg->converted_image.pData);
}

Imlib_Image point_grey_get_frame_with_start_stop(struct point_grey *pg)
{
  point_grey_start(pg);
  check_point_grey(fc2RetrieveBuffer(pg->context,&pg->raw_image));
  check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,
				     &pg->raw_image,
				     &pg->converted_image));
  point_grey_stop(pg);
  return imlib_create_image_using_copied_data(pg->converted_image.cols,
					      pg->converted_image.rows,
					      (unsigned int *)
					      pg->converted_image.pData);
}

void point_grey_start(struct point_grey *pg)
{
 check_point_grey(fc2StartCapture(pg->context));
}

void SaveImlibImage(Imlib_Image temp_image, char *name)
{
  imlib_context_set_image(temp_image);
  char filename[512];
  sprintf(filename,"%s%stest.jpg",OUTPUT_DIR,name);
  imlib_save_image(filename);
  printf("Saved %s\n",filename);
  //image saved, now clean up
  imlib_free_image_and_decache();
}

double current_time(void) {
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) point_grey_error("gettimeofday failed");
  /* needs work: Will it convert division into multiplication? */
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}
