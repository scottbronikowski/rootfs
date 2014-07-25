/*
  Implementation for standalone executable to run wheel encoders via Teensy board and Razor-IMU together

  Author: Scott Bronikowski
  Date: 23 July 2014
*/

#include "run-sensors.h"
#include <pthread.h>

//global constants (not declared elsewhere)
const speed_t sensors_speed = B57600; //both sensors run at 57,600 baud
const char* encoders_file = "/dev/Teensy";
const char* imu_file = "/dev/RazorIMU";
const char* k_imuLogPort = "2004";//using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
const int k_LogBufSize = 256;
const int sensors_connect_timeout_ms = 5000;
const std::string encoders_init_string = "#ob#o1#s";
const std::string imu_init_string = "#omb#o1#oe0#s";
//global variables
//extern
int log_sensors_sockfd;
int encoders_fd;
size_t encoders_input_pos;
int imu_fd;
size_t imu_input_pos;
//not extern
encoders_data_t* g_encoders_data;
imu_data_t* g_imu_data;
char g_logbuf[k_LogBufSize];

int main (int /*argc*/, char** /*argv*/)
{
  //  char logbuf[k_LogBufSize];
  int retval;
  memset(g_logbuf, 0, sizeof(g_logbuf));
  printf("Starting Run-Sensors\n");

  //connect to seykhl
  printf("Connecting to %s on port %s for IMU & encoder logging...\n",
  	 k_Server, k_imuLogPort);
  log_sensors_sockfd = -1;
  sprintf(g_logbuf, "Encoders logging started");
  while (log_sensors_sockfd == -1)
  {
    log_sensors_sockfd = ClientConnect(k_Server, k_imuLogPort);
  }
  retval = sensors_log_data(g_logbuf);
  if (retval != 0)
  {
    printf("connection failed, exiting.\n");
    return -1;
  }
  else
    printf("success!\n");

  //register signal handler for termination
  signal(SIGINT, sensors_terminator);
  signal(SIGTERM, sensors_terminator);

  g_encoders_data = new encoders_data_t;
  g_imu_data = new imu_data_t;

  //open fd for imu
  if (!sensors_open_serial_port(imu_fd, imu_file))
  {
    perror("Error opening serial port for IMU:");
    sensors_terminator(SIGTERM);
    return -1;
  }
  //open fd for encoders
  if (!sensors_open_serial_port(encoders_fd, encoders_file))
  {
    perror("Error opening serial port for encoders:");
    sensors_terminator(SIGTERM);
    return -1;
  }
  //printf("fds opened\n");
  //init imu
  if (!sensors_init(imu_fd, imu_init_string, imu_input_pos))
  {
    perror("Error in IMU init:");
    sensors_terminator(SIGTERM);
    return -1;
  }
  //init encoders
  if (!sensors_init(encoders_fd, encoders_init_string, encoders_input_pos))
  {
    perror("Error in encoders init:");
    sensors_terminator(SIGTERM);
    return -1;
  }
  //printf("init complete\n");
  // //test output from both -- ***DO WE NEED THIS??***
  // if (sensors_handler())
  //   printf("SUCCESS: %s\n", g_logbuf);
  // else
  //   printf("FAILURE: %s\n", g_logbuf);

  //main loop
  while (1)
  {
    if(!sensors_handler())
      printf("ERROR: %s\n", g_logbuf);
    sensors_log_data(g_logbuf);
  }

  //cleanup done in terminator
  return 0;
}

bool sensors_open_serial_port(int &fd, const char* filename)
{
  // O_NDELAY allows open even with no carrier detect
  if ((fd = open(filename, O_RDWR | O_NOCTTY | O_NDELAY)) == -1)
  { // something didn't work
    perror("sensors_open_serial_port:open");
    printf("with fd = %d, filename = %s\n", fd, filename);
    return false;
  }
  else
  { //we have a valid fd
    // make I/O blocking again
    if (!sensors_set_blocking_io(fd))
    {//something went wrong
      perror("sensors_open_serial_port:sensors_set_blocking_io");
      printf("with fd = %d, filename = %s\n", fd, filename);
      return false;
    }
    else //blocking IO set, now set other attributes
    {
      // get port attributes
      struct termios tio;
      if (tcgetattr(fd, &tio) != 0)
      {
	perror("sensors_open_serial_port:tcgetattr");
	printf("with fd = %d, filename = %s\n", fd, filename);
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
      if (cfsetispeed(&tio, sensors_speed) != 0)
      {
	perror("sensors_open_serial_port:cfsetispeed");
	printf("with fd = %d, filename = %s\n", fd, filename);
	return false;
      }
      if (cfsetospeed(&tio, sensors_speed) != 0)
      {
	perror("sensors_open_serial_port:cfsetospeed");
	printf("with fd = %d, filename = %s\n", fd, filename);
	return false;
      }
      // set port attributes
      // must be done after setting speed!
      if (tcsetattr(fd, TCSANOW, &tio) != 0)
      {
	perror("encoders_open_serial_port:tcsetattr");
	return false;
      }
      return true; //if we get here, everything worked
    }
  }
}

bool sensors_set_blocking_io(int fd)
{
  int flags;
  // clear O_NDELAY to make I/O blocking again
  // in fact this is semi-blocking, since we set VTIME on the port
  if (((flags = fcntl(fd, F_GETFL, 0)) != -1) &&
      (fcntl(fd, F_SETFL, flags & ~O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool sensors_set_nonblocking_io(int fd)
{
  int flags;
  // set O_NDELAY to make I/O non-blocking
  if (((flags = fcntl(fd, F_GETFL, 0)) != -1) &&
      (fcntl(fd, F_SETFL, flags | O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool sensors_is_io_blocking(int fd) {return (fcntl(fd, F_GETFL, 0) & O_NDELAY);}

long sensors_elapsed_ms(struct timeval start, struct timeval end)
{
  return static_cast<long> ((end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000);
}

bool sensors_init(int fd, const std::string init_string, size_t &input_pos)
{
  char in;
  int result;
  struct timeval t0, t1, t2;
  const std::string synch_token = "#SYNCH";
  const std::string new_line = "\r\n";

  // start time
  gettimeofday(&t0, NULL);

  // request synch token to see if device is really present
  const std::string contact_synch_id = "00"; 
  const std::string contact_synch_request = "#s" + contact_synch_id; 
  const std::string contact_synch_reply = synch_token + contact_synch_id + new_line;
  if (write(fd, contact_synch_request.data(), contact_synch_request.length()) != 
      (ssize_t)contact_synch_request.length())
  {
    perror("sensors_init:first synch");
    return false;
  }
  gettimeofday(&t1, NULL);
 // set non-blocking I/O
  if (!sensors_set_nonblocking_io(fd)) return false;

  /* look for tracker */
  while (true)
  {
    // try to read one byte from the port
    result = read(fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (sensors_read_token(contact_synch_reply, in, input_pos))
        break;
    }
    // no data available
    else if (result == 0)
      usleep(1000); // sleep 1ms
    // error?
    else
    {
      if (errno != EAGAIN && errno != EINTR)
        throw std::runtime_error("Can not read from serial port (1).");
    }
    
    // check timeout
    gettimeofday(&t2, NULL);
    if (sensors_elapsed_ms(t1, t2) > 200)
    {
      // 200ms elapsed since last request and no answer -> request synch again
      // (this happens when DTR is connected and device resets on connect)
      if (write(fd, contact_synch_request.data(), contact_synch_request.length()) !=
	  (ssize_t)contact_synch_request.length())
      {
	perror("encoders_init:second synch");
	return false;
      }
      t1 = t2;
    }
    if (sensors_elapsed_ms(t0, t2) > sensors_connect_timeout_ms)
      // timeout -> tracker not present
      throw std::runtime_error("Can not init: tracker does not answer.");
  }

  /* configure tracker */
  // set correct binary output mode, disale continuous streaming, disable errors and
  // request synch token. So we're good, no matter what state the tracker
  // currently is in.
  const std::string config_synch_id = "01";
  const std::string config_synch_reply = synch_token + config_synch_id + new_line;

  std::string config = init_string + config_synch_id; //constant output
  if (write(fd, config.data(), config.length()) != (ssize_t)config.length())
  {
    perror("sensors_init:write init");
    return false;
  }
  
  // set blocking I/O
  // (actually semi-blocking, because VTIME is set)
  if (!sensors_set_blocking_io(fd)) return false;

  while (true)
  {    
    // try to read one byte from the port
    result = read(fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (sensors_read_token(config_synch_reply, in, input_pos))
        break;  // alrighty
    }
    // error?
    else
    {
      if (errno != EAGAIN && errno != EINTR)
        throw std::runtime_error("Can not read from serial port (2).");
    }
  }
  
  // we keep using blocking I/O
  //if (_set_blocking_io() == -1)
  //  return false;

  return true;
}

bool sensors_read_token(const std::string &token, char c, size_t &input_pos)
{
    if (c == token[input_pos++])
  {
    if (input_pos == token.length())
    {
      // synch token found
      input_pos = 0;
      return true;
    }
  }
  else
  {
    input_pos = 0;
  }
  return false;
}

bool encoders_read_data(encoders_data_t* data)
{
 int result;
  char c;
  unsigned long t = 0;
  unsigned char buf[4];
  //zero out data;
  data->timestamp = 0;
  data->dt = 0;
  for (int i = 0; i < 2; i++)
    data->cm[i] = 0.0f;
  //read new data
  while (true)
  {
    //first get cm measurements (floats)
    if ((result = read(encoders_fd, &c, 1)) > 0)
    { //read binary stream
      // (type-punning: aliasing with char* is ok)
      (reinterpret_cast<char*> (&data->cm))[encoders_input_pos++] = c;
      if (encoders_input_pos == 8) // we received both (2 data elements * 4 bytes each)
      {                
	//then get the two unsigned longs (timestamp and dt)
	//got the floats, so now get the twounsigned long ints
	for (int j = 0; j < 2; j++)
	{
	  for (int i = 0; i < 4; i++)
	  {
	    if ((result = read(encoders_fd, &buf[i], 1)) > 0)
	      continue;
	    else if (result < 0)
	      perror("encoders_read_data:failed timestamp read");
	  }
	  memcpy(&t, buf, 4);
	  if (j == 0)
	    data->timestamp = t;
	  else if (j == 1)
	  {
	    data->dt = t;
	    //now we're done, so reset position counter and return success
	    encoders_input_pos = 0;
	    return true;
	  }
	}
      }
    }
    else if (result < 0)
    {
      if (errno != EAGAIN && errno != EINTR)
      {
        perror("encoders_read_data:cannot read from serial port");
        return false; //failure
      }
    }
    //else result is 0, so no data available (keep waiting)
  }
}

bool imu_read_data(imu_data_t* data)
{
  int result;
  char c;
  unsigned long t = 0;
  unsigned char buf[4];
  //zero out data
  for (int i = 0; i < 15; i++) //**HARDCODED to number of elements in array--need to change if array changes in razor-imu.h
  {
    data->data[i] = 0.0f;
  }
  //data->timestamp = 0;
  // //send frame request --NOT NEEDED FOR CONSTANT OUTPUT
  // const char* framerequest = "#f";
  // int testretval = write(gl_imu_fd, framerequest, strlen(framerequest));
  // if (testretval != (int)strlen(framerequest))
  // {
  //   printf("razor_read_data error writing frame requests, testretval = %d\n", 
  // 	   testretval);
  //   return false;
  // }
  //read data
  while (true)
  {
    if ((result = read(imu_fd, &c, 1)) > 0)
    { //read binary stream
      // (type-punning: aliasing with char* is ok)
      (reinterpret_cast<char*> (&data->data))[imu_input_pos++] = c;
      if (imu_input_pos == 60) // we received a full frame
      {                 //***HARDCODED for 15 data elements * 4 bytes each
	//got the floats, so now get the two unsigned longs (timestamp and dt)
	for (int j = 0; j < 2; j++)
	{
	  for (int i = 0; i < 4; i++)
	  {
	    //if ((result = read(gl_imu_fd, &c, 1)) > 0)
	    if ((result = read(imu_fd, &buf[i], 1)) > 0)
	    {
	      //printf("buf[i] = %d\n", buf[i]);
	      continue;
	      //printf("c = %d\n", c);
	      //t += c * (unsigned long)pow(256.0,(float)i);
	    }
	    else if (result < 0)
	      perror("imu_read_data:failed timestamp read");
	  }
	  memcpy(&t, buf, 4);
	  if (j == 0)
	    data->timestamp = t;
	  else if (j == 1)
	  {
	    data->dt = t;
	    //done, so reset position counter and return success
	    imu_input_pos = 0;
	    return true;
	  }
	}
      }
    }
    else if (result < 0)
    {
      if (errno != EAGAIN && errno != EINTR)
      {
        perror("imu_read_data:cannot read from serial port");
        return false; //failure
      }
    }
    //else result is 0, so no data available (keep waiting)
  }
}

double sensors_current_time(void)
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

int sensors_log_data(char* databuf)
{
  double now = sensors_current_time(); 
  char sendbuf[k_LogBufSize];
  char temp[k_LogBufSize];
  int retval;
  memset(temp, 0, sizeof(temp));
  retval = snprintf(temp, k_LogBufSize, "%.6f: EIS:%s", now, databuf);
  if (retval >= k_LogBufSize)
  {
    printf("run_sensors_log_data: message truncated: %s\n  %s\n", databuf, temp);
    return -1;
  }
  if (retval < 0)
  {
    printf("run_sensors_log_data: encoding eror\n");
    return -1;
  }
  //if we get here, we have something to send in temp
  memset(sendbuf, 0, sizeof(sendbuf));
  strncpy(sendbuf, temp, sizeof(sendbuf));  //use this to pad buffer
  retval = send(log_sensors_sockfd, sendbuf, sizeof(sendbuf), 0);
  if (retval != k_LogBufSize)
  {
    printf("run_sensors_log_data: send failed\n");
    return -1;
  }
  else
    return 0; //success
}

void sensors_terminator(int signum)
{
  close(imu_fd);
  close(encoders_fd);
  close(log_sensors_sockfd);
  delete g_encoders_data;
  delete g_imu_data;
  printf("Run-Sensors: Sensor logging socket closed\n");
  exit(signum);
}

bool sensors_handler(void)
{
  //  char logbuf[k_LogBufSize];  //made this global
  // printf("in sensors_handler\n");
  bool retval = true;
  char encbuf[50]; //estimated max size of encoder data
  char imubuf[k_LogBufSize-50];
  memset(g_logbuf, 0, sizeof(g_logbuf)); //clear buffers
  memset(encbuf, 0, sizeof(encbuf));
  memset(imubuf, 0, sizeof(imubuf));
  if (imu_read_data(g_imu_data))
  { //successful read, so put into imubuf
    // printf("IMU:time:%lu:dt:%lu:"
    // 	    "Y:%.2f:P:%.2f:R:%.2f:"
    // 	    "Y(a):%.2f:M_h(a):%.2f:M_h:%.2f:"
    // 	    "Ax:%.2f:Ay:%.2f:Az:%.2f:Mx:%.2f:My:%.2f:Mz:%.2f:"
    // 	    "Gx:%.2f:Gy:%.2f:Gz:%.2f\n",
    // 	    g_imu_data->timestamp,
    // 	    g_imu_data->dt,
    // 	    g_imu_data->data[0], g_imu_data->data[1], g_imu_data->data[2],
    // 	    g_imu_data->data[3], g_imu_data->data[4], g_imu_data->data[5],
    // 	    g_imu_data->data[6], g_imu_data->data[7], g_imu_data->data[8],
    // 	    g_imu_data->data[9], g_imu_data->data[10], g_imu_data->data[11],
    // 	    g_imu_data->data[12], g_imu_data->data[13], g_imu_data->data[14]);
    sprintf(imubuf, "IMU:time:%lu:dt:%lu:"
	    "Y:%.2f:P:%.2f:R:%.2f:"
	    "Y(a):%.2f:M_h(a):%.2f:M_h:%.2f:"
	    "Ax:%.2f:Ay:%.2f:Az:%.2f:Mx:%.2f:My:%.2f:Mz:%.2f:"
	    "Gx:%.2f:Gy:%.2f:Gz:%.2f",
	    g_imu_data->timestamp,
	    g_imu_data->dt,
	    g_imu_data->data[0], g_imu_data->data[1], g_imu_data->data[2],
	    g_imu_data->data[3], g_imu_data->data[4], g_imu_data->data[5],
	    g_imu_data->data[6], g_imu_data->data[7], g_imu_data->data[8],
	    g_imu_data->data[9], g_imu_data->data[10], g_imu_data->data[11],
	    g_imu_data->data[12], g_imu_data->data[13], g_imu_data->data[14]);
  }
  else
  { //read failed, so log failure and set retval false
    sprintf(imubuf, "IMU data read failed");
    retval = false;
  }
  //printf("after imu read\n");
  memset(encbuf, 0, sizeof(encbuf));
  if (encoders_read_data(g_encoders_data))
  { //successful read, so put data into logbuf
    sprintf(encbuf,":ENC:time:%lu:dt:%lu:L:%.3f:R:%.3f",
	    g_encoders_data->timestamp, g_encoders_data->dt,
	    g_encoders_data->cm[0], g_encoders_data->cm[1]);

  }
  else
  { //read failed, so log failure and set retval false
    sprintf(encbuf, ":Encoders data read failed");
    retval = false;
  }
  //printf("after encoder read\n");
  strncpy(g_logbuf, imubuf, strlen(imubuf));
  //printf("after strncpy\n");
  strncat(g_logbuf, encbuf, strlen(encbuf));
  //printf("after strncat\n");
  return retval; //if neither read failed, retval will be true
}
