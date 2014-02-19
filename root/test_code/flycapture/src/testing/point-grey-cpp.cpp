// g++ -c -I${HOME}/darpa-collaboration/include/`architecture-path`/flycapture point-grey-cpp.cpp

#include "FlyCapture2.h"
using namespace FlyCapture2;
#include "point-grey.h"

extern "C" void point_grey_set_white_balance(int red, int blue) {
  BusManager busMgr;
  unsigned int nrCameras;
  check_point_grey(busMgr.GetNumOfCameras(&nrCameras));
  PGRGuid guid;
  check_point_grey(busMgr.GetCameraFromIndex(0, &guid));
  Camera cam;
  check_point_grey(cam.Connect(&guid));
  PropertyInfo p;
  p.type = WHITE_BALANCE;
  check_point_grey(cam.GetPropertyInfo(&p));
  Property prop;
  prop.type = WHITE_BALANCE;
  check_point_grey(cam.GetProperty(&prop));
  prop.valueA = red;
  prop.valueB = blue;
  prop.onOff = 1;
  check_point_grey(cam.SetProperty(&prop));
  cam.Disconnect();
}
