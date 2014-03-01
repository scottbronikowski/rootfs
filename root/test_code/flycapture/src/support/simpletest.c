//simple test for using multiple Chameleon cameras with 
//Flycapture 2.6.3.2 (C API) under Ubuntu 12.04

//compile with:
//gcc -Wall -g -I/usr/include/flycapture -std=gnu99 -o simpletest simpletest.c -L/usr/lib -lflycapture-c `imlib2-config --cflags --libs`

//Author: Scott Bronikowski
//Date: 27 February 2014

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include "C/FlyCapture2_C.h"
#include <sys/stat.h>
#include <sys/time.h>
#include <Imlib2.h>
#include <string.h>

//defines
#define OUTPUT_DIR  "/tmp/images/"
#ifndef TRUE
#define TRUE (0==0)
#endif
#ifndef FALSE
#define FALSE (0!=0)
#endif

//macros
#define check_point_grey(f) {						\
    fc2Error error = f;                                                 \
    if (error!=FC2_ERROR_OK) {						\
      fprintf(stderr, "%s:%d: Point Grey error %d\n", __FUNCTION__, __LINE__, error); \
      abort();                                                          \
    }                                                                   \
  }

#define point_grey_error(...) {				\
    fprintf(stderr, "%s:%d: ", __FUNCTION__, __LINE__);	\
    fprintf(stderr, __VA_ARGS__);			\
    fprintf(stderr, "\n");				\
    exit(-1);						\
  }

//structures
struct point_grey {
  fc2Context context;
  fc2PGRGuid guid;
  fc2Image raw_image, converted_image;
  char name[512];
};

//prototypes
void PrintBuildInfo(void);
void PrintCameraInfo(fc2Context context);
int CheckSaving(char *dir);
void *point_grey_malloc(size_t size);
void SaveImlibImage(Imlib_Image temp_image, char *name, char *mode_str);
double current_time(void);
void AssignName(fc2Context context, char *name);

int main(int argc, char** argv){
  int numPics = 100;
  fc2VideoMode mode = FC2_VIDEOMODE_640x480Y8;
  char *mode_str = "FC2_VIDEOMODE_640x480Y8";
  fc2FrameRate rate = FC2_FRAMERATE_30;
  char *rate_str = "FC2_FRAMERATE_30";
  int prog_mode;
  int camOffset = 0;

  PrintBuildInfo();
  if (argc != 2) 
  {
    printf("Error: Must chose mode\n");
    printf("Usage: %s {1, 2, 3, 4, 5, 6} \n",argv[0]);
    printf("Modes: 1 = first camera at 1280x960Y8\n"
	   "       2 = second camera at 1280x960Y8\n"
	   "       3 = both cameras at 1280x960Y8\n"
	   "       4 = first camera at 640x480Y8\n"
	   "       5 = second camera at 640x480Y8\n"
	   "       6 = both cameras at 640x480Y8\n");
    return -1;
  }

  prog_mode = atoi(argv[1]);  
  if ((prog_mode > 6) || (prog_mode < 1))
  {
    printf("Must chose valid mode, 1 through 6\n");
  }
  if (CheckSaving(OUTPUT_DIR) != 0)
  {
    printf("Cannot save to %s, please check permissions\n",OUTPUT_DIR);
    return -1;
  }
  //have correct number of arguments and can save
  
  fc2Context tempContext;
  check_point_grey(fc2CreateContext(&tempContext));
  unsigned int numCams;
  check_point_grey(fc2GetNumOfCameras(tempContext, &numCams));
  check_point_grey(fc2DestroyContext(tempContext));
  if (numCams == 0)
  { //no cameras
    printf("No cameras found, exiting.\n");
    return -1;
  } 
  //if we get here, we know we have at least 1 camera connected

  if (prog_mode < 4)
  {
    mode = FC2_VIDEOMODE_1280x960Y8;
    mode_str = "FC2_VIDEOMODE_1280x960Y8";
    rate = FC2_FRAMERATE_15;
    rate_str = "FC2_FRAMERATE_15";
  }
  printf("Using resolution %s and frame rate %s\n",mode_str,rate_str);

  if ((prog_mode == 1) || (prog_mode == 4))
  { // run only the first camera
    numCams = 1;
  }
  if ((prog_mode == 2) || (prog_mode == 5))
  { // run only the second camera
    camOffset = 1;
  }

  printf("Taking %i pictures per camera with %i camera(s).\n",numPics, (numCams - camOffset)); 
  

  struct point_grey *pg_ptr[numCams - camOffset];
  for (int i = 0; i < (numCams - camOffset); i++) //initialization loop
  {
    pg_ptr[i] =
      (struct point_grey *)point_grey_malloc(sizeof(struct point_grey));
    check_point_grey(fc2CreateContext(&pg_ptr[i]->context));
    check_point_grey(fc2GetCameraFromIndex(pg_ptr[i]->context,
					   (i + camOffset),
					   &pg_ptr[i]->guid));
    check_point_grey(fc2Connect(pg_ptr[i]->context,
				&pg_ptr[i]->guid));
    check_point_grey(fc2SetDefaultColorProcessing(FC2_NEAREST_NEIGHBOR_FAST));
    check_point_grey(fc2SetVideoModeAndFrameRate(pg_ptr[i]->context,
						 mode,
						 rate));
    AssignName(pg_ptr[i]->context, pg_ptr[i]->name);
    check_point_grey(fc2CreateImage(&pg_ptr[i]->raw_image));
    check_point_grey(fc2CreateImage(&pg_ptr[i]->converted_image));
    PrintCameraInfo(pg_ptr[i]->context);
    //**CALLING THIS HERE WILL WORK WITH 2 CAMERAS AT 640X480 BUT NOT AT
    //1280X960**
    check_point_grey(fc2StartCapture(pg_ptr[i]->context))
    printf("completed initialization loop iteration %d, %s\n",i,pg_ptr[i]->name);
  } // initialization loop

  Imlib_Image temp_image;
  double start = current_time();

  for (int j = 0; j < numPics; j++) //loop through numPics
  {
    for (int i = 0; i < (numCams - camOffset); i++) //picture taking loop
    {
      check_point_grey(fc2RetrieveBuffer(pg_ptr[i]->context,
					 &pg_ptr[i]->raw_image));
      check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,
					 &pg_ptr[i]->raw_image,
					 &pg_ptr[i]->converted_image));
      temp_image = imlib_create_image_using_copied_data(pg_ptr[i]->converted_image.cols,
							pg_ptr[i]->converted_image.rows,
						  (unsigned int *)
						  pg_ptr[i]->converted_image.pData);


      printf("%simage_%d\n",pg_ptr[i]->name,j);
      if (j == (numPics - 1))
      {//save the final image from each camera
	SaveImlibImage(temp_image, pg_ptr[i]->name, mode_str);
      }
      else
      {
	imlib_context_set_image(temp_image);
	//this is where we would do something else with the image
	imlib_free_image_and_decache();
      }
    } //picture taking loop
  } //numPics loop

  double stop = current_time();
  //check elapsed time
  double elapsed = stop - start;
  double images_per_sec = (double)numPics / elapsed;
  printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
	 numPics, elapsed, images_per_sec);

  for (int i = 0; i < (numCams - camOffset); i++) //cleanup loop
  {
    //**CALLING THIS HERE WILL WORK WITH 2 CAMERAS AT 640X480 BUT NOT AT
    //1280X960**
    check_point_grey(fc2StopCapture(pg_ptr[i]->context));

    check_point_grey(fc2DestroyContext(pg_ptr[i]->context));
    check_point_grey(fc2DestroyImage(&pg_ptr[i]->raw_image));
    check_point_grey(fc2DestroyImage(&pg_ptr[i]->converted_image));
    free(pg_ptr[i]);

    printf("completed cleanup loop iteration %d\n",i);
  } //cleanup loop  
  printf("Program complete!\n");
  return 0; 
}

void PrintBuildInfo()
{
    fc2Version version;
    char versionStr[512];
    char timeStamp[512];

    fc2GetLibraryVersion( &version );

    sprintf( 
        versionStr, 
        "FlyCapture2 library version: %d.%d.%d.%d\n", 
        version.major, version.minor, version.type, version.build );

    printf( "%s", versionStr );

    sprintf( timeStamp, "Application build date: %s %s\n\n", __DATE__, __TIME__ );

    printf( "%s", timeStamp );
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
    printf("Failed to create file in %s.  Please check permissions.\n", dir);
    return -1;
  }
  fclose(tempFile);
  remove(tempFileName);
  //if we get here, we know the directory exists and we can write to it
  return 0;
}

void *point_grey_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) point_grey_error("Out of memory");
  return p;
}

void AssignName(fc2Context context, char *name) 
{
  fc2CameraInfo camInfo;
  check_point_grey(fc2GetCameraInfo(context, &camInfo));
  sprintf(name, "Camera_%d_", camInfo.serialNumber);
  //  printf("Identified: %s\n",name);
}

void SaveImlibImage(Imlib_Image temp_image, char *name, char *mode_str)
{
  imlib_context_set_image(temp_image);
  char filename[512];
  sprintf(filename,"%s%s%s_test.ppm",OUTPUT_DIR,name,mode_str);
  imlib_save_image(filename);
  printf("Saved %s\n",filename);
  //image saved, now clean up
  imlib_free_image_and_decache();
}

double current_time(void) {
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) point_grey_error("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}
