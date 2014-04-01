/*
Implementation of image capture and sending across network

Adapted from CustomImageEx.cpp in FlyCapture2 API

Author: Scott Bronikowski
Date: 28 February 2014

*/

#include "FlyCapture2.h"

#include <stdio.h>
#include <sys/time.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <string.h>
#include <Imlib2.h>
/*network includes*/
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>

//#include "miniz.c"
//#include "snappy.h"
//for ffmpeg
extern "C" {
#include <libavutil/imgutils.h>
#include <libavcodec/avcodec.h>
#include <libswscale/swscale.h>
}
//for jpeg-compressor
#include "jpge.h"

using namespace FlyCapture2;

//defines
#ifndef TRUE
#define TRUE (0==0)
#endif
#ifndef FALSE
#define FALSE (0!=0)
#endif


//globals
/*cam stuff*/
const unsigned int k_FrontCamSerial = 12262775;
const unsigned int k_PanoCamSerial = 13282227;
const Mode k_fmt7Mode = MODE_0;
const FlyCapture2::PixelFormat k_fmt7PixFmt = PIXEL_FORMAT_RAW8;
const char k_OutputDir[] = "/tmp/images/";
const float k_FrameRate = 30.0;
const unsigned int k_FrontCamWidth = 640;//800;//1200;//fmt7Info.maxWidth;
//const unsigned int k_FrontCamWidth = 960;//1248;//1072;//fmt7Info.maxWidth;
const unsigned int k_FrontCamHeight = 480;//600;//720;//820;//fmt7Info.maxHeight;
const unsigned int k_PanoCamWidth = 1240;//fmt7Info.maxWidth;
const unsigned int k_PanoCamHeight = 934;//fmt7Info.maxHeight;
const unsigned int k_PanoCamOffsetX = 34;
const unsigned int k_PanoCamOffsetY = 14;
const int k_RedBalance = 500;
const int k_BlueBalance = 800;
const unsigned int k_ImageHeight = 480;
const unsigned int k_ImageWidth = 640;
/*network stuff */
const char* k_Server = "seykhl.ecn.purdue.edu";
const char* k_FrontCamPort = "3601";
const char* k_PanoCamPort = "3602";
const unsigned int k_BytesPerPixel = 4;
const unsigned long k_TempMaxImageSize = (1024 * 1024 *4); //4MB
const int k_numChannels = 3; //3 channels for RGB images

//structures
struct PointGrey_t {
  Camera camera;
  CameraInfo cameraInfo;
  Format7Info format7Info;
  Format7ImageSettings imageSettings;
  Format7PacketInfo packetInfo;
  Image rawImage, convertedImage;  
  FlyCapture2::PixelFormat pixFormat;
  BayerTileFormat bayerFormat;
  unsigned char* pData;
  unsigned int rows, cols, stride, dataSize;
  Imlib_Image firstImage, finalImage;
  int sockfd;
  //unsigned long cmp_len;
  //unsigned char* pCmp;
  size_t compressed_length;
  char* compressed;
};


//prototypes
void PrintBuildInfo();
void PrintCameraInfo( CameraInfo* pCamInfo );
void PrintFormat7Capabilities( Format7Info fmt7Info );
void PrintError( Error error );
double current_time(void);
void CheckPGR(Error error);
int CheckSaving(const char *dir);
void SetFrameRate(Camera* cam);
void SetWhiteBalance(Camera* cam);
void PGR_StopAndCleanup(PointGrey_t* PG, unsigned int numCameras);
unsigned int PGR_Init(BusManager* busMgr);
int PGR_SetCamera(PointGrey_t* PG);
int PGR_SetCameraNEW(PointGrey_t* PG);
int PGR_StartCameras(BusManager* busMgr, PointGrey_t* PG, unsigned int numCameras);
void PGR_GetFrame(PointGrey_t* PG);
void PGR_GetFrameRaw(PointGrey_t* PG);
void PGR_SaveImage(PointGrey_t* PG);
void Imlib_GetFrame(PointGrey_t* PG);
void Imlib_GetFrameWithResize(PointGrey_t* PG);
void Imlib_SaveImage(PointGrey_t* PG);
/* network prototypes*/
void *get_in_addr(struct sockaddr *sa);
int ClientConnect(const char* server, const char* port);
int Network_StartCameras(PointGrey_t* PG, unsigned int numCameras);
int sendall(int s, unsigned char *buf, int *len);
int SendMetadata (PointGrey_t* PG);
int SendFrame(PointGrey_t* PG);
//void SnappyCompress(PointGrey_t* PG);
int SendMetadataCompressed (PointGrey_t* PG);

int main(int /*argc*/, char** /*argv*/)
{
    PrintBuildInfo();
    const int k_numImages = 100;
    BusManager busMgr;
    unsigned int numCameras = PGR_Init(&busMgr);
    printf( "Number of cameras detected: %u\n", numCameras );
    if ( numCameras < 1 )
    {
        printf( "Insufficient number of cameras... exiting\n" );
        return -1;
    }
    PointGrey_t* PG = new PointGrey_t[numCameras];
    // for (unsigned int i = 0; i < numCameras; i++)
    // {
    //   PG[i].compressed = new char[snappy::MaxCompressedLength(k_TempMaxImageSize)];
    //   //PG[i].pCmp = new unsigned char[k_TempMaxImageSize];
    // }
    if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
    {
      printf("Error starting cameras\n");
      PGR_StopAndCleanup(PG, numCameras);
      return -1;
    }

    if (Network_StartCameras(PG, numCameras) != 0)
    {
      printf("Error starting network\n");
      //return -1;
    }

    printf( "Grabbing %d images\n", k_numImages ); //setup completed

    // unsigned char tempbuf[512];
    // int len;

    //int img_size;

    //uLong src_len, cmp_len;
    //unsigned char* pCmp;
    //int cmp_status;

    // char* tmpOutput = new char[snappy::MaxCompressedLength(k_TempMaxImageSize)];
    // size_t output_length;
    jpge::params parameters;
    //parameters.m_quality = 25;
    //parameters.m_subsampling = jpge::H1V1;

    //try moving this inside loop
    // int bufSize = k_TempMaxImageSize;
    // unsigned char* compressedImage = new unsigned char[bufSize];
    int bufSize;

    double start = current_time();
    for ( int imageCount=0; imageCount < k_numImages; imageCount++ ) //main capture loop
    {
      for (unsigned int i = 0; i < numCameras; i++)
      {
	/* PGR functions only */
	PGR_GetFrame(&PG[i]);
	//PGR_GetFrameRaw(&PG[i]);

	//check image dimensions
	// printf("rows = %u, cols = %u, stride = %u, dataSize = %u ",
	//        PG[i].rows, PG[i].cols, PG[i].stride, PG[i].dataSize);
	// printf("pixFormat = %u, bayerFormat = %u\n", PG[i].pixFormat,
	//        PG[i].bayerFormat);
	

	if (imageCount % 10 == 0)
	  printf("Captured %u-%d\n",PG[i].cameraInfo.serialNumber, imageCount);
	

	/* now with Imlib functions */
	// Imlib_GetFrame(&PG[i]);
	// //Imlib_GetFrameWithResize(&PG[i]);
	// imlib_context_set_image(PG[i].finalImage); //move this closer to imlib calls?
	
	// // /* LOOK TO FUNCTIONALIZE THIS SECTION */
	// // //SEND IMAGE HERE
	
	// //***COMPRESSION STUFF*****
	bufSize = k_TempMaxImageSize;
	unsigned char* compressedImage = new unsigned char[bufSize];

  	if (!jpge::compress_image_to_jpeg_file_in_memory(compressedImage, bufSize,
  							 (int)PG[i].cols, (int)PG[i].rows, 
  							 k_numChannels, 
  							 PG[i].pData, parameters))
  	{
	  printf("compression error\n");
  	}
  	else
  	{
  	  printf("Compressed image size = %d\n", bufSize);
  	}


	//SnappyCompress(&PG[i]);
	

	// //src_len = (uLong)PG[i].dataSize;
	// //cmp_len = compressBound(src_len);
	// PG[i].cmp_len = compressBound((unsigned long)PG[i].dataSize);
	// // if (imageCount == 0)
	// // {
	// //   PG[i].pCmp = new unsigned char[PG[i].cmp_len];
	// // }
	// // Allocate buffers to hold compressed and uncompressed data.
	// // pCmp = (mz_uint8 *)malloc((size_t)cmp_len);
	// // if (!pCmp)
	// // {
	// //   printf("Out of memory!\n");
	// //   return EXIT_FAILURE;
	// //}
	
	// // Compress the string.
	// printf("PG[i].pCmp = %p\n", PG[i].pCmp);
	// cmp_status = compress(PG[i].pCmp, &PG[i].cmp_len, 
	// 		      (const unsigned char *)PG[i].pData,
	// 		      (unsigned long)PG[i].dataSize);
	// if (cmp_status != Z_OK)
	// {
	//   printf("compress() failed!, %s\n", mz_error(cmp_status));
	//   //free(pCmp);
	//   return EXIT_FAILURE;
	// }
	// printf("dataSize = %u, cmp_len = %lu\n", PG[i].dataSize, PG[i].cmp_len);
	// //**END COMPRESSION STUFF***
	
	
	// /* SENDING BLOCK */
	// // //can't send metadata just once when sending compressed
	// // if (SendMetadataCompressed(&PG[i]) != 0)
	// // {
	// //   printf("Error sending metadata\n");
	// // }
	// if (imageCount == 0)
	// {
	//   //try sending metadata only the first time
	//   if (SendMetadata(&PG[i]) != 0)
	//   {
	//     printf("Error sending metadata\n");
	//   }
	// }

	// //then send data
	// if (SendFrame(&PG[i]) != 0)
	// {
	//   printf("Error sending data\n");
	// }
	// /* END SENDING BLOCK */


	//**CLEANUP COMPRESSION MALLOC
	// if (imageCount == (k_numImages -1))
	// {
	//   delete[] PG[i].pCmp;
	// }
	//free(pCmp);
	delete[] compressedImage;
       
	
	// else
	// {
	//   printf("Sent %u-%u\n", PG[i].cameraInfo.serialNumber, imageCount);
	// }

	// /* second draft -- works with converted Imlib images*/
	// // //first send image dimensions
	// // // printf("rows = %u, cols = %u, stride = %u\n", PG[i].rows,
	// // //        PG[i].cols, PG[i].stride);
	// // // printf("sizeof(rows) = %d, sizeof(convertedImage) = %d, sizeof(finalImage) = %d\n",
	// // //        sizeof(PG[i].rows), sizeof(&PG[i].convertedImage), sizeof(PG[i].finalImage));
	
	// // //first send size, (w, h, d)
	// // if (send(PG[i].sockfd, &PG[i].cols, sizeof(PG[i].cols), 0) <= 0)
	// // {
	// //   printf("Error sending width");
	// // }
	// // if (send(PG[i].sockfd, &PG[i].rows, sizeof(PG[i].rows), 0) <= 0)
	// // {
	// //   printf("Error sending height");
	// // }	
	// // if (send(PG[i].sockfd, &k_BytesPerPixel, sizeof(k_BytesPerPixel), 0) <= 0)
	// // {
	// //   printf("Error sending depth");
	// // }
	// // printf("Sent w x h x d = %u x %u x %u\n", PG[i].cols, PG[i].rows, k_BytesPerPixel);

	// // //then send data
	// // img_size = (int)(PG[i].cols * PG[i].rows * k_BytesPerPixel);
	// // //context set above -- need to move?
	// // unsigned char *frame = 
	// //   (unsigned char *)imlib_image_get_data_for_reading_only();
	// // if (sendall(PG[i].sockfd, frame, &img_size) != 0)
	// // {
	// //   printf("Error in sendall\n");
	// // }
	// /* end second draft */

	// // /* first draft -- using strings with length sent before string */
	// // memset(&tempbuf, 0, sizeof(tempbuf));
	// // sprintf(tempbuf, "sending image %u-%u", PG[i].cameraInfo.serialNumber,
	// // 	imageCount);
	// // len = strlen(tempbuf);
	// // printf("tempbuf = %s, len = %d\n", tempbuf, len);
	// // //first send size
	// // if (send(PG[i].sockfd, &len, sizeof(len), 0) <= 0)
	// // {
	// //   printf("Error sending len\n");
	// // }
	// // //then send data
	// // if (sendall(PG[i].sockfd, tempbuf, &len) != 0)
	// // {
	// //   printf("Error in sendall\n");
	// // }
	// // /* end first draft */
	
	// /* FUNCTIONALIZE */
	
	// imlib_free_image_and_decache(); //do this closer to imlib call?

	/* use OpenCV functions here*/
	/* OpenCV */
    	
      }
    }
    /* CLEAN UP COMPRESSION */
    //delete[] tmpOutput;
    //delete[] compressedImage;

    double stop = current_time();
    //check elapsed time
    double elapsed = stop - start;
    double images_per_sec = (double)k_numImages / elapsed;
    printf( "\nFinished grabbing images\n" );
    printf("%d images per camera taken in %f seconds (%f images/sec/cam)\n",
    	   k_numImages, elapsed, images_per_sec);
    
    /* SAVING BLOCK */
    // //grab and save one last image from each camera, after time has been measured
    // // Since this section of code saves images in the k_OutputDir folder,
    // // must ensure that this folder exists and we have permissions to write to it
    // if (CheckSaving(k_OutputDir) != 0)
    // {
    //   printf("Cannot save to %s, please check permissions\n",k_OutputDir);
    //   return -1;
    // }
    // for (unsigned int i = 0; i < numCameras; i++)
    // {
    //   /* PGR functions only*/
    //   PGR_GetFrame(&PG[i]);
    //   PGR_SaveImage(&PG[i]);

    //   /* now with Imlib functions */
    //   //Imlib_GetFrame(&PG[i]);
    //   //Imlib_SaveImage(&PG[i]);

    //   /* use OpenCV functions here */
    // }
    /* END SAVING BLOCK */

    PGR_StopAndCleanup(PG, numCameras);
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
    printf("Mode: %d\n"
	   "Packet Size: %u\n"
	   "Min Packet Size: %u\n"
	   "Max Packet Size: %u\n",
	   fmt7Info.mode,
	   fmt7Info.packetSize,
	   fmt7Info.minPacketSize,
	   fmt7Info.maxPacketSize);
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

void CheckPGR(Error error)
{
  if (error != PGRERROR_OK)
  {
    PrintError( error );
    abort();
    //return -1;
  }
  // else
  // {
  //   return 0;
  // }
}

int CheckSaving(const char *dir)
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

void SetFrameRate(Camera* cam)
{
  // Retrieve frame rate property
  Property frameRate;
  frameRate.type = FRAME_RATE;
  CheckPGR(cam->GetProperty(&frameRate));
  //printf( "Frame rate FIRST is %3.2f fps\n", frameRate.absValue );
  
  //set frame rate to global constant k_FrameRate
  frameRate.autoManualMode = false;
  frameRate.absControl = true;
  frameRate.absValue = k_FrameRate;
  //printf("frameRate.absValue = %3.2f\n",frameRate.absValue);
  CheckPGR(cam->SetProperty(&frameRate));
  
  // //set frame rate to automatic mode
  // frmRate.autoManualMode = true;
  // frmRate.absControl = false;
  // CheckPGR(cam->SetProperty(&frmRate));
  
  //check frame rate after setting
  // CheckPGR(cam->GetProperty(&frameRate));
  // printf( "Frame rate SECOND is %3.2f fps\n", frameRate.absValue );
}

void SetWhiteBalance(Camera* cam)
{
  Property p;
  p.type = WHITE_BALANCE;
  CheckPGR(cam->GetProperty(&p));
  p.valueA = k_RedBalance;
  p.valueB = k_BlueBalance;
  p.onOff = true;
  CheckPGR(cam->SetProperty(&p));
}


void PGR_StopAndCleanup(PointGrey_t* PG, unsigned int numCameras)
{
  for (unsigned int i = 0; i < numCameras; i++)
  {
    // Stop capturing images
    CheckPGR(PG[i].camera.StopCapture()); 
    // Disconnect the camera
    CheckPGR(PG[i].camera.Disconnect());
  }
  delete[] PG;
}     

unsigned int PGR_Init(BusManager* busMgr)
{
  unsigned int numCameras;
  CheckPGR(busMgr->GetNumOfCameras(&numCameras));
  return numCameras;
}

int PGR_SetCamera(PointGrey_t* PG)
{
  // Get the camera information
  CheckPGR(PG->camera.GetCameraInfo(&PG->cameraInfo));
  
  // Query for available Format 7 modes
  bool supported;
  PG->format7Info.mode = k_fmt7Mode;
  CheckPGR(PG->camera.GetFormat7Info(&PG->format7Info, &supported));
    
  if (((k_fmt7PixFmt & PG->format7Info.pixelFormatBitField) == 0) || !supported)
  {
    // Pixel format not supported!
    printf("Pixel format is not supported\n");
    return -1;
  }
  PG->imageSettings.mode = k_fmt7Mode;
  PG->imageSettings.pixelFormat = k_fmt7PixFmt;
  if (PG->cameraInfo.serialNumber == k_FrontCamSerial)
  {
    PG->imageSettings.width = k_FrontCamWidth;
    PG->imageSettings.height = k_FrontCamHeight;
    PG->imageSettings.offsetX = (PG->format7Info.maxWidth - 
				   PG->imageSettings.width) / 2;
    PG->imageSettings.offsetY = (PG->format7Info.maxHeight - 
				   PG->imageSettings.height) / 2;
  }
  else if (PG->cameraInfo.serialNumber == k_PanoCamSerial)
  {
    // /* NEW way -- trying for 640x480 grayscale */
    // PG->imageSettings.mode = MODE_0;
    // PG->imageSettings.pixelFormat = PIXEL_FORMAT_RAW8;
    // PG->imageSettings.width = PG->format7Info.maxWidth;
    // PG->imageSettings.height = PG->format7Info.maxHeight;
    // PG->imageSettings.offsetX =0;
    // PG->imageSettings.offsetY = 0;

    /* OLD way -- give large color image*/ 
    PG->imageSettings.width = k_PanoCamWidth;
    PG->imageSettings.height = k_PanoCamHeight;
    PG->imageSettings.offsetX = k_PanoCamOffsetX;
    PG->imageSettings.offsetY = k_PanoCamOffsetY;
  }
  else
  {
    printf("ERROR! Camera serial number not recognized!");
    return -1;
  }
    
  bool valid;
  // Validate the settings to make sure that they are valid
  CheckPGR(PG->camera.ValidateFormat7Settings(&PG->imageSettings,
					      &valid,
					      &PG->packetInfo ));
  
  if ( !valid )
  { // Settings are not valid
    printf("Format7 settings are not valid\n");
    return -1;
  }  
  // Send the settings to the camera
  CheckPGR(PG->camera.SetFormat7Configuration(&PG->imageSettings,
					      PG->packetInfo.recommendedBytesPerPacket ));
  SetFrameRate(&PG->camera);
  SetWhiteBalance(&PG->camera);
  return 0;
}

int PGR_SetCameraNEW(PointGrey_t* PG)
{
  // this sets the front camera to Format 7  640x480 color (smaller ROI), 
  // panoramic camera to 640x480 greyscale (full ROI)

  // Get the camera information
  CheckPGR(PG->camera.GetCameraInfo(&PG->cameraInfo));
  
  if (PG->cameraInfo.serialNumber == k_FrontCamSerial)
  {
    // Query for available Format 7 modes
    bool supported;
    PG->format7Info.mode = k_fmt7Mode;
    CheckPGR(PG->camera.GetFormat7Info(&PG->format7Info, &supported));
    
    if (((k_fmt7PixFmt & PG->format7Info.pixelFormatBitField) == 0) || !supported)
    {
      // Pixel format not supported!
      printf("Pixel format is not supported\n");
      return -1;
    }
    PG->imageSettings.mode = k_fmt7Mode;
    PG->imageSettings.pixelFormat = k_fmt7PixFmt;
    PG->imageSettings.width = k_FrontCamWidth;
    PG->imageSettings.height = k_FrontCamHeight;
    PG->imageSettings.offsetX = (PG->format7Info.maxWidth - 
				   PG->imageSettings.width) / 2;
    PG->imageSettings.offsetY = (PG->format7Info.maxHeight - 
				   PG->imageSettings.height) / 2;
    bool valid;
    // Validate the settings to make sure that they are valid
    CheckPGR(PG->camera.ValidateFormat7Settings(&PG->imageSettings,
						&valid,
						&PG->packetInfo ));
    
    if ( !valid )
    { // Settings are not valid
      printf("Format7 settings are not valid\n");
      return -1;
    }  
    // Send the settings to the camera
    CheckPGR(PG->camera.SetFormat7Configuration(&PG->imageSettings,
			PG->packetInfo.recommendedBytesPerPacket ));
    SetFrameRate(&PG->camera);
    SetWhiteBalance(&PG->camera);
  }
  else if (PG->cameraInfo.serialNumber == k_PanoCamSerial)
  {
    CheckPGR(PG->camera.SetVideoModeAndFrameRate(VIDEOMODE_640x480Y8,
						 FRAMERATE_30));	     
  }
  else
  {
    printf("ERROR! Camera serial number not recognized!");
    return -1;
  }
  

  return 0;
}

int PGR_StartCameras(BusManager* busMgr, PointGrey_t* PG, unsigned int numCameras)
{
  PGRGuid tmpGuid;
  for (unsigned int i = 0; i < numCameras; i++) //setup/init loop
  {
    // Connect to a camera
    CheckPGR(busMgr->GetCameraFromIndex(i, &tmpGuid));
    CheckPGR(PG[i].camera.Connect(&tmpGuid));

    // //this sets up for pano cam 1240x934 color
    // if (PGR_SetCamera(&PG[i]) != 0)
    // {
    //   printf("Error in setting camera\n");
    //   return -1;
    // }
    
    //this sets up for pano cam 640x480 greyscale
    if (PGR_SetCameraNEW(&PG[i]) != 0)
    {
      printf("Error in setting camera\n");
      return -1;
    }

    // PrintCameraInfo(&PG->cameraInfo);
    // PrintFormat7Capabilities(PG[i].format7Info);
    // printf("Image size: %d x %d\n", PG[i].imageSettings.width, 
    // 	     PG[i].imageSettings.height);
    
    // Start capturing images
    CheckPGR(PG[i].camera.StartCapture());
    
    // // Check frame rate property
    // Property frmRate;
    // frmRate.type = FRAME_RATE;
    // CheckPGR(PG[i].camera.GetProperty( &frmRate ));
    // printf("Frame rate for Camera %u is %3.2f fps\n", 
    // 	     PG[i].cameraInfo.serialNumber,
    // 	     frmRate.absValue);  
  }
  return 0;
}

void PGR_GetFrame(PointGrey_t* PG)
{
  // Retrieve an image
  CheckPGR(PG->camera.RetrieveBuffer(&PG->rawImage));
  printf("%u-rawImage.GetDataSize() = %u\n", PG->cameraInfo.serialNumber,
	 PG->rawImage.GetDataSize());
  // // Get the raw image dimensions
  // PG->rawImage.GetDimensions(&PG->rows, &PG->cols, 
  // 			     &PG->stride, &PG->pixFormat );
  // Convert the raw image
  // CheckPGR(PG->rawImage.Convert(PIXEL_FORMAT_BGRU, 
  // 				&PG->convertedImage));
  CheckPGR(PG->rawImage.Convert(PIXEL_FORMAT_BGR, 
				&PG->convertedImage));
  printf("%u-convertedImage.GetDataSize() = %u\n", PG->cameraInfo.serialNumber,
	 PG->convertedImage.GetDataSize());
  // Get the converted image dimensions
  PG->convertedImage.GetDimensions(&PG->rows, &PG->cols, 
				   &PG->stride, &PG->pixFormat );
  //printf("got dimensions / ");
  PG->dataSize = PG->convertedImage.GetDataSize();
  //printf("got data size / ");
  PG->pData = PG->convertedImage.GetData();
  //memcpy(PG->pData, PG->convertedImage.GetData(), PG->dataSize); //SEGFAULTS
  //printf("got data, strlen(data) = %zu\n", strlen((const char*)PG->pData));

}

void PGR_SaveImage(PointGrey_t* PG)
{
  // Create a unique filename
  char filename[512];
  sprintf(filename, "%s%u-PGR-final.ppm", k_OutputDir, 
	  PG->cameraInfo.serialNumber);
    // Save the image. If a file format is not passed in, then the file
  // extension is parsed to attempt to determine the file format.
  CheckPGR(PG->convertedImage.Save(filename));
  printf("Saved %s\n",filename);
}

void Imlib_GetFrameWithResize(PointGrey_t* PG)
{
  // Retrieve an image
  CheckPGR(PG->camera.RetrieveBuffer(&PG->rawImage));
  // Get the raw image dimensions
  PG->rawImage.GetDimensions(&PG->rows, &PG->cols, 
			     &PG->stride, &PG->pixFormat );
  // Convert the raw image
  CheckPGR(PG->rawImage.Convert(PIXEL_FORMAT_BGRU, 
				&PG->convertedImage));
  PG->firstImage = 
    imlib_create_image_using_copied_data(PG->cols,
					 PG->rows,
					 (unsigned int*)
					 PG->convertedImage.GetData());
    

    //not sure if using this selection here is any faster
  if ((PG->cols == k_ImageWidth) && (PG->rows = k_ImageHeight))
  { //no resize needed
    //printf("Image from camera %u not resized\n", PG->cameraInfo.serialNumber);
    PG->finalImage = PG->firstImage;
  }
  else
  {
    //resize needed
    //printf("Image from camera %u WILL BE resized\n", PG->cameraInfo.serialNumber);
    imlib_context_set_image(PG->firstImage);
    PG->finalImage = 
      imlib_create_cropped_scaled_image(0, 0,
					imlib_image_get_width(),
					imlib_image_get_height(),
					k_ImageWidth, k_ImageHeight);
    imlib_free_image_and_decache();
  }
}

void Imlib_GetFrame(PointGrey_t* PG)
{
  // Retrieve an image
  CheckPGR(PG->camera.RetrieveBuffer(&PG->rawImage));
  printf("rawImage.GetDataSize() = %u\n", PG->rawImage.GetDataSize());
  // Get the raw image dimensions
  PG->rawImage.GetDimensions(&PG->rows, &PG->cols, 
			     &PG->stride, &PG->pixFormat );
  // Convert the raw image
  CheckPGR(PG->rawImage.Convert(PIXEL_FORMAT_BGRU, 
				&PG->convertedImage));
  printf("convertedImage.GetDataSize() = %u\n", PG->convertedImage.GetDataSize());
  /* original code */
  PG->finalImage = 
    imlib_create_image_using_copied_data(PG->cols,
  					 PG->rows,
  					 (unsigned int*)
  					 PG->convertedImage.GetData());
}

void PGR_GetFrameRaw(PointGrey_t* PG)
{
  // Retrieve an image
  CheckPGR(PG->camera.RetrieveBuffer(&PG->rawImage));
  //printf("Captured from %u / ", PG->cameraInfo.serialNumber);
  //printf("rawImage.GetDataSize() = %u\n", PG->rawImage.GetDataSize());
  // Get the raw image dimensions
  PG->rawImage.GetDimensions(&PG->rows, &PG->cols, &PG->stride, 
			     &PG->pixFormat, &PG->bayerFormat);
  //printf("got dimensions / ");
  PG->dataSize = PG->rawImage.GetDataSize();
  //printf("got data size / ");
  PG->pData = PG->rawImage.GetData();
  //memcpy(PG->pData, PG->rawImage.GetData(), PG->dataSize); //SEGFAULTS
  //printf("got data, strlen(data) = %zu\n", strlen((const char*)PG->pData));
}


void Imlib_SaveImage(PointGrey_t* PG)
{
  imlib_context_set_image(PG->finalImage);
  // Create a unique filename
  char filename[512];
  sprintf(filename, "%s%u-Imlib-final.ppm", k_OutputDir, 
	  PG->cameraInfo.serialNumber);
  imlib_save_image(filename);
  imlib_free_image_and_decache();
  printf("Saved %s\n",filename);
}

// get sockaddr, IPv4 or IPv6:
void *get_in_addr(struct sockaddr *sa)
{
  if (sa->sa_family == AF_INET) 
  {
    return &(((struct sockaddr_in*)sa)->sin_addr);
  }
  return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int ClientConnect(const char* server, const char* port)
{
  int sockfd;  
  struct addrinfo hints, *servinfo, *p;
  int rv;
  char s[INET6_ADDRSTRLEN];

  memset(&hints, 0, sizeof hints);
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  
  if ((rv = getaddrinfo(server, port, &hints, &servinfo)) != 0) {
    fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
    return -1;
  }

  // loop through all the results and connect to the first we can
  for(p = servinfo; p != NULL; p = p->ai_next) 
  {
    if ((sockfd = socket(p->ai_family, p->ai_socktype,
			 p->ai_protocol)) == -1)
    {
      perror("client: socket");
      continue;
    }
    if (connect(sockfd, p->ai_addr, p->ai_addrlen) == -1) 
    {
      close(sockfd);
      perror("client: connect");
      continue;
    }
    //if we get here, we have connected successfully
    printf("Connection established\n");
    break;
  }
  
  if (p == NULL) 
  {
    //looped off the end of the list with no connection
    fprintf(stderr, "client: failed to connect\n");
    return -1;
  }
  inet_ntop(p->ai_family, get_in_addr((struct sockaddr *)p->ai_addr),
	    s, sizeof s);
  printf("client: connecting to %s\n", s);
  
  freeaddrinfo(servinfo); // all done with this structure
  
  return sockfd;
}

int Network_StartCameras(PointGrey_t* PG, unsigned int numCameras)
{
 
  for (unsigned int i = 0; i < numCameras; i++) //setup/init loop
  {
    if (PG[i].cameraInfo.serialNumber == k_FrontCamSerial)
    {
      if ((PG[i].sockfd = ClientConnect(k_Server, k_FrontCamPort)) < 0)
      {
    	printf("Error in ClientConnect\n");
    	return -1;
      }
    }
    else if (PG[i].cameraInfo.serialNumber == k_PanoCamSerial)
    {
      if ((PG[i].sockfd = ClientConnect(k_Server, k_PanoCamPort)) < 0)
      {
    	printf("Error in ClientConnect\n");
    	return -1;
      }
    }
    else
    {
      printf("ERROR! Camera serial number not recognized in Network_StartCameras!\n");
      return -1;
    }
    // //try setting connected socket as nonblocking
    // int status = fcntl(PG[i].sockfd, F_SETFL, fcntl(PG[i].sockfd, F_GETFL, 0) | O_NONBLOCK);
    // if (status == -1)
    // {
    //   printf("Error setting nonblocking\n");
    //   return -1;
    // }
    printf("Camera %u connected to %s\n", PG[i].cameraInfo.serialNumber, k_Server);
  }
  return 0;
}

int sendall(int s, unsigned char *buf, int *len)
{
  int total = 0;        // how many bytes we've sent
  int bytesleft = *len; // how many we have left to send
  int n;
  
  while(total < *len) {
    n = send(s, buf+total, bytesleft, 0);
    if (n == -1) { break; }
    total += n;
    bytesleft -= n;
  }
  
  *len = total; // return number actually sent here
  //printf("sent %d\n", *len);
  return n==-1?-1:0; // return -1 on failure, 0 on success
} 

int SendMetadata (PointGrey_t* PG)
{
  //first send image dimensions
  // printf("rows = %u, cols = %u, stride = %u, dataSize = %u\n",
  //        PG->rows, PG->cols, PG->stride, PG->dataSize);
  // printf("pixFormat = %u, bayerFormat = %u\n", PG->pixFormat,
  //        PG->bayerFormat);

  if (send(PG->sockfd, &PG->cols, sizeof(PG->cols), 0) <= 0)
  {
    printf("Error sending cols");
    return -1;
  }
  if (send(PG->sockfd, &PG->rows, sizeof(PG->rows), 0) <= 0)
  {
    printf("Error sending rows");
    return -1;
  }	
  if (send(PG->sockfd, &PG->stride, sizeof(PG->stride), 0) <= 0)
  {
    printf("Error sending stride");
    return -1;
  }
  if (send(PG->sockfd, &PG->dataSize, sizeof(PG->dataSize), 0) <= 0)
  {
    printf("Error sending dataSize");
    return -1;
  }	
  if (send(PG->sockfd, &PG->pixFormat, sizeof(PG->pixFormat), 0) <= 0)
  {
    printf("Error sending pixFormat");
    return -1;
  }
  if (send(PG->sockfd, &PG->bayerFormat, sizeof(PG->bayerFormat), 0) <= 0)
  {
    printf("Error sending bayerFormat");
    return -1;
  }	
  //if we haven't hit a return yet, we succeeded
  return 0;
}

int SendMetadataCompressed (PointGrey_t* PG)
{
  if (send(PG->sockfd, &PG->cols, sizeof(PG->cols), 0) <= 0)
  {
    printf("Error sending cols");
    return -1;
  }
  if (send(PG->sockfd, &PG->rows, sizeof(PG->rows), 0) <= 0)
  {
    printf("Error sending rows");
    return -1;
  }	
  if (send(PG->sockfd, &PG->stride, sizeof(PG->stride), 0) <= 0)
  {
    printf("Error sending stride");
    return -1;
  }
  if (send(PG->sockfd, &PG->dataSize, sizeof(PG->dataSize), 0) <= 0)
  {
    printf("Error sending dataSize");
    return -1;
  }	
  if (send(PG->sockfd, &PG->pixFormat, sizeof(PG->pixFormat), 0) <= 0)
  {
    printf("Error sending pixFormat");
    return -1;
  }
  if (send(PG->sockfd, &PG->bayerFormat, sizeof(PG->bayerFormat), 0) <= 0)
  {
    printf("Error sending bayerFormat");
    return -1;
  }	
  if (send(PG->sockfd, &PG->compressed_length, sizeof(PG->compressed_length), 0) <= 0)
  {
    printf("Error sending compressed_length");
    return -1;
  }
  //if we haven't hit a return yet, we succeeded
  return 0;
}

int SendFrame(PointGrey_t* PG)
{
  int img_size = (int)(PG->dataSize);
    
  if (sendall(PG->sockfd, PG->pData, &img_size) != 0)
  {
    printf("Error in sendall\n");
    return -1;
  }
  
  return 0;
}

// void SnappyCompress(PointGrey_t* PG)
// {
//   snappy::RawCompress((char*)PG->pData, (size_t)PG->dataSize,
// 		      PG->compressed, &PG->compressed_length);
//   printf("dataSize = %u, cmp_len = %d\n", PG->dataSize, PG->compressed_length);
// }
