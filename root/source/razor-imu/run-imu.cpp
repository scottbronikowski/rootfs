/*
  Implementation for standalone executable to run razor-imu

  Author: Scott Bronikowski
  Date: 30 June 2014
*/

#include "run-imu.h"
#include <pthread.h>

//global constants
//k_Server declared in toollib-camera.h
//k_imuLogPort, k_LogBufSize, imu_rate declared in emperor.h
const int run_imu_rate = 50; //in Hz
const char* k_imuLogPort = "2004";
const int k_LogBufSize = 256; //100;


//global variables
//extern'd

//not extern'd
razor_data_t* run_imu_data;


int main (int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  printf("Starting Run-IMU\n");

  //open fd for RazorIMU -- gl_imu_fd declared in razor-imu.h
  if (!razor_open_serial_port())
  {
    printf("Error in razor_open_serial_port\n");
    if (gl_imu_fd < 1)
    {
      perror("imu:");
      return -1;
    }
  }
  if (!razor_init())
  {
    perror("razor_init failed");
    run_imu_terminator(SIGTERM);
    return -1;
  }
  run_imu_data = new razor_data_t;

  //test IMU
  if (!razor_read_data(run_imu_data))
  {
    perror("razor_read_data failed");
    run_imu_terminator(SIGTERM);
    return -1;
  } 
  else
  {  //read succeeded, so print it out
    printf("Yaw(raw) = %.2f, Yaw(adj) = %.2f, MAG_h = %.2f\n",
	   run_imu_data->data[0], run_imu_data->data[1], 
	   run_imu_data->data[2]);
    printf("Ax = %.2f, Ay = %.2f, Az = %.2f\n",
	   run_imu_data->data[3], run_imu_data->data[4], 
	   run_imu_data->data[5]);
    printf("Mx = %.2f, My = %.2f, Mz = %.2f\n",
	   run_imu_data->data[6], run_imu_data->data[7], 
	   run_imu_data->data[8]);
    printf("Gx = %.2f, Gy = %.2f, Gz = %.2f\n",
	   run_imu_data->data[9], run_imu_data->data[10], 
	   run_imu_data->data[11]);
  }


  return 0;
}

void run_imu_terminator(int signum)
{
  close(gl_imu_fd);
}
