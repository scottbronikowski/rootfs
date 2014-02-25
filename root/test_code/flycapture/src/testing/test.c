//Test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf

//Author: Scott Bronikowski
//Date: 19 February 2013

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include "C/FlyCapture2_C.h"
#include <sys/stat.h>
#include <Imlib2.h>

//defines
#define OUTPUT_DIR  "/tmp/images/"
#define check_point_grey(f) {						\
    fc2Error error = f;                                                 \
    if (error!=FC2_ERROR_OK) {						\
      fprintf(stderr, "%s:%d: Point Grey error %d\n", __FUNCTION__, __LINE__, error); \
      abort();                                                          \
    }                                                                   \
  }
//prototypes
void PrintCameraInfo(fc2Context context);

int main(int argc, char** argv){
  struct stat sb;
  if (!(stat(OUTPUT_DIR, &sb) == 0 && S_ISDIR(sb.st_mode)))
  {
    if (mkdir(OUTPUT_DIR, S_IRWXU | S_IRGRP | S_IROTH | S_IXGRP | S_IXOTH) != 0)
    {
      printf("Error creating directory %s\n",OUTPUT_DIR);
      return -1;
    }
  }
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
  //now set up, start, and grab image from camera
  fc2Context context;
  fc2PGRGuid guid;
  fc2Image raw_image, converted_image;
  Imlib_Image temp_image;
  check_point_grey(fc2CreateContext(&context));
  check_point_grey(fc2GetCameraFromIndex(context,1,&guid));
  check_point_grey(fc2Connect(context,&guid));
  check_point_grey(fc2SetDefaultColorProcessing(FC2_NEAREST_NEIGHBOR_FAST));
  check_point_grey(fc2SetVideoModeAndFrameRate(context,
					       FC2_VIDEOMODE_1280x960Y8,
					       FC2_FRAMERATE_15));
  PrintCameraInfo(context);
  check_point_grey(fc2CreateImage(&raw_image));
  check_point_grey(fc2CreateImage(&converted_image));
  check_point_grey(fc2StartCapture(context));
  check_point_grey(fc2RetrieveBuffer(context,&raw_image));
  check_point_grey(fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGRU,&raw_image,&converted_image));
  temp_image = imlib_create_image_using_copied_data(converted_image.cols,
						    converted_image.rows,
						    (unsigned int *)
						    converted_image.pData);  
  imlib_context_set_image(temp_image);
  char filename[512];
  sprintf(filename,"%stest.jpg",OUTPUT_DIR);
  imlib_save_image(filename);
  printf("Saved %s\n",filename);
  //image saved, now clean up
  imlib_free_image_and_decache();
  check_point_grey(fc2StopCapture(context));
  check_point_grey(fc2DestroyContext(context));
  check_point_grey(fc2DestroyImage(&raw_image));
  check_point_grey(fc2DestroyImage(&converted_image)); 
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
