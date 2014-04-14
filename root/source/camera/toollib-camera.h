/*
  Header for toollib-camera interface to Point Grey Chameleon cameras on rover

  Author: Scott Bronikowski
  Date: 14 April 2014
 */
#ifndef TOOLLIB_CAMERA_H
#define TOOLLIB_CAMERA_H


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
//for ffmpeg
extern "C" {
#include <libavutil/imgutils.h>
#include <libavcodec/avcodec.h>
#include <libswscale/swscale.h>
}
//for opencv
#include <vector>
#include <opencv/cv.h>
#include <opencv/highgui.h>

#include "FlyCapture2.h"
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
extern const unsigned int k_FrontCamSerial;
extern const unsigned int k_PanoCamSerial;
extern const Mode k_fmt7Mode;
extern const FlyCapture2::PixelFormat k_fmt7PixFmt;
extern const char k_OutputDir[];
extern const float k_FrameRate;
extern const unsigned int k_FrontCamWidth;
extern const unsigned int k_FrontCamHeight;
extern const unsigned int k_PanoCamWidth;
extern const unsigned int k_PanoCamHeight;
extern const unsigned int k_PanoCamOffsetX;
extern const unsigned int k_PanoCamOffsetY;
extern const int k_RedBalance;
extern const int k_BlueBalance;
extern const unsigned int k_ImageHeight;
extern const unsigned int k_ImageWidth;
/*network stuff */
extern const char* k_Server;
extern const char* k_FrontCamPort;
extern const char* k_PanoCamPort;
/*for OpenCV*/
extern const int k_jpegQuality; //0-100, default is 95

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
  int compressed_size;
  cv::vector<uchar> compressed;
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
void OpenCV_CompressFrame(PointGrey_t* PG, unsigned int imageCount);
void OpenCV_SendFrame(PointGrey_t* PG);


#endif
