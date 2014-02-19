//Test functions for Point Grey Chameleon cameras on Gumstix
//built using C API in flycapture.2.6.3.2_armhf
//starting file was FlyCapture2Test_C.c
//Author: Scott Bronikowski
//Date: 13 February 2013

#include <stdio.h>
#include "C/FlyCapture2_C.h"
#include "RoverCamDefs.h"
#include <sys/stat.h>

//prototypes
void PrintBuildInfo();
void PrintCameraInfo(fc2Context context);
void SetTimeStamping(fc2Context context, BOOL enableTimeStamp);
void GrabImages(fc2Context context, int numImagesToGrab);



int main(int argc, char** argv)
{        
    fc2Error error;
    fc2Context context;
    fc2PGRGuid guid;
    unsigned int numCameras = 0;    
    const int k_numImages = 100;

    // Since this application saves images in the OUTPUT_DIR folder
    // we must ensure that the folder exists and we have permission 
    //to write to this folder. If we do not have permission, fail right away.
    struct stat sb;

    if (!(stat(OUTPUT_DIR, &sb) == 0 && S_ISDIR(sb.st_mode)))
    {
      printf("Directory %s NOT found\n",OUTPUT_DIR);
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



    PrintBuildInfo();

    error = fc2CreateContext( &context );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2CreateContext: %d\n", error );
        return 0;
    }        

    error = fc2GetNumOfCameras( context, &numCameras );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2GetNumOfCameras: %d\n", error );
        return 0;
    }

    if ( numCameras == 0 )
    {
        // No cameras detected
        printf( "No cameras detected.\n");
        return 0;
    }

    // Get the 0th camera
    error = fc2GetCameraFromIndex( context, 0, &guid );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2GetCameraFromIndex: %d\n", error );
        return 0;
    }    

    error = fc2Connect( context, &guid );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2Connect: %d\n", error );
        return 0;
    }

    PrintCameraInfo( context );    

    SetTimeStamping( context, TRUE );

    error = fc2StartCapture( context );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2StartCapture: %d\n", error );
        return 0;
    }

    GrabImages( context, k_numImages );   

    error = fc2StopCapture( context );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2StopCapture: %d\n", error );
        return 0;
    }

    error = fc2DestroyContext( context );
    if ( error != FC2_ERROR_OK )
    {
        printf( "Error in fc2DestroyContext: %d\n", error );
        return 0;
    }

    printf( "Done! Press Enter to exit...\n" );
    getchar();

	return 0;
}




void PrintBuildInfo()
{
  fc2Version version;
  char versionStr[512];
  char timeStamp[512];
  
  fc2GetLibraryVersion( &version );
  
  sprintf(versionStr, 
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
  
  printf("\n*** CAMERA INFORMATION ***\n"
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

void SetTimeStamping( fc2Context context, BOOL enableTimeStamp )
{
  fc2Error error;
  fc2EmbeddedImageInfo embeddedInfo;
  
  error = fc2GetEmbeddedImageInfo( context, &embeddedInfo );
  if ( error != FC2_ERROR_OK )
  {
    printf( "Error in fc2GetEmbeddedImageInfo: %d\n", error );
  }
  
  if ( embeddedInfo.timestamp.available != 0 )
  {       
    embeddedInfo.timestamp.onOff = enableTimeStamp;
  }    
  
  error = fc2SetEmbeddedImageInfo( context, &embeddedInfo );
  if ( error != FC2_ERROR_OK )
  {
    printf( "Error in fc2SetEmbeddedImageInfo: %d\n", error );
  }
}


void GrabImages( fc2Context context, int numImagesToGrab )
{
  fc2Error error;
  fc2Image rawImage;
  fc2Image convertedImage;
  fc2TimeStamp prevTimestamp = {0};
  int i;
  
  error = fc2CreateImage( &rawImage );
  if ( error != FC2_ERROR_OK )
  {
    printf( "Error in fc2CreateImage: %d\n", error );
  }
  
  error = fc2CreateImage( &convertedImage );
  if ( error != FC2_ERROR_OK )
  {
    printf( "Error in fc2CreateImage: %d\n", error );
  }
  
  // If externally allocated memory is to be used for the converted image,
  // simply assigning the pData member of the fc2Image structure is
  // insufficient. fc2SetImageData() should be called in order to populate
  // the fc2Image structure correctly. This can be done at this point,
  // assuming that the memory has already been allocated.
  
  for ( i=0; i < numImagesToGrab; i++ )
  {
    // Retrieve the image
    error = fc2RetrieveBuffer( context, &rawImage );
    if ( error != FC2_ERROR_OK )
    {
      printf( "Error in retrieveBuffer: %d\n", error);
    }
    else
    {
      // Get and print out the time stamp
      fc2TimeStamp ts = fc2GetImageTimeStamp( &rawImage);
      int diff = (ts.cycleSeconds - prevTimestamp.cycleSeconds) * 8000
	+ (ts.cycleCount - prevTimestamp.cycleCount);
      prevTimestamp = ts;
      printf( 
	     "timestamp [%d %d] - %d\n", 
	     ts.cycleSeconds, 
	     ts.cycleCount, 
	     diff );
    }       
  }
  
  if ( error == FC2_ERROR_OK )
  {
    // Convert the final image to RGB
    error = fc2ConvertImageTo(FC2_PIXEL_FORMAT_BGR, &rawImage, &convertedImage);
    if ( error != FC2_ERROR_OK )
    {
      printf( "Error in fc2ConvertImageTo: %d\n", error );
        }
    
    // Save it to PNG
    printf("Saving the last image to fc2TestImage.png \n");
    error = fc2SaveImage( &convertedImage, "fc2TestImage.png", FC2_PNG );
    if ( error != FC2_ERROR_OK )
    {
      printf( "Error in fc2SaveImage: %d\n", error );
      printf( "Please check write permissions.\n");
    }
  }
  
  error = fc2DestroyImage( &rawImage );
  if ( error != FC2_ERROR_OK )
  {
        printf( "Error in fc2DestroyImage: %d\n", error );
  }
  
  error = fc2DestroyImage( &convertedImage );
  if ( error != FC2_ERROR_OK )
  {
    printf( "Error in fc2DestroyImage: %d\n", error );
  }
}
