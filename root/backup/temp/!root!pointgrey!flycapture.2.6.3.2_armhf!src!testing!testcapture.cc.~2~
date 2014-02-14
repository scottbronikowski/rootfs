//Test functions for Point Grey cameras on Gumstix
//built using API from flycapture.2.6.3.2_armhf
//starting file was FlyCapture2Test.cpp
//Author: Scott Bronikowski
//Date: 13 February 2014

#include <stdio.h>
#include "FlyCapture2.h"
#include "RoverCamDefs.h"

using namespace FlyCapture2;

//prototypes
void PrintBuildInfo();
void PrintCameraInfo(CameraInfo* pCamInfo);
void PrintError(Error error);
int RunSingleCamera(PGRGuid guid, int k_numImages);

int main(int argc, char** argv)
{  
  //PrintBuildInfo();

  Error error;

  // Since this application saves images in the current folder
  // we must ensure that we have permission to write to this folder.
  // If we do not have permission, fail right away.
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

  
  BusManager busMgr;
  unsigned int numCameras;
  error = busMgr.GetNumOfCameras(&numCameras);
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    return -1;
  }
  
  printf( "Number of cameras detected: %u\n", numCameras );
  
  for (unsigned int i=0; i < numCameras; i++)
  {
    PGRGuid guid;
    error = busMgr.GetCameraFromIndex(i, &guid);
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    //RunSingleCamera( guid );
    RunSingleCamera(guid, numPics);
    
    // //connect to a camera	
    // Camera cam;
    // error = cam.Connect(&guid);
    // if (error != PGRERROR_OK)
    // {
    //   PrintError(error);
    //   return -1;
    // }
    
    // //get camera info
    // CameraInfo camInfo;
    // error = cam.GetCameraInfo(&camInfo);
    // if (error != PGRERROR_OK)
    // {
    //   PrintError(error);
    //   return -1;
    // }
    
    // PrintCameraInfo(&camInfo);
    
    // //now compare serial number 
    // if (camInfo.serialNumber == front_cam_serial)
    // {
    //   printf("This is the front camera.\n");
    // } 
    // else if (camInfo.serialNumber == pano_cam_serial)
    // {
    //   printf("This is the panoramic camera.\n");
    // }
    // else
    // {
    //   printf("Serial Number not recognized.\n");
    // }
    
  }
  
  printf( "Done! Press Enter to exit...\n" );
  getchar();
  
  return 0;
}

void PrintBuildInfo()
{
  FC2Version fc2Version;
  Utilities::GetLibraryVersion( &fc2Version );
  char version[128];
  sprintf(version, 
	  "FlyCapture2 library version: %d.%d.%d.%d\n", 
	  fc2Version.major, fc2Version.minor, fc2Version.type, fc2Version.build );
  
  printf( version );
  
  char timeStamp[512];
  sprintf( timeStamp, "Application build date: %s %s\n\n", __DATE__, __TIME__ );
  
  printf( timeStamp );
}

void PrintCameraInfo( CameraInfo* pCamInfo )
{
  printf("\n*** CAMERA INFORMATION ***\n"
	 "Serial number - %u\n"
	 "Camera model - %s\n"
	 "Camera vendor - %s\n"
	 "Sensor - %s\n"
	 "Resolution - %s\n"
	 "Firmware version - %s\n"
	 "Firmware build time - %s\n\n",
	 pCamInfo->serialNumber,
	 pCamInfo->modelName,
	 pCamInfo->vendorName,
	 pCamInfo->sensorInfo,
	 pCamInfo->sensorResolution,
	 pCamInfo->firmwareVersion,
	 pCamInfo->firmwareBuildTime );
}

void PrintError( Error error )
{
  error.PrintErrorTrace();
}
int RunSingleCamera( PGRGuid guid, int k_numImages)
{
  //const int k_numImages = 10;

    Error error;
    Camera cam;

    // Connect to a camera
    error = cam.Connect(&guid);
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }

    // Get the camera information
    CameraInfo camInfo;
    error = cam.GetCameraInfo(&camInfo);
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }

    PrintCameraInfo(&camInfo);        

    //now compare serial number 
    char fileroot[6];
    if (camInfo.serialNumber == front_cam_serial)
    {
      printf("This is the front camera.\n");
      //fileroot = "front";
      sprintf(fileroot, "front");
    } 
    else if (camInfo.serialNumber == pano_cam_serial)
    {
      printf("This is the panoramic camera.\n");
      //fileroot = "panor";
      sprintf(fileroot, "panor");
    }
    else
    {
      printf("Serial Number not recognized.\n");
      //fileroot = "error";
      sprintf(fileroot,"error");
    }
    
    // Start capturing images
    error = cam.StartCapture();
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }

    Image rawImage;    
    for ( int imageCnt=0; imageCnt < k_numImages; imageCnt++ )
    {                
        // Retrieve an image
        error = cam.RetrieveBuffer( &rawImage );
        if (error != PGRERROR_OK)
        {
            PrintError( error );
            continue;
        }

        printf( "Grabbed image %d\n", imageCnt );

        // Create a converted image
        Image convertedImage;

        // Convert the raw image
        error = rawImage.Convert( PIXEL_FORMAT_MONO16, &convertedImage );
        if (error != PGRERROR_OK)
        {
            PrintError( error );
            return -1;
        }  

        // Create a unique filename
        char filename[512];
	sprintf(filename, "%s%s%d.ppm",OUTPUT_DIR,fileroot,imageCnt);
        //sprintf( filename, "FlyCapture2Test-%u-%d.pgm", camInfo.serialNumber, imageCnt );

        // Save the image. If a file format is not passed in, then the file
        // extension is parsed to attempt to determine the file format.
        error = convertedImage.Save( filename );
        if (error != PGRERROR_OK)
        {
            PrintError( error );
            return -1;
        }  
    }            

    // Stop capturing images
    error = cam.StopCapture();
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }      

    // Disconnect the camera
    error = cam.Disconnect();
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }

    return 0;
}
