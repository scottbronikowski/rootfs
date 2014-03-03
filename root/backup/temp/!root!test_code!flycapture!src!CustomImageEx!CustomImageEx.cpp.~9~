//=============================================================================
// Copyright © 2008 Point Grey Research, Inc. All Rights Reserved.
//
// This software is the confidential and proprietary information of Point
// Grey Research, Inc. ("Confidential Information").  You shall not
// disclose such Confidential Information and shall use it only in
// accordance with the terms of the license agreement you entered into
// with PGR.
//
// PGR MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF THE
// SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
// IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE, OR NON-INFRINGEMENT. PGR SHALL NOT BE LIABLE FOR ANY DAMAGES
// SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING OR DISTRIBUTING
// THIS SOFTWARE OR ITS DERIVATIVES.
//=============================================================================
//=============================================================================
// $Id: CustomImageEx.cpp,v 1.20 2010-02-26 23:24:47 soowei Exp $
//=============================================================================

#include "stdafx.h"
#include "stdio.h"

#include "FlyCapture2.h"

#include <sys/time.h>

using namespace FlyCapture2;

//globals
const unsigned int front_cam_serial = 12262775;
const unsigned int pano_cam_serial  = 13282227;

//prototypes
void PrintBuildInfo();
void PrintCameraInfo( CameraInfo* pCamInfo );
void PrintFormat7Capabilities( Format7Info fmt7Info );
void PrintError( Error error );
double current_time(void);

int main(int /*argc*/, char** /*argv*/)
{
    PrintBuildInfo();

    const Mode k_fmt7Mode = MODE_0;
    const PixelFormat k_fmt7PixFmt = PIXEL_FORMAT_RAW8;
    const int k_numImages = 100;

    Error error;

    // Since this application saves images in the current folder
    // we must ensure that we have permission to write to this folder.
    // If we do not have permission, fail right away.
	FILE* tempFile = fopen("test.txt", "w+");
	if (tempFile == NULL)
	{
		printf("Failed to create file in current folder.  Please check permissions.\n");
		return -1;
	}
	fclose(tempFile);
	remove("test.txt");

    BusManager busMgr;
    unsigned int numCameras;
    error = busMgr.GetNumOfCameras(&numCameras);
    if (error != PGRERROR_OK)
    {
        PrintError( error );
        return -1;
    }

    printf( "Number of cameras detected: %u\n", numCameras );

    if ( numCameras < 1 )
    {
        printf( "Insufficient number of cameras... exiting\n" );
        return -1;
    }

    PGRGuid guid[numCameras];
    Camera cam[numCameras];
    CameraInfo camInfo[numCameras];
    for (unsigned int i = 0; i < numCameras; i++) //setup/init loop
    {
      error = busMgr.GetCameraFromIndex(i, &guid[i]);
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }
      
      // Connect to a camera
      error = cam[i].Connect(&guid[i]);
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }

      // Get the camera information
      error = cam[i].GetCameraInfo(&camInfo[i]);
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }
      
      PrintCameraInfo(&camInfo[i]);        

      // Query for available Format 7 modes
      Format7Info fmt7Info;
      bool supported;
      fmt7Info.mode = k_fmt7Mode;
      error = cam[i].GetFormat7Info( &fmt7Info, &supported );
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }
      
      PrintFormat7Capabilities( fmt7Info );

      if ( (k_fmt7PixFmt & fmt7Info.pixelFormatBitField) == 0 )
      {
        // Pixel format not supported!
	printf("Pixel format is not supported\n");
        return -1;
      }
    
      Format7ImageSettings fmt7ImageSettings;
      fmt7ImageSettings.mode = k_fmt7Mode;
      fmt7ImageSettings.pixelFormat = k_fmt7PixFmt;
      if (camInfo[i].serialNumber == front_cam_serial)
      {
	fmt7ImageSettings.width = 800;//1200;//fmt7Info.maxWidth;
	fmt7ImageSettings.height = 600;//820;//fmt7Info.maxHeight;
	fmt7ImageSettings.offsetX = (fmt7Info.maxWidth - fmt7ImageSettings.width) / 2;
	fmt7ImageSettings.offsetY = (fmt7Info.maxHeight - fmt7ImageSettings.height) / 2;
      }
      else if (camInfo[i].serialNumber == pano_cam_serial)
      {
	fmt7ImageSettings.width = 1240;//fmt7Info.maxWidth;
	fmt7ImageSettings.height = 934;//fmt7Info.maxHeight;
	fmt7ImageSettings.offsetX = 34;
	fmt7ImageSettings.offsetY = 14;
      }
      else
      {
	printf("ERROR! Camera serial number not recognized!");
	return -1;
      }
      
      printf("Image size: %d x %d\n", fmt7ImageSettings.width, fmt7ImageSettings.height);

      bool valid;
      Format7PacketInfo fmt7PacketInfo;

      // Validate the settings to make sure that they are valid
      error = cam[i].ValidateFormat7Settings( &fmt7ImageSettings,
					      &valid,
					      &fmt7PacketInfo );
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }
      
      if ( !valid )
      {
        // Settings are not valid
	printf("Format7 settings are not valid\n");
        return -1;
      }
      
      // Set the settings to the camera
      error = cam[i].SetFormat7Configuration( &fmt7ImageSettings,
					   fmt7PacketInfo.recommendedBytesPerPacket );
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }

      // Start capturing images
      error = cam[i].StartCapture();
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }

      // Retrieve frame rate property
      Property frmRate;
      frmRate.type = FRAME_RATE;
      error = cam[i].GetProperty( &frmRate );
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }

      printf( "Frame rate is %3.2f fps\n", frmRate.absValue );
    }

    printf( "Grabbing %d images\n", k_numImages );

    Image rawImage;    
    PixelFormat pixFormat;
    unsigned int rows, cols, stride;
    Image convertedImage;

    double start = current_time();
    for ( int imageCount=0; imageCount < k_numImages; imageCount++ )
    {
      for (unsigned int i = 0; i < numCameras; i++)
      {
        // Retrieve an image
        error = cam[i].RetrieveBuffer( &rawImage );
        if (error != PGRERROR_OK)
        {
	  PrintError( error );
	  continue;
        }
        //printf( "." );

        // Get the raw image dimensions
        rawImage.GetDimensions( &rows, &cols, &stride, &pixFormat );

        // Convert the raw image
        error = rawImage.Convert( PIXEL_FORMAT_BGRU, &convertedImage );
        if (error != PGRERROR_OK)
        {
            PrintError( error );
            return -1;
        }

	printf("Captured %u-%d\n",camInfo[i].serialNumber, imageCount);

	// if (imageCount == (k_numImages - 1))
	// {
	//   // Create a unique filename
	//   char filename[512];
	//   sprintf( filename, "%u-%d.ppm", camInfo[i].serialNumber, imageCount );

	//   // Save the image. If a file format is not passed in, then the file
	//   // extension is parsed to attempt to determine the file format.
	//   error = convertedImage.Save( filename );
	//   if (error != PGRERROR_OK)
	//   {
        //     PrintError( error );
        //     return -1;
	//   }
	//   printf("Saved %s\n",filename);
	// }
      }

    }
    double stop = current_time();
    //check elapsed time
    double elapsed = stop - start;
    double images_per_sec = (double)k_numImages / elapsed;
    printf( "\nFinished grabbing images\n" );
    printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
	   k_numImages, elapsed, images_per_sec);

    
    //grab and save one last image from each camera, after time has been measured
    for (unsigned int i = 0; i < numCameras; i++)
    {
      // Retrieve an image
      error = cam[i].RetrieveBuffer( &rawImage );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	continue;
      }
      //printf( "." );
      
      // Get the raw image dimensions
      rawImage.GetDimensions( &rows, &cols, &stride, &pixFormat );
      
      // Convert the raw image
      error = rawImage.Convert( PIXEL_FORMAT_BGRU, &convertedImage );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	return -1;
      }
      
      // Create a unique filename
      char filename[512];
      sprintf( filename, "%u-final.ppm", camInfo[i].serialNumber);
      
      // Save the image. If a file format is not passed in, then the file
      // extension is parsed to attempt to determine the file format.
      error = convertedImage.Save( filename );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	return -1;
      }
      printf("Saved %s\n",filename);
    }
      

    for (unsigned int i = 0; i < numCameras; i++)
    {
      // Stop capturing images
      error = cam[i].StopCapture();
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }      

      // Disconnect the camera
      error = cam[i].Disconnect();
      if (error != PGRERROR_OK)
      {
        PrintError( error );
        return -1;
      }
    }
      
    printf( "Done!\n" );
 

	return 0;
}


void PrintBuildInfo()
{
    FC2Version fc2Version;
    Utilities::GetLibraryVersion( &fc2Version );
    char version[128];
    sprintf( 
        version, 
        "FlyCapture2 library version: %d.%d.%d.%d\n", 
        fc2Version.major, fc2Version.minor, fc2Version.type, fc2Version.build );

    printf( "%s", version );

    char timeStamp[512];
    sprintf( timeStamp, "Application build date: %s %s\n\n", __DATE__, __TIME__ );

    printf( "%s", timeStamp );
}

void PrintCameraInfo( CameraInfo* pCamInfo )
{
    printf(
        "\n*** CAMERA INFORMATION ***\n"
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

void PrintFormat7Capabilities( Format7Info fmt7Info )
{
    printf(
        "Max image pixels: (%u, %u)\n"
        "Image Unit size: (%u, %u)\n"
        "Offset Unit size: (%u, %u)\n"
        "Pixel format bitfield: 0x%08x\n",
        fmt7Info.maxWidth,
        fmt7Info.maxHeight,
        fmt7Info.imageHStepSize,
        fmt7Info.imageVStepSize,
        fmt7Info.offsetHStepSize,
        fmt7Info.offsetVStepSize,
        fmt7Info.pixelFormatBitField );
}

void PrintError( Error error )
{
    error.PrintErrorTrace();
}

double current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

