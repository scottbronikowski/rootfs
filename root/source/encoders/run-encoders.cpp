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
const int encoders_connect_timeout_ms = 5000;
//k_imuLogPort, k_LogBufSize, imu_rate declared in emperor.h (which we can't include here)
const char* k_imuLogPort = "2004"; //using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
const int k_LogBufSize = 256; //100;

//global variables
//extern'd'
int encoders_fd;
int log_encoders_sockfd;
size_t encoders_input_pos;
//FILE* encoders_file_ptr;
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
  //encoders_file_ptr = fdopen(encoders_fd, "r"); //DO I NEED THIS? not using fgets()

  //encoder init function (like razor_init)
  if (!encoders_init())
  {
    perror("encoders_init failed");
    run_encoders_terminator(SIGTERM);
    return -1;
  }
  run_encoders_data = new encoders_data_t;

  //test encoder output
  if (!encoders_read_data(run_encoders_data))
  {
    perror("encoders_read_data failed");
    run_encoders_terminator(SIGTERM);
    return -1;
  }
  else
  { //read succeeded, so print it out
    printf("Encoders initialized in run-encoders\n");
    // printf("Timestamp = %lu, dt = %lu, Left = %.3f cm, Right = %.3f cm\n",
    // 	    run_encoders_data->timestamp,
    // 	    run_encoders_data->dt,
    // 	    run_encoders_data->cm[0],
    // 	    run_encoders_data->cm[1]);
  }    
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

  //run a small loop here to clear messages backed up in serial buffer
  struct timeval mark, now;
  gettimeofday(&mark, NULL);
  gettimeofday(&now, NULL);
  while (encoders_elapsed_ms(mark, now) < 200)
  {
    encoders_read_data(run_encoders_data); //read the data and do nothing
    gettimeofday(&now, NULL);  //update time hack
  }
  

  while(1)
  { // main loop
    run_encoders_handler(1);
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
  //fclose(encoders_file_ptr);
  close(encoders_fd);
  close(log_encoders_sockfd);
  delete run_encoders_data;
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

void run_encoders_handler(int signum)
{
  char logbuf[k_LogBufSize];
  memset(logbuf, 0, sizeof(logbuf));  //clear buffer
  if (encoders_read_data(run_encoders_data))
  { //successful read, so put data into logbuf
    sprintf(logbuf,"time:%lu:dt:%lu:L:%.3f:R:%.3f",
	    run_encoders_data->timestamp,
	    run_encoders_data->dt,
	    run_encoders_data->cm[0],
	    run_encoders_data->cm[1]);
  }
  else
  { //read failed, so log the failure
    sprintf(logbuf,"Encoders data read failure");
  }
  run_encoders_log_data(logbuf, log_encoders_sockfd);
}

bool encoders_init(void)
{
  char in;
  int result;
  struct timeval t0, t1, t2;
  const std::string synch_token = "#SYNCH";
  const std::string new_line = "\r\n";

  // start time
  gettimeofday(&t0, NULL);

  // request synch token to see if Teensy is really present
  const std::string contact_synch_id = "00"; 
  const std::string contact_synch_request = "#s" + contact_synch_id; 
  const std::string contact_synch_reply = synch_token + contact_synch_id + new_line;
  if (write(encoders_fd, contact_synch_request.data(), 
	    contact_synch_request.length()) != 
      (ssize_t)contact_synch_request.length())
  {
    perror("encoders_init:first synch");
    return false;
  }
  gettimeofday(&t1, NULL);
 // set non-blocking I/O
  if (!encoders_set_nonblocking_io()) return false;

  /* look for tracker */
  while (true)
  {
    // try to read one byte from the port
    result = read(encoders_fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (encoders_read_token(contact_synch_reply, in))
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
    if (encoders_elapsed_ms(t1, t2) > 200)
    {
      // 200ms elapsed since last request and no answer -> request synch again
      // (this happens when DTR is connected and Teensy resets on connect)
      if (write(encoders_fd, contact_synch_request.data(), 
		contact_synch_request.length()) !=
	  (ssize_t)contact_synch_request.length())
      {
	perror("encoders_init:second synch");
	return false;
      }
      t1 = t2;
    }
    if (encoders_elapsed_ms(t0, t2) > encoders_connect_timeout_ms)
      // timeout -> tracker not present
      throw std::runtime_error("Can not init: tracker does not answer.");
  }

  /* configure tracker */
  // set correct binary output mode, disale continuous streaming, disable errors and
  // request synch token. So we're good, no matter what state the tracker
  // currently is in.
  const std::string config_synch_id = "01";
  const std::string config_synch_reply = synch_token + config_synch_id + new_line;

  std::string config = "#o1#s" + config_synch_id; //constant output
  config = "#ob" + config;
  if (write(encoders_fd, config.data(), config.length()) != (ssize_t)config.length())
  {
    perror("encoders_init:write init");
    return false;
  }
  
  // set blocking I/O
  // (actually semi-blocking, because VTIME is set)
  if (!encoders_set_blocking_io()) return false;

  while (true)
  {    
    // try to read one byte from the port
    result = read(encoders_fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (encoders_read_token(config_synch_reply, in))
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

long encoders_elapsed_ms(struct timeval start, struct timeval end)
{
  return static_cast<long> ((end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000);
}

bool encoders_read_token(const std::string &token, char c)
{
  if (c == token[encoders_input_pos++])
  {
    if (encoders_input_pos == token.length())
    {
      // synch token found
      encoders_input_pos = 0;
      return true;
    }
  }
  else
  {
    encoders_input_pos = 0;
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
