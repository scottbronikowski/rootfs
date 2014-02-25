//Definitions for Cameras on Rover
//Author: Scott Bronikowski
//Date: 13 February 2014

#ifndef ROVERCAMDEFS_H
#define ROVERCAMDEFS_H

#include <stdlib.h> //for atoi

#define OUTPUT_DIR  "/tmp/images/"
//const unsigned int front_cam_serial = 12262775;
#define front_cam_serial 12262775
//const unsigned int pano_cam_serial  = 13282227;
#define pano_cam_serial  13282227

//const int default_num_pics = 10;
#define default_num_pics 10

struct point_grey_image {
  unsigned int rows;
  unsigned int cols;
  unsigned char* data;
};

//cam settings for C++ API
#define VID_MODE     VIDEOMODE_1280x960Y8
#define VID_MODE_STR "VIDEOMODE_1280x960Y8"
#define F_RATE       FRAMERATE_15
#define F_RATE_STR   "FRAMERATE_15"

//cam settings for C API
#define FC_VID_MODE     FC2_VIDEOMODE_1280x960Y8
#define FC_VID_MODE_STR "FC2_VIDEOMODE_1280x960Y8"
#define FC_F_RATE       FC2_FRAMERATE_15
#define FC_F_RATE_STR   "FC2_FRAMERATE_15"
#define C_COLOR_PROC    FC2_NEAREST_NEIGHBOR_FAST
#define C_VID_MODE     FC2_VIDEOMODE_1280x960Y8
#define C_VID_MODE_STR "FC2_VIDEOMODE_1280x960Y8"
#define C_F_RATE       FC2_FRAMERATE_15
#define C_F_RATE_STR   "FC2_FRAMERATE_15"

#endif
