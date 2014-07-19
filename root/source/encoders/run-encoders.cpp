/*
  Implementation for standalone executable to run wheel encoders via Teensy board

  Author: Scott Bronikowski
  Date: 19 July 2014
*/

#include "run-encoders.h"
#include <pthread.h>

//global constants
//k_Server declared in toollib-camera.h
const speed_t encoders_speed = B57600;
const char* encoders_file = "/dev/Teensy";
//k_imuLogPort, k_LogBufSize, imu_rate declared in emperor.h (which we can't include here)
const char* k_imuLogPort = "2004"; //using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
const int k_LogBufSize = 256; //100;


//global variables
//extern'd'
int encoders_fd;
int log_encoders_sockfd;
FILE* encoders_file_ptr;
//not extern'd
encoders_data_t* run_encoders_data;

int main (int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  memset(logbuf, 0, sizeof(logbuf));
  printf("Starting Run-Encoders\n");

  //open fd for encoders
  if (!encoders_open_serial_port())
  {
    printf("Error in encoders_open_serial_port\n");
    if (encoders_fd < 1)
    {
      perror("encoders:");
      return -1;
    }
  }
  //get file pointer from fd
  encoders_file_ptr = fdopen(encoders_fd, "r"); //DO I NEED THIS? not using fgets()

  //encoder init function (like razor_init)

  //test encoder output

  //connect to seykhl
  printf("Connecting to %s on port %s for encoder logging...\n",
	 k_Server, k_imuLogPort);
  log_encoders_sockfd = -1;
  sprintf(logbuf, "Encoders logging started");
  while (log_encoders_sockfd == -1)
  {
    log_encoders_sockfd = ClientConnect(k_Server, k_imuLogPort);
  }
  retval = run_encoders_log_data(logbuf, log_encoders_sockfd);
  if (retval != 0)
    printf("connection failed\n");
  else
    printf("success!\n");
  
  //register signal handler for termination
  signal(SIGINT, run_encoders_terminator);
  signal(SIGTERM, run_encoders_terminator);

  while(1)
  { // main loop
    memset(logbuf, 0, sizeof(logbuf)); //clear buffer
    // if (fgets(logbuf, k_LogBufSize, gps_file_ptr) != NULL)
    // {
    //   retval = strlen(logbuf);
    //   if (retval <= 0) //error
    //   {
    // 	perror("gps_main:read");
    // 	printf("retval = %d\n", retval);
    // 	//break;
    // 	continue;
    //   }
    //   else 
    //   { //message received, so check if it's one we want
    // 	if ((strncmp(logbuf, GGA, strlen(GGA)) == 0) ||
    // 	    (strncmp(logbuf, RMC, strlen(RMC)) == 0))
    // 	{
    // 	  //remove last character (always a newline)
    // 	  logbuf[retval - 1] = 0;
    // 	  //now send it
    // 	  run_gps_log_data(logbuf, log_gps_sockfd);
    // 	  //printf("Logged: %s\n", logbuf);
    // 	}
    // 	else //ignore other messages from GPS
    // 	{
    // 	  //printf("Ignored: %s\n", logbuf);
    // 	  continue;
    // 	}
    //   }
    // }
  }

  //cleanup done in run_gps_terminator
  return 0;
}

bool encoders_open_serial_port()
{
  // O_NDELAY allows open even with no carrier detect
  if ((encoders_fd = open(encoders_file, O_RDWR | O_NOCTTY | O_NDELAY)) == -1)
  { // something didn't work
    perror("encoders_open_serial_port:open");
    return false;
  }
  else
  { //we have a valid fd
    // make I/O blocking again
    if (!encoders_set_blocking_io())
    {//something went wrong
      perror("encoders_open_serial_port:encoders_set_blocking_io");
      return false;
    }
    else //blocking IO set, now set other attributes
    {
      // get port attributes
      struct termios tio;
      if (tcgetattr(encoders_fd, &tio) != 0)
      {
	perror("encoders_open_serial_port:tcgetattr");
	return false;
      }
      /* see http://www.easysw.com/~mike/serial/serial.html */
      /* and also http://linux.die.net/man/3/tcsetattr */
      // basic raw/non-canonical setup
      cfmakeraw(&tio);
      // enable reading and ignore control lines
      tio.c_cflag |= CREAD | CLOCAL;
      // set 8N1
      tio.c_cflag &= ~PARENB; // no parity bit
      tio.c_cflag &= ~CSTOPB; // only one stop bit
      tio.c_cflag &= ~CSIZE;  // clear data bit number
      tio.c_cflag |= CS8;     // set 8 data bits
      // no hardware flow control
      tio.c_cflag &= ~CRTSCTS;
      // no software flow control  
      tio.c_iflag &= ~(IXON | IXOFF | IXANY);
      // poll() is broken on OSX, so we set VTIME and use read(), which is ok since
      // we're reading only one port anyway
      tio.c_cc[VMIN]  = 0;//143; //set minimum number of bytes per read
      tio.c_cc[VTIME] = 10; // 10 * 100ms = 1s
      // set port speed
      if (cfsetispeed(&tio, encoders_speed) != 0)
      {
	perror("encoders_open_serial_port:cfsetispeed");
	return false;
      }
      if (cfsetospeed(&tio, encoders_speed) != 0)
      {
	perror("encoders_open_serial_port:cfsetospeed");
	return false;
      }
      // set port attributes
      // must be done after setting speed!
      if (tcsetattr(encoders_fd, TCSANOW, &tio) != 0)
      {
	perror("encoders_open_serial_port:tcsetattr");
	return false;
      }
      return true; //if we get here, everything worked
    }
  }
}

bool encoders_set_blocking_io()
{
  int flags;
  // clear O_NDELAY to make I/O blocking again
  // in fact this is semi-blocking, since we set VTIME on the port
  if (((flags = fcntl(encoders_fd, F_GETFL, 0)) != -1) &&
      (fcntl(encoders_fd, F_SETFL, flags & ~O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool encoders_set_nonblocking_io()
{
  int flags;
  // set O_NDELAY to make I/O non-blocking
  if (((flags = fcntl(encoders_fd, F_GETFL, 0)) != -1) &&
      (fcntl(encoders_fd, F_SETFL, flags | O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool encoders_is_io_blocking(int fd)
{
  return (fcntl(fd, F_GETFL, 0) & O_NDELAY);
}

void run_encoders_terminator(int signum)
{
  fclose(encoders_file_ptr);
  close(encoders_fd);
  close(log_encoders_sockfd);
  printf("Run-Encoders: Encoders logging socket closed\n");
  exit(signum);
}

int run_encoders_log_data(char* databuf, int log_fd)
{
  double now = run_encoders_current_time(); 
  char sendbuf[k_LogBufSize];
  char temp[k_LogBufSize];
  int retval;
  memset(temp, 0, sizeof(temp));
  retval = snprintf(temp, k_LogBufSize, "%.6f: ENC:%s", now, databuf);
  if (retval >= k_LogBufSize)
  {
    printf("run_encoders_log_data: message truncated: %s\n  %s\n", databuf, temp);
    return -1;
  }
  if (retval < 0)
  {
    printf("run_encoders_log_data: encoding eror\n");
    return -1;
  }
  //if we get here, we have something to send in temp
  memset(sendbuf, 0, sizeof(sendbuf));
  strncpy(sendbuf, temp, sizeof(sendbuf));  //use this to pad buffer
  retval = send(log_fd, sendbuf, sizeof(sendbuf), 0);
  if (retval != k_LogBufSize)
  {
    printf("run_encoders_log_data: send failed\n");
    return -1;
  }
  else
    return 0; //success
}

double run_encoders_current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

// void run_imu_handler(int signum)
// {
//   char logbuf[k_LogBufSize];
//   memset(logbuf, 0, sizeof(logbuf));  //clear buffer
//   if (razor_read_data(run_imu_data))
//   { //successful read, so put data into logbuf
//     sprintf(logbuf, "IMU:time:%lu:"
// 	    "Yaw:%.2f:Pitch:%.2f:Roll:%.2f:"
// 	    "Yaw(a):%.2f:MAG_h(a):%.2f:MAG_h:%.2f:"
// 	    "Ax:%.2f:Ay:%.2f:Az:%.2f:Mx:%.2f:My:%.2f:Mz:%.2f:"
// 	    "Gx:%.2f:Gy:%.2f:Gz:%.2f",
// 	    run_imu_data->timestamp,
// 	    run_imu_data->data[0], run_imu_data->data[1], 
// 	    run_imu_data->data[2],
// 	    run_imu_data->data[3], run_imu_data->data[4], 
// 	    run_imu_data->data[5],
// 	    run_imu_data->data[6], run_imu_data->data[7], 
// 	    run_imu_data->data[8],
// 	    run_imu_data->data[9], run_imu_data->data[10], 
// 	    run_imu_data->data[11],
// 	    run_imu_data->data[12], run_imu_data->data[13], 
// 	    run_imu_data->data[14]);
//   }
//   else
//   { //read failed, so log the failure
//     sprintf(logbuf,"IMU data read failure");
//   }
//   run_imu_log_data(logbuf, log_imu_sockfd);
// }

