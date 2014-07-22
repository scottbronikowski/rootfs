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
int log_imu_sockfd;

//not extern'd
razor_data_t* run_imu_data;


int main (int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  //unsigned long mine;
  memset(logbuf, 0, sizeof(logbuf));
  printf("Starting Run-IMU\n");
  //printf("sizeof(unsigned long) = %u\n", sizeof(mine));

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
    printf("IMU initialized in run-imu\n");
    // printf("Timestamp = %lu\n", run_imu_data->timestamp);
    // printf("dt = %lu\n", run_imu_data->dt);
    // printf("Yaw = %.2f, Pitch = %.2f, Roll = %.2f\n",
    // 	   run_imu_data->data[0], run_imu_data->data[1], 
    // 	   run_imu_data->data[2]);
    // printf("Yaw(adj) = %.2f, MAG_H(adj) = %.2f, MAG_H(raw) = %.2f\n",
    // 	   run_imu_data->data[3], run_imu_data->data[4], 
    // 	   run_imu_data->data[5]);
    // printf("Ax = %.2f, Ay = %.2f, Az = %.2f\n",
    // 	   run_imu_data->data[6], run_imu_data->data[7], 
    // 	   run_imu_data->data[8]);
    // printf("Mx = %.2f, My = %.2f, Mz = %.2f\n",
    // 	   run_imu_data->data[9], run_imu_data->data[10], 
    // 	   run_imu_data->data[11]);
    // printf("Gx = %.2f, Gy = %.2f, Gz = %.2f\n",
    // 	   run_imu_data->data[12], run_imu_data->data[13], 
    // 	   run_imu_data->data[14]);
  }

  printf("Connecting to %s on port %s for IMU logging...\n",
	 k_Server, k_imuLogPort);
  log_imu_sockfd = -1;
  sprintf(logbuf, "IMU logging started");
  while (log_imu_sockfd == -1)
  {
    log_imu_sockfd = ClientConnect(k_Server, k_imuLogPort);
  }
  retval = run_imu_log_data(logbuf, log_imu_sockfd);
  if (retval != 0)
    printf("connection failed\n");
  else
    printf("success!\n");
  
  // run_imu_sigaction();
  // run_imu_interrupt_on(run_imu_rate);
  
  //register signal handler for termination
  signal(SIGINT, run_imu_terminator);
  signal(SIGTERM, run_imu_terminator);

  //run a small loop here to clear messages backed up in serial buffer
  struct timeval mark, now;
  gettimeofday(&mark, NULL);
  gettimeofday(&now, NULL);
  while (razor_elapsed_ms(mark, now) < 200)
  {
    razor_read_data(run_imu_data); //read the data and do nothing
    gettimeofday(&now, NULL);  //update time hack
  }


  while(1)
  {//what to do here??
    //sleep(1);
    run_imu_handler(1);
  }

  //cleanup done in run_imu_terminator
  return 0;
}

void run_imu_terminator(int signum)
{
  close(gl_imu_fd);
  close(log_imu_sockfd);
  delete run_imu_data;
  printf("Run-IMU: IMU logging socket closed\n");
  exit(signum);
}

int run_imu_log_data(char* databuf, int log_fd)
{
  double now = run_imu_current_time(); 
  char sendbuf[k_LogBufSize];
  char temp[k_LogBufSize];
  int retval;
  memset(temp, 0, sizeof(temp));
  retval = snprintf(temp, k_LogBufSize, "%.6f: IMU:%s", now, databuf);
  if (retval >= k_LogBufSize)
  {
    printf("run_imu_log_data: message truncated: %s\n  %s\n", databuf, temp);
    return -1;
  }
  if (retval < 0)
  {
    printf("run_imu_log_data: encoding eror\n");
    return -1;
  }
  //if we get here, we have something to send in temp
  memset(sendbuf, 0, sizeof(sendbuf));
  strncpy(sendbuf, temp, sizeof(sendbuf));  //use this to pad buffer
  retval = send(log_fd, sendbuf, sizeof(sendbuf), 0);
  if (retval != k_LogBufSize)
  {
    printf("run_imu_log_data: send failed\n");
    return -1;
  }
  else
    return 0; //success
}

double run_imu_current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

void run_imu_handler(int signum)
{
  char logbuf[k_LogBufSize];
  memset(logbuf, 0, sizeof(logbuf));  //clear buffer
  if (razor_read_data(run_imu_data))
  { //successful read, so put data into logbuf
    sprintf(logbuf, "time:%lu:dt:%lu:"
	    "Yaw:%.2f:Pitch:%.2f:Roll:%.2f:"
	    "Yaw(a):%.2f:MAG_h(a):%.2f:MAG_h:%.2f:"
	    "Ax:%.2f:Ay:%.2f:Az:%.2f:Mx:%.2f:My:%.2f:Mz:%.2f:"
	    "Gx:%.2f:Gy:%.2f:Gz:%.2f",
	    run_imu_data->timestamp,
	    run_imu_data->dt,
	    run_imu_data->data[0], run_imu_data->data[1], 
	    run_imu_data->data[2],
	    run_imu_data->data[3], run_imu_data->data[4], 
	    run_imu_data->data[5],
	    run_imu_data->data[6], run_imu_data->data[7], 
	    run_imu_data->data[8],
	    run_imu_data->data[9], run_imu_data->data[10], 
	    run_imu_data->data[11],
	    run_imu_data->data[12], run_imu_data->data[13], 
	    run_imu_data->data[14]);
  }
  else
  { //read failed, so log the failure
    sprintf(logbuf,"IMU data read failure");
  }
  run_imu_log_data(logbuf, log_imu_sockfd);
}

void run_imu_sigaction(void) 
{ 
  struct sigaction sigact;
  sigact.sa_handler = run_imu_handler;
  sigemptyset(&sigact.sa_mask);
  sigact.sa_flags = SA_RESTART;
  if (sigaction(SIGALRM, &sigact, NULL)) { 
    perror("sigaction failed");
    exit(-1);
  }
}

void run_imu_interrupt_on(int rate) 
{ 
  struct itimerval itimerval;
  itimerval.it_interval.tv_sec = 0;
  itimerval.it_interval.tv_usec = 1000000/rate;
  itimerval.it_value.tv_sec = 0;
  itimerval.it_value.tv_usec = 1000000/rate;
  setitimer(ITIMER_REAL, &itimerval, (struct itimerval *)0);
}
