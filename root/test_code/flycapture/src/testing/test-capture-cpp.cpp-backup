//Test functions for Point Grey cameras on Gumstix
//built using API from flycapture.2.6.3.2_armhf
//starting file was FlyCapture2Test.cpp
//Author: Scott Bronikowski
//Date: 13 February 2014

#include <stdio.h>
#include "FlyCapture2.h"
#include "RoverCamDefs.h"
#include <sys/stat.h>
#include <sys/time.h>
#include "point-grey.h"
#include <Imlib2.h>

using namespace FlyCapture2;

//prototypes
void PrintBuildInfo();
void PrintCameraInfo(CameraInfo* pCamInfo);
void PrintError(Error error);
int RunSingleCamera(PGRGuid guid, int k_numImages);
//int RunAllCameras(PGRGuid guid[], int k_numImages, int numCameras);
int RunAllCameras(int k_numImages, int numCameras, bool write_flag);

int RunMultipleCameras(int k_numImages, int numCameras);
long long int GetTimeInUsec(void);
void ForcePGRY16Mode(Camera cam);


int main(int argc, char** argv)
{  
  //PrintBuildInfo();

  Error error;
  bool write_flag = FALSE;
  int numPics = default_num_pics;
  if (argc < 2)
  {
    printf("Defaulting to %i pictures per camera.\n",numPics);
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

  
  BusManager busMgr;
  unsigned int numCameras;
  error = busMgr.GetNumOfCameras(&numCameras);
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    return -1;
  }
  
  printf( "Number of cameras detected: %u\n", numCameras );
  
  // //PGRGuid guid;
  // PGRGuid guid[numCameras];
  
  // for (unsigned int i=0; i < numCameras; i++)
  // {
  //   error = busMgr.GetCameraFromIndex(i, &guid[i]);
  //   if (error != PGRERROR_OK)
  //   {
  //     PrintError( error );
  //     return -1;
  //   }
    
  // }  //new end of loop
    //RunSingleCamera( guid );
   
    //RunSingleCamera(guid, numPics);
  
  printf("\nAttempting old method\n");
  //RunAllCameras(guid, numPics, numCameras);  
  RunAllCameras(numPics, numCameras, write_flag);  

  //printf("\nAttempting new method\n");
  //RunMultipleCameras(numPics, numCameras);
  
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
    
    //}
  
  printf( "Done! \n" );
  
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
  
  //printf( version );
  fprintf(stderr,"%s",version);
  
  char timeStamp[512];
  sprintf( timeStamp, "Application build date: %s %s\n\n", __DATE__, __TIME__ );
  
  //printf( timeStamp );
  fprintf(stderr,"%s",timeStamp);
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
    //char fileroot[6];
    if (camInfo.serialNumber == front_cam_serial)
    {
      printf("This is the front camera.\n");
      //sprintf(fileroot, "front");
    } 
    else if (camInfo.serialNumber == pano_cam_serial)
    {
      printf("This is the panoramic camera.\n");
      //sprintf(fileroot, "panor");
    }
    else
    {
      printf("Serial Number not recognized.\n");
      //sprintf(fileroot,"error");
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
	//error = rawImage.Convert( PIXEL_FORMAT_MONO16, &convertedImage ); /*seemed to cause crash*/
	//error = rawImage.Convert( PIXEL_FORMAT_MONO8, &convertedImage ); //original
	error = rawImage.Convert( PIXEL_FORMAT_RGBU, &convertedImage );
        if (error != PGRERROR_OK)
        {
            PrintError( error );
            return -1;
        }  
	printf("Converted image size: %u\n",convertedImage.GetDataSize());

	struct point_grey_image *send_image;
	send_image = (point_grey_image*) malloc(sizeof(struct point_grey_image));
	send_image->rows = convertedImage.GetRows();
	send_image->cols = convertedImage.GetCols();
	send_image->data = convertedImage.GetData();
	printf("Rows %u, Cols %u\n",send_image->rows, send_image->cols);
	printf("Converted image in pointer to send_image struct, ready to send\n");
	// unsigned int cImageRows = convertedImage.GetRows();
	// unsigned int cImageCols = convertedImage.GetCols();
	// unsigned char* cImageData = convertedImage.GetData();
	// printf("Rows %u, Cols %u\n",cImageRows, cImageCols);
	// printf("Data %s\n",cImageData);


	//commenting this out to increase speed
        // // Create a unique filename
        // char filename[512];
	// //PNGOption *pOptions = new PNGOption;
	// ImageFileFormat fileFormat = PNG;
	// sprintf(filename, "%s%s%d.png",OUTPUT_DIR,fileroot,imageCnt);
        // //sprintf( filename, "FlyCapture2Test-%u-%d.pgm", camInfo.serialNumber, imageCnt );

        // // Save the image. If a file format is not passed in, then the file
        // // extension is parsed to attempt to determine the file format.
	// //pOptions->compresionLevel = 0;
	// //****this save seems to be slowing things down--send directly over 
	// // socket instead?????
        // error = convertedImage.Save(filename, fileFormat);
        // if (error != PGRERROR_OK)
        // {
        //     PrintError( error );
        //     return -1;
        // }  
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


//int RunAllCameras( PGRGuid guid[], int k_numImages, int numCameras)
int RunAllCameras(int k_numImages, int numCameras, bool write_flag)
{
  
  //PGRGuid guid;
  PGRGuid guid[numCameras];
  BusManager busMgr;
  Error error;
  Camera cam[numCameras];
  char cam_string[numCameras][512];

  const unsigned int k_imageDataFmtReg = 0x1048;
  unsigned int value = 0;
  
  VideoMode* pVideoMode;
  FrameRate* pFrameRate;

  // Connect to all cameras
  for (int i = 0; i < numCameras; i++)
  {
    error = busMgr.GetCameraFromIndex(i, &guid[i]);
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    error = cam[i].Connect(&guid[i]);
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }

    //found this in FlycapWindow::Start
    //    ForcePGRY16Mode(cam[i]);
    error = cam[i].ReadRegister( k_imageDataFmtReg, &value );
    if ( error != PGRERROR_OK )
    {
      // Error
    }
    
    value &= ~(0x1 << 0);
    
    error = cam[i].WriteRegister( k_imageDataFmtReg, value );
    if ( error != PGRERROR_OK )
    {
      // Error
    }

    // Get the camera information
    CameraInfo camInfo;
    error = cam[i].GetCameraInfo(&camInfo);
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    PrintCameraInfo(&camInfo);        
    
    //now compare serial number 
    //char fileroot[6];
    if (camInfo.serialNumber == front_cam_serial)
    {
      printf("This is the front camera.\n");
      sprintf(cam_string[i], "Front_camera_");
      //sprintf(fileroot, "front");
    } 
    else if (camInfo.serialNumber == pano_cam_serial)
    {
      printf("This is the panoramic camera.\n");
      sprintf(cam_string[i], "Panoramic_camera_");
      //sprintf(fileroot, "panor");
      }
    else
    {
      printf("Serial Number not recognized.\n");
      sprintf(cam_string[i], "ERROR!");
      //sprintf(fileroot,"error");
      return -1;
    }

    
    error = cam[i].GetVideoModeAndFrameRate(pVideoMode,pFrameRate);
    // if (error != PGRERROR_OK)
    // {
    //   PrintError( error );
    //   return -1;
    // }
    
    printf("Videomode = %d, framerate = %d\n",pVideoMode,pFrameRate);
    
    // error = cam[i].SetVideoModeAndFrameRate(VID_MODE,F_RATE);
    // if (error != PGRERROR_OK)
    // {
    //   PrintError( error );
    //   printf("Error setting video mode and frame rate. \n"
    // 	     "This example requires cameras to be able to set to %s at %s. \n", 
    // 	     VID_MODE_STR,F_RATE_STR);
    //   printf("If your camera does not support this mode, please edit the "
    // 	     "source code and recompile the application. \n");	
    //   return -1;
    // }
    
    // Start capturing images **SHOULD WORK HERE BUT HANGS
    error = cam[i].StartCapture();
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    // else
    // {
    // 	printf("capture started\n");
    // }
  }
  
  // error = Camera::StartSyncCapture(numCameras, cam);
  // if (error != PGRERROR_OK)
  // {
  //     PrintError( error );
  //     printf("Error calling StartSyncCapture. \n"
  // 	       "Press Enter to exit. \n");
  //     getchar();
  //     return -1;
  // }
  printf("Camera initialization complete, moving to capture with %s at %s\n",
	 VID_MODE_STR, F_RATE_STR);
  
  Image rawImage; // = new Image();    
  Image convertedImage; // = new Image();
  error = rawImage.SetColorProcessing(NEAREST_NEIGHBOR);
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    return -1;
  }
  error = convertedImage.SetColorProcessing(NEAREST_NEIGHBOR);
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    return -1;
  }  
      
  //struct point_grey_image *send_image;
  //send_image = (point_grey_image*) malloc(sizeof(struct point_grey_image));
  char filename[512];
  Imlib_Image temp_image;
  //struct timeval start_time, stop_time;
  //long long int start_time, stop_time;
  //main capture loop--get time here to check speed
  //gettimeofday(&start_time, NULL);
  //start_time = GetTimeInUsec();

  PixelFormat pixelFormat, pixelFormat2;
  

  double start = current_time();
  for ( int imageCnt=0; imageCnt < k_numImages; imageCnt++ )
  {
    for (int i = 0; i < numCameras; i++)
    {
      // // Start capturing images ***WORKS HERE BUT SLOW
      // error = cam[i].StartCapture();
      // if (error != PGRERROR_OK)
      // {
      //   PrintError( error );
      //   return -1;
      // }
      // else
      // {
      //   printf("capture started\n");
      //}
      
      // Retrieve an image
      error = cam[i].RetrieveBuffer( &rawImage );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	continue;
      }
      
      //printf( "%s Grabbed image %d\n", cam_string[i], imageCnt );
      
      // Create a converted image
      
      
      // Convert the raw image
      //error = rawImage.Convert( PIXEL_FORMAT_MONO16, &convertedImage ); /*seemed to cause crash*/
      //error = rawImage.Convert( PIXEL_FORMAT_MONO8, &convertedImage ); //original
      error = rawImage.Convert( PIXEL_FORMAT_BGRU, &convertedImage );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	return -1;
      }  
      //printf("Converted image size: %u\n",convertedImage.GetDataSize());
      
      
      // send_image->rows = convertedImage.GetRows();
      // send_image->cols = convertedImage.GetCols();
      // send_image->data = convertedImage.GetData();
      // //printf("Rows %u, Cols %u\n",send_image->rows, send_image->cols);
      // printf("Converted image in pointer to send_image struct, ready to send\n");

      temp_image = imlib_create_image_using_copied_data(convertedImage.GetCols(),
      							convertedImage.GetRows(),
      							(unsigned int *)
      							convertedImage.GetData());
      imlib_context_set_image(temp_image);
     

      //***SEND DATA HERE BEFORE END OF INNER LOOP***//////
      //  send temp_image????

      //printf("%simage%d\n",cam_string[i],imageCnt);

      //commenting this out to increase speed
      // // Create a unique filename
      // char filename[512];
      // //PNGOption *pOptions = new PNGOption;
      // ImageFileFormat fileFormat = PNG;
      // sprintf(filename, "%s%s%d.png",OUTPUT_DIR,fileroot,imageCnt);
      // //sprintf( filename, "FlyCapture2Test-%u-%d.pgm", camInfo.serialNumber, imageCnt );
      
      //save final image
      if ((imageCnt == (k_numImages - 1)) && write_flag)
      {
	sprintf(filename,"%scpp-%sfinal.ppm",OUTPUT_DIR,cam_string[i]);
	imlib_save_image(filename);
	printf("Saved %s\n",filename);
      }

      // // Save the image. If a file format is not passed in, then the file
      // // extension is parsed to attempt to determine the file format.
      // //pOptions->compresionLevel = 0;
      // //****this save seems to be slowing things down--send directly over 
      // // socket instead?????
      // error = convertedImage.Save(filename, fileFormat);
      // if (error != PGRERROR_OK)
      // {
      //     PrintError( error );
      //     return -1;
      // }  
      
      // // Stop capturing images ****NOT SURE WHY THIS WORKS HERE and not in other loop
      // error = cam[i].StopCapture();
      // if (error != PGRERROR_OK)
      // {
      //   PrintError( error );
      //   return -1;
      // }      

      imlib_free_image_and_decache();

    } //numCameras loop         
  }  //numImages loop
  //stop_time = GetTimeInUsec();
  double stop = current_time();
  //do some math to show how many images over time
  double elapsed = stop - start;
  double images_per_sec = (double)k_numImages / elapsed;
  printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
	 k_numImages, elapsed, images_per_sec);
  // long long int elapsed = stop_time - start_time;
  // float images_per_sec = (float)k_numImages / ((float)elapsed / 1000000);
  // printf("Summary: %i images per camera  taken in %lli microseconds (%f images/sec/cam)\n",
  // 	 k_numImages, elapsed, images_per_sec );
  
  //don't need send_image anymore, so free it
  //free(send_image);
  
  //loop through cameras one more time to stop & disconnect
  for (int i = 0; i < numCameras; i++)
  {
    // Stop capturing images **SHOULD WORK HERE
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
  return 0;
}

int RunMultipleCameras(int k_numImages, int numCameras)
{
  Error error;
  BusManager busMgr;
  Camera** ppCameras = new Camera*[numCameras];

  // Connect to all detected cameras and attempt to set them to
  // a common video mode and frame rate
  for (int i = 0; i < numCameras; i++)
  {
    ppCameras[i] = new Camera();
    
    PGRGuid guid;
    error = busMgr.GetCameraFromIndex( i, &guid );
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    // Connect to a camera
    error = ppCameras[i]->Connect( &guid );
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    // Get the camera information
    CameraInfo camInfo;
    error = ppCameras[i]->GetCameraInfo( &camInfo );
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      return -1;
    }
    
    PrintCameraInfo(&camInfo); 
    
    // Set all cameras to a specific mode and frame rate so they
    // can be synchronized
    error = ppCameras[i]->SetVideoModeAndFrameRate(VID_MODE, F_RATE);
    if (error != PGRERROR_OK)
    {
      PrintError( error );
      printf("Error setting video mode and frame rate. \n"
	     "This example requires cameras to be able to set to %s at %s. \n", 
	     VID_MODE_STR,F_RATE_STR);
      printf("If your camera does not support this mode, please edit the source code and recompile the application. \n");
      return -1;
    }
  }

  error = Camera::StartSyncCapture( numCameras, (const Camera**)ppCameras );
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    printf("Error calling StartSyncCapture. \n"
	   "Press Enter to exit. \n");
    getchar();
    return -1;
  }
  printf("Camera initialization complete, moving to capture with %s at %s\n",
	 VID_MODE_STR, F_RATE_STR);
  
  Image rawImage;    
  Image convertedImage;
  struct point_grey_image *send_image;
  send_image = (point_grey_image*) malloc(sizeof(struct point_grey_image));

  long long int start_time, stop_time;
  //main capture loop--get time here to check speed
  start_time = GetTimeInUsec();
  
  for ( int j = 0; j < k_numImages; j++ )
  {
    // Display the timestamps for all cameras to show that the image
    // capture is synchronized for each image
    for (int i = 0; i < numCameras; i++ )
    {
      Image image;
      error = ppCameras[i]->RetrieveBuffer( &image );
      if (error != PGRERROR_OK)
      {
	PrintError( error );
	return -1;
      }
      
      TimeStamp timestamp = image.GetTimeStamp();
      printf( 
	     "Cam %d - Frame %d - TimeStamp [%d %d]\n", 
	     i, 
	     j, 
	     timestamp.cycleSeconds, 
	     timestamp.cycleCount);
    }
  }
  
  stop_time = GetTimeInUsec();
  //do some math to show how many images over time
  long long int elapsed = stop_time - start_time;
  float images_per_sec = (float)k_numImages / ((float)elapsed / 1000000);
  printf("Summary: %i images per camera  taken in %lli microseconds (%f images/sec/cam)\n",
	 k_numImages, elapsed, images_per_sec );
  
  //don't need send_image anymore, so free it
  free(send_image);
  
  //loop through cameras one more time to stop & disconnect
  for ( int i = 0; i < numCameras; i++ )
  {
    ppCameras[i]->StopCapture();
    ppCameras[i]->Disconnect();
    delete ppCameras[i];
  }
  
  delete [] ppCameras;
  
  return 0;
}


long long int GetTimeInUsec(void)
{
  struct timeval tv;
  gettimeofday(&tv,NULL);
  long long int ret = tv.tv_usec;
  ret += (tv.tv_sec * 1000 * 1000);
  return ret;
}


void ForcePGRY16Mode(Camera cam)
{
  Error error;
  const unsigned int k_imageDataFmtReg = 0x1048;
  unsigned int value = 0;
  error = cam.ReadRegister( k_imageDataFmtReg, &value );
  if ( error != PGRERROR_OK )
  {
    // Error
  }
  
  value &= ~(0x1 << 0);
  
  error = cam.WriteRegister( k_imageDataFmtReg, value );
  if ( error != PGRERROR_OK )
  {
    // Error
  }
}
