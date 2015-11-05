/*

  Implementation for main control program to run vader-rover for automated driving.
  Basically a merge of the old emperor and run-sensors programs, along with Dan's code in log_to_track.cpp to do Kalman filter position finding from sensor data

  Author: Scott Bronikowski
  Date: 16 October 2014

  Edited beginning on 28 October 2015 to add a second barrier to control the camera thread and ensure that this thread executes at exactly 10 Hz while the other threads execute at 50 Hz.
*/

#include "the-force.h"

using namespace cv;

//global constants
const double k_PI = 3.1415926535897932384626433832795028841971693993751058;
//(from emperor)
const int BACKLOG = 5;
const char* k_CommandPort = "1999";
const int k_maxBufSize = 50;
//used for buffer of trace points, replaces k_maxBufSize in send/receive
const int k_traceBufSize = 5000; //max # of bytes in trace
const char* cmd_start_cameras = "start_cameras";
const char* cmd_stop_cameras = "stop_cameras";
const char* cmd_forward_4 = "forward_4";
const char* cmd_forward_3 = "forward_3";
const char* cmd_forward_2 = "forward_2";
const char* cmd_forward_1 = "forward_1";
const char* cmd_stop = "stop";
const char* cmd_reverse_1 = "reverse_1";
const char* cmd_reverse_2 = "reverse_2";
const char* cmd_reverse_3 = "reverse_3";
const char* cmd_reverse_4 = "reverse_4";
const char* cmd_forward_right_1 = "forward_right_1";
const char* cmd_forward_right_2 = "forward_right_2";
const char* cmd_forward_left_1 = "forward_left_1";
const char* cmd_forward_left_2 = "forward_left_2";
const char* cmd_pivot_left_1 = "pivot_left_1";
const char* cmd_pivot_left_2 = "pivot_left_2";
const char* cmd_pivot_right_1 = "pivot_right_1";
const char* cmd_pivot_right_2 = "pivot_right_2";
const char* cmd_reverse_left_1 = "reverse_left_1";
const char* cmd_reverse_left_2 = "reverse_left_2";
const char* cmd_reverse_right_1 = "reverse_right_1";
const char* cmd_reverse_right_2 = "reverse_right_2";
const char* cmd_servo = "servo";
const char* pan_file = "/dev/pwm10";
const char* tilt_file = "/dev/pwm9";
const char* k_LogPort = "2001";
const int k_msg_buf_threshold = (int)(0.85 * k_msg_buf_size); //for buffer_and_send
//for bump switch monitoring
const int bump_move_time = 50000;
const int bump_read_size = 24;
const int bump_front = 185; //gpio 185
const int bump_rear = 184; //gpio 184
const char* gpio_file = "/dev/gpio-event";
//(from run-sensors)
const speed_t sensors_speed = B57600; //both sensors run at 57,600 baud
const char* encoders_file = "/dev/Teensy";
const char* imu_file = "/dev/RazorIMU";
const speed_t gps_speed = B4800; //GPS runs at 4800 baud
const char* gps_file = "/dev/GPS";
const char* GGA = "$GPGGA";
const char* RMC = "$GPRMC";
const char* k_imuLogPort = "2004";//using imu-log.txt as consolidated log for IMU, GPS, and encoders--not worth the effort to change the name in the code
const int sensors_connect_timeout_ms = 5000;
const std::string encoders_init_string = "#ob#o0#s";
const std::string imu_init_string = "#omb#o1#oe0#s"; //#o0 for POLLING #o1 for streaming
//for driving logic
const double k_distance_threshold = 0.1;  //in meters
const double k_angle_threshold_1 = k_PI/12; //15 degrees in radians--for deciding whether to pivot or turn while going forward
const double k_angle_threshold_2 = k_PI/36; //5 degrees in radians--for deciding whether to go straight or turn toward point
const int k_gpsWorkingBufSize = 256;


//global variables
//extern'd in header file
//(from emperor)
int sockfd, log_sockfd;
int pan_fd, tilt_fd, motor_fd, gpio_fd;
//(from run-sensors)
int log_sensors_sockfd;
int encoders_fd;
size_t encoders_input_pos;
int imu_fd;
size_t imu_input_pos;
int gps_fd;
FILE* gps_file_ptr;
//for threading
int msg_count;
char g_msg_buf[k_msg_buf_bytes];
pthread_mutex_t msg_buf_and_count_lock;
//for barriers  
unsigned long int frame_number =  0;
unsigned long int frame_number_cameras = 0;
int running = FALSE, halt = FALSE;
unsigned int threads = MAX_THREADS;
void *((*task[MAX_THREADS+1])(void *)) = {&imu_task, 
					  &encoders_task,
					  &gps_task,
					  &buffer_and_send_task,
					  &estimate_and_move_task,
					  &bump_switches_task,
					  &cameras_task};
pthread_t thread[MAX_THREADS+1];
struct task_args task_args[MAX_THREADS+1];
pthread_mutex_t halt_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_barrier_t barrier;
pthread_barrier_t barrier2;
int time_threads = FALSE;
double fps = 50.0; //sensor readings per sec (Hz)
int sensor_cam_ratio = 5; //number of sensor readings per camera frame
double fps2 = fps / sensor_cam_ratio; //camera fps
bool route_complete = false;
bool last_send = false;


//not extern'd
pose_t g_my_pose = {0.0,0.0,k_PI/2}; //robot's current location
      //initialized to x=0, y=0, theta = pi/2 (due north in polar radians)
//(from run-sensors)
encoders_data_t* g_encoders_data;
imu_data_t* g_imu_data;
NMEAParser g_parser;
int g_gps_new_data;
char g_gps_buf[k_LogBufSize];
char g_routebuf[k_traceBufSize];
location_t g_waypoints[200];  //HARDCODED limit of 200 waypoints in a route
int g_num_waypoints, g_waypoint_index;
Mat g_MeasurementModel = Mat::zeros(7,8,CV_32F);
Mat g_MeasurementModel_noGPS = Mat::zeros(7,8,CV_32F);
Mat g_TransitionModel =  Mat::zeros(8,8,CV_32F);
KalmanFilter g_KF(8, 7, 2); // 8 state variables, 7 measurements, 2 inputs
char g_motor_prev[k_maxBufSize]; //previous motor command
char global_estimate_buf[k_LogBufSize];
char local_estimate_buf[k_LogBufSize];
char g_gps_working_buf[k_gpsWorkingBufSize];
int g_gps_working_buf_index = 0;
char global_waypoint_buf[k_LogBufSize];
bool global_waypoint_flag = false;
char local_waypoint_buf[k_LogBufSize];
//for cameras (new 30Oct15)
BusManager g_busMgr;
unsigned int g_numCameras = 0;
PointGrey_t* g_PG;
//for bump switches (new 5Nov15)
int g_bump_retval, g_bump_gpio_num;
char g_bump_readbuffer[bump_read_size];
char g_bump_logbuf[k_LogBufSize];
fd_set g_bump_recv_set;
struct timeval g_bump_timeout;

//from Dan's log_to_track.cpp
// state:
// [x y theta dtheta sl sr dsl dsr]
// x and y position
// orientaion angle and derivative
// left and right wheel speeds
// left and right wheel speed derivatives

// measured values:
// x and y (gps)
// theta (imu)
// dtheta (gyro)
// left and right wheel speeds (encoders)
// acceleration of rover body (accelerometer)

// arbitrarily eyeballed variance estimates which we may want to change:
// I am assuming meters, meters/second, etc for the units

// measurement noise variance:
// there is actually a whole covariance matrix to specify, but i am assuming independence between them
float mXN = 5.0; //  GPS X noise variance
float mYN = 5.0; //  GPS Y noise variance
float mThetaN = 1000000000 * (k_PI/180); //  orientation noise variance (radians)
float mdThetaN = 0.0001; //  orientation derivative noise variance (radians)
float mSLN = .01; //  left wheel speed noise variance
float mSRN = .01; //  right wheel speed noise variance
float mAN  = 100000000; //  acceleration noise variance

// process noise variance
// there is actually a whole covariance matrix to specify, but i am assuming independence between them
float pXN = 1e-6; //  GPS X noise variance
float pYN = 1e-6; //  GPS Y noise variance
float pThetaN = 1 * (k_PI/180); //  orientation noise variance (radians)
float pdThetaN = 1000000; //  orientation derivative noise variance (radians)
float pSLN = 1000000; //  left wheel speed noise variance
float pSRN = 1000000; //  right wheel speed noise variance
float pdSLN = 1000000; //  left wheel speed derivative noise variance
float pdSRN = 1000000; //  right wheel speed derivative noise variance

// parameters for simplified motor physics:
// motor given 0-255 integer input I_m
// assume that force F is linearly proportional to this number by constant a:
// F = a*I_m
// assume there is also a friction force linearly dependent on wheel speed S_m by constant b:
//  F_f = -b*S_m
// assume there is some fixed mass which we bake into the proportionality constants:
// acceleration A = alpha*I_m - beta*S_m
// need to specify alpha and beta (potentially for each motor separately):
// we really should find these by computing stuff from measurements
float alpha = 1; // ????
float beta = 1; // ????

float rover_width = .3110019808409256; 
float tau_L = 3.048837255989942e-05; //left meters per tick
float tau_R = 3.056925451030081e-05; //right meters per tick
float gyro_offset = 14.98;
float radians_per_gyro_unit = 2*k_PI/5.076295665184609e+03;


int main(int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  printf("Starting The Force\n");
  printf("Please ensure that driver-gui.sc (viewer '()) is running on %s\n", k_Server);
  //open local fds
  pan_fd = open(pan_file, O_WRONLY);
  if (pan_fd < 1)
  {
    perror("pan:");
    the_force_terminator(SIGTERM);
    return -1;
  }
  tilt_fd = open(tilt_file, O_WRONLY);
  if (tilt_fd < 1)
  {
    perror("tilt:");
    the_force_terminator(SIGTERM);
    return -1;
  }
  motor_fd = initport();
  if (motor_fd < 1)
  {
    perror("motor:");
    the_force_terminator(SIGTERM);
    return -1;
  }
  gpio_fd = open(gpio_file, O_RDONLY);
  if (gpio_fd < 1)
  {
    perror("gpio:");
    the_force_terminator(SIGTERM);
    return -1;
  }
  //start network stuff and wait for connection
  printf("Connecting to %s on port %s for commands...\n", k_Server, k_CommandPort);
  sockfd = -1;
  while (sockfd == -1)
  {
    sockfd = ClientConnect(k_Server, k_CommandPort);
  }
  printf("success!\n");
  
  printf("Connecting to %s on port %s for data logging...\n", k_Server, k_LogPort);
  log_sockfd = -1;
  while (log_sockfd == -1)
  {
    log_sockfd = ClientConnect(k_Server, k_LogPort);
  }
  sprintf(logbuf, "Logging started in AUTOMATIC (the-force) mode");
  emperor_log_data(logbuf, log_sockfd);
  printf("success!\n");
  printf("log_sockfd = %d\n", log_sockfd);
 
  //register signal handler for termination
  signal(SIGINT, the_force_terminator);
  signal(SIGTERM, the_force_terminator);

  char prevmsgbuf[k_traceBufSize];
  memset(prevmsgbuf, 0, sizeof(prevmsgbuf));

  //loop on listening for commands 
  //play "what is thy bidding" here (or maybe inside loop)
  while(1)
  {
    memset(g_routebuf, 0, sizeof(g_routebuf)); //clear buffer **THIS MIGHT CAUSE PROBLEMS**
    retval = recv(sockfd, &g_routebuf, sizeof(g_routebuf), 0);
    if (retval < 0)
    {
      printf("Error in recv\n");
      the_force_terminator(SIGTERM);
      return -1;
    }
    if (retval == 0)
    {
      printf("Sender closed connection\n");
      the_force_terminator(SIGTERM);
      return -1;
    }
    //if we get here, we have something useful in msgbuf, so do something with it
    if (strncmp(g_routebuf, prevmsgbuf, k_traceBufSize) != 0) //received new command
    {
      strncpy(prevmsgbuf, g_routebuf, k_traceBufSize);
    }
    else //got a repeat of the last received command, so ignore it
      continue;
    //do stuff with commands received
    start_barrier_threads();
    while (!route_complete) {
      usleep(1*1000*1000);//sleep while waiting for route_complete
    }
    stop_barrier_threads();
    printf("Trace following complete for: %s\n", g_routebuf);
  }
  //cleanup done in terminator (called automatically when program terminates)
  return 0;
}


void the_force_terminator(int signum)
{
  //SEND A STOP FIRST, JUST IN CASE
  motor_stop(motor_fd);
  //stop barrier-ed threads
  stop_barrier_threads();
  //cleanup socket and file handles
  close(pan_fd);
  close(tilt_fd);
  close(motor_fd);
  close(log_sockfd);
  printf("data logging socket closed\n");
  close(sockfd);
  printf("command socket closed, exiting\n");
  exit(signum);
}

int emperor_log_data(char* databuf, int log_fd)
{
  double now = emperor_current_time(); 
  char sendbuf[k_LogBufSize];
  char temp[k_LogBufSize];
  int retval;
  memset(temp, 0, sizeof(temp));
  retval = snprintf(temp, k_LogBufSize, "%.6f: %s", now, databuf);
  if (retval >= k_LogBufSize)
  {
    printf("emperor_log_data: message truncated: %s\n  %s\n", databuf, temp);
    return -1;
  }
  if (retval < 0)
  {
    printf("emperor_log_data: encoding eror\n");
    return -1;
  }
  //if we get here, we have something to send in temp
  memset(sendbuf, 0, sizeof(sendbuf));
  strncpy(sendbuf, temp, sizeof(sendbuf));  //use this to pad buffer
  retval = send(log_fd, sendbuf, sizeof(sendbuf), 0);
  if (retval != k_LogBufSize)
  {
    printf("emperor_log_data: send failed\n");
    return -1;
  }
  else
    return 0; //success
}

double emperor_current_time(void) 
{//returns time in seconds 
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

bool sensors_open_serial_port(int &fd, const char* filename, 
			      const speed_t speed, const int bytes_per_read)
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
      // // poll() is broken on OSX, so we set VTIME and use read(), which is ok since
      // // we're reading only one port anyway
      tio.c_cc[VMIN]  = bytes_per_read;//143; //set minimum number of bytes per read
      tio.c_cc[VTIME] = 10; // 10 * 100ms = 1s
      // set port speed
      if (cfsetispeed(&tio, speed) != 0)
      {
	perror("sensors_open_serial_port:cfsetispeed");
	printf("with fd = %d, filename = %s\n", fd, filename);
	return false;
      }
      if (cfsetospeed(&tio, speed) != 0)
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
{//this initializes the imu and encoders (or any other sensor running similar code)
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
  // set correct binary output mode, disable continuous streaming, disable errors and
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
        break;  // alrighty, it worked
    }
    // error?
    else
    {
      if (errno != EAGAIN && errno != EINTR)
        throw std::runtime_error("Can not read from serial port (2).");
    }
  }
  return true;  //if we get here, everything worked
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
    input_pos = 0;
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
    data->ticks[i] = 0.0f;
  //send frame request --NOT NEEDED FOR CONSTANT OUTPUT
  if (strcmp(encoders_init_string.c_str(), "#ob#o0#s") == 0) {
    const char* framerequest = "#f";
    int testretval = write(encoders_fd, framerequest, strlen(framerequest));
    if (testretval != (int)strlen(framerequest))
    {
      printf("encoders_read_data error writing frame requests, testretval = %d\n", 
	     testretval);
      return false;
    }
  }
  //read new data
  while (true)
  {
    //first get cm measurements (floats)
    if ((result = read(encoders_fd, &c, 1)) > 0)
    { //read binary stream
      // (type-punning: aliasing with char* is ok)
      (reinterpret_cast<char*> (&data->ticks))[encoders_input_pos++] = c;
      if (encoders_input_pos == 8) // we received both (2 data elements * 4 bytes each)
      {                
	//then get the two unsigned longs (timestamp and dt)
	//got the floats, so now get the two unsigned long ints
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
  data->timestamp = 0;
  //send frame request --NOT NEEDED FOR CONSTANT OUTPUT
  if (strcmp(imu_init_string.c_str(), "#omb#o0#oe0#s") == 0) {
    const char* framerequest = "#f";
    int testretval = write(imu_fd, framerequest, strlen(framerequest));
    if (testretval != (int)strlen(framerequest))
    {
      printf("imu_read_data error writing frame requests, testretval = %d\n", 
	     testretval);
      return false;
    }
  }
  //read data
  while (true)
  {
    if ((result = read(imu_fd, &c, 1)) == 1)
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
	    if ((result = read(imu_fd, &buf[i], 1)) > 0)
	      continue;
	    else if (result < 0)
	      perror("imu_read_data:failed timestamp read");
	  }
	  memcpy(&t, buf, 4);
	  if (j == 0)
	    data->timestamp = t;
	  else if (j == 1)
	  {
	    data->dt = t;
	    //done, so reset position counter and copy completed data to output 
	    imu_input_pos = 0;
	    return true;
	  }
	}
      }
    }
    else if (result < 0)
    {
      printf("in imu_read_data: errno = %d\n", errno);
      if (errno != EAGAIN && errno != EINTR)
      {
        perror("imu_read_data:cannot read from serial port");
        return false; //failure
      }
    }
    else
      printf("read result was %d\n", result);
    //else result is 0, so no data available (keep waiting)
  }
}

double sensors_current_time(void)
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

bool sensors_send_data(char* msgbuf, int num_messages)
{
  int msgsize = num_messages * k_LogBufSize;
  //first send the number of messages
  int r = send(log_sensors_sockfd, &num_messages, sizeof(num_messages), 0);
  if (r != sizeof(num_messages))
  {
    printf("sensors_send_data: num_messages send failed\n"
	   "msgbuf: %s\n", msgbuf);
    return false;
  }
  //then send the buffer itself
  int retval = send(log_sensors_sockfd, msgbuf, msgsize, 0);
  if (retval != msgsize)
  {
    printf("sensors_send_data: msgbuf send failed\n");
    return false;
  }
  else
    return true; //success
}

int gps_read_data(char* logbuf)
{
  int retval, length;
  int success = 0;
  int failure = -1;
  int no_read = 1;
  struct GPSInfo gpsinfo;
  fd_set recv_set;
  struct timeval timeout;
  
  //clear logbuf
  memset(logbuf, 0, sizeof(logbuf));
  //set up select
  FD_ZERO(&recv_set);
  FD_SET(gps_fd, &recv_set);
  timeout.tv_sec = 0;
  timeout.tv_usec = 2*1000; //2ms timeout
  retval = select(gps_fd+1, &recv_set, NULL, NULL, &timeout);
  if (retval < 0) //error
  {
    perror("gps_read_data select:");
    return failure;
  }
  else if (retval == 0) //timeout
  {
    return no_read;
  }
  else //retval >= 1, so there is data to receive
  {
    int bytes_available = k_gpsWorkingBufSize - g_gps_working_buf_index;
    //read up to available buffer-length bytes
    retval = read(gps_fd, &g_gps_working_buf[g_gps_working_buf_index], bytes_available);
    if (retval < 0 ) //error
    {
      perror("gps_read_data read:");
      return failure;
    }
    //update index with bytes read
    g_gps_working_buf_index = g_gps_working_buf_index + retval; 
    //scan for starting $ and ending \n (keep position with g_gps_working_buf_index)
    char* begin = strchr(&g_gps_working_buf[0], '$');
    unsigned int begin_ind = strcspn(&g_gps_working_buf[0], "$");
    if (begin == NULL) { //no starting $ in buffer, so flush it all and return failure
      memset(g_gps_working_buf, 0, sizeof(g_gps_working_buf));
      g_gps_working_buf_index = 0;
      return failure;
    }
    unsigned int end = strcspn(begin, "\n");
    if (strncmp(&begin[end], "\n", 1) != 0) {
      //reached end of read buffer w/o finding \n, so update the index and return no read
      g_gps_working_buf_index = end+1;
      return no_read;
    }
    //if we get here w/o returning, we have found $ and \n
    //copy from $ to \n into a parsing buffer
    char tempbuf[k_gpsWorkingBufSize];
    memset(tempbuf, 0, k_gpsWorkingBufSize);
    strncpy(tempbuf, begin, end);
    //update position index
    g_gps_working_buf_index = g_gps_working_buf_index - (begin_ind + end);
    //move remaining data to beginning of g_gps_working_buf
    memmove(g_gps_working_buf, g_gps_working_buf+end+begin_ind, g_gps_working_buf_index);
    memset(g_gps_working_buf+g_gps_working_buf_index+1, 0, 
	   k_gpsWorkingBufSize - g_gps_working_buf_index - 1);

    length = strlen(tempbuf);
    if (length <= 0) //error
    {
      perror("gps_read_data length:");
      printf("length = %d\n", length);
      return failure;
    }
    else 
    { //message received, so check if it's one we want
      if (strncmp(tempbuf, GGA, strlen(GGA)) == 0)
      { //process GGA info
	g_parser.Parse(tempbuf, length);
	gpsinfo = g_parser.GetActualGPSInfo();
	retval = snprintf(logbuf, k_LogBufSize, "GGA:Lat:%.10f:Long:%.10f:Alt:%.1fm:"
			  "HDOP:%.2f:Quality:%d:Time:%.2d:%.2d:%.2d",
			  gpsinfo.m_latitude, gpsinfo.m_longitude, gpsinfo.m_altitude,
			  gpsinfo.m_HDOP, gpsinfo.m_signalQuality, gpsinfo.m_hour,
			  gpsinfo.m_minute, gpsinfo.m_second);
	if (retval > k_LogBufSize)
	  printf("GPS GGA too long, retval = %d\n", retval);
	//logbuf now has a parsed and formatted GPS messages, so return success
	return success;
      }
      else if (strncmp(tempbuf, RMC, strlen(RMC)) == 0)
      { //process RMC info
	g_parser.Parse(tempbuf, length);
	gpsinfo = g_parser.GetActualGPSInfo();
	if (!gpsinfo.m_trackValid)
	{
	  sprintf(logbuf, "RMC:Track Invalid");
	}
	else
	{
	  retval = snprintf(logbuf, k_LogBufSize, "RMC:Lat:%.10f:Long:%.10f:Heading:%.2f:"
			    "MagVar:%.2f:Speed:%.2fkt:Date:%.4d-%.2d-%.2d:Time:%.2d:%.2d:%.2d",
			    gpsinfo.m_latitude, gpsinfo.m_longitude, 
			    gpsinfo.m_courseOverGround,gpsinfo.m_magneticVariation, 
			    gpsinfo.m_groundSpeed, gpsinfo.m_year, gpsinfo.m_month, 
			    gpsinfo.m_day, gpsinfo.m_hour, gpsinfo.m_minute, gpsinfo.m_second);
	  if (retval > k_LogBufSize)
	    printf("GPS RMC too long, retval = %d\n", retval);
	}
	//logbuf now has a parsed and formatted GPS messages, so return success
	return success;
      }
      else //ignore other messages from GPS
	return no_read;
    }
  }      
}

//copied from data-analysis.cpp
double my_exp(double x){ 
  if (x == NEGATIVE_INFINITY)
    return 0.0;
  return exp(x);
}

double sigmoid(double x, double a, double b){ //a is threshold, b is steepness
  return 1.0 / (1 + my_exp(- b * (x - a)));
}

double normalize_orientation(double angle){
  if (angle > k_PI) return normalize_orientation(angle - 2*k_PI);
  else if (angle < -k_PI) return normalize_orientation(angle + 2*k_PI);
  // if (angle > PI/2) return normalize_orientation(angle - PI);
  // else if (angle < -PI/2) return normalize_orientation(angle + PI);
  else return angle;
}

double orientation_plus(double x, double y){ return normalize_orientation(x+y); }

double orientation_minus(double x, double y){ return normalize_orientation(x-y); }

//gives the angle from robot to point (compare with theta)
double AngleBetween(pose_t robot, location_t point)
{
  return atan2(point.y - robot.y, point.x - robot.x);
} //always returns [-pi, pi)

//from Dan's log_to_track.cpp
Mat ComputeTransitionMatrix(Mat state,float dt)
{
  float theta = state.at<float>(2);
  //float sl =  state.at<float>(4);
  //float sr =  state.at<float>(5);
  //float r,dtheta_term;
  Mat TransitionModel = Mat(8,8,CV_32F);
  
  TransitionModel = *(Mat_<float>(8,8) <<
		      1, 0, 0, 0,  .5*cos(theta)*dt, .5*cos(theta)*dt, 0,  0,
		      0, 1, 0, 0,  .5*sin(theta)*dt, .5*sin(theta)*dt, 0,  0,
		      0, 0, 1, dt, 0,                0,                0,  0,
		      0, 0, 0,  0, 0,                0,                0,  0,
		      //0, 0, 0, 0,  -1/rover_width,   1/rover_width,    0,  0,
		      0, 0, 0, 0,  1,                0,                dt, 0,
		      0, 0, 0, 0,  0,                1,                0,  dt,
		      0, 0, 0, 0, -beta,             0,                0,  0,
		      0, 0, 0, 0,  0,               -beta,             0,  0);
  return TransitionModel;
}

KalmanFilter execute_time_step(KalmanFilter KF,
			      Mat TransitionModel,
			      Mat MeasurementModel,
			      Mat ControlModel,
			      Mat measurement,
			      Mat control)
{
  KF.transitionMatrix = TransitionModel;
  KF.measurementMatrix = MeasurementModel;
  KF.controlMatrix = ControlModel;
  KF.predict(control);
  KF.correct(measurement);
  return KF;  
}

//new stuff
//gives the distance from the robot to the point
double DistanceBetween(pose_t robot, location_t point)
{
  double x = robot.x - point.x;
  double y = robot.y - point.y;
  double dist = pow(x,2) + pow(y,2);
  return sqrt(dist);
}

//for barriers
void *task_malloc(size_t size) {
  void *p = malloc(size);
  if (p==NULL) task_error("Out of memory");
  return p;
}

void start_barrier_threads(void) {
  if (running) task_error("threads already running");
  if (pthread_barrier_init(&barrier, NULL, threads)) {
    task_error("Can't create a barrier");
  }
  if (pthread_barrier_init(&barrier2, NULL, threads+1)) { //this one waits on 6 threads
    task_error("Can't create barrier2");
  }
  running = TRUE;
  for (unsigned int id = 0; id<threads+1; id++) task_args[id].id = id;
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setstacksize(&attributes, 10*1024*1024); /* hardwired 10MB */
  for (unsigned int id = 0; id<threads+1; id++) {
    if (pthread_create(&thread[id], &attributes, task[id],
		       (void *)&task_args[id])) {
      task_error("Can't start thread %u", id);
    }
  }
  pthread_attr_destroy(&attributes);
}

void stop_barrier_threads(void) 
{
  //***MIGHT WANT TO HAVE THE SHUTDOWN THREAD SEND A STOP FIRST, JUST IN CASE
  motor_stop(motor_fd);
  /* needs work: Technically, can't access running here without a mutex. */
  if (running&&!halt) {
    pthread_mutex_lock(&halt_mutex);
    halt = TRUE;
    pthread_mutex_unlock(&halt_mutex);
    for (unsigned int id = 0; id<threads+1; id++) 
    {
      if (pthread_join(thread[id], NULL)!=0) 
	task_error("Can't join thread %u", id);
    }
    pthread_barrier_destroy(&barrier); 
    pthread_barrier_destroy(&barrier2);
    halt = FALSE;
  }
}
// Tasks communicate through global variables.
// Each global variable is written by at most one task.
// It can be read by multiple tasks.
// Task only write their own global variables in write_TASK().
// No other task can read other task's global variables in write_TASK().
// They can only read variables in read_TASK().

//for imu  (streaming)
void initialize_imu(unsigned int id) {
  char logbuf[k_LogBufSize];
  char sendbuf[k_LogBufSize];
  int num_messages = 1;
  //connect to server
  printf("Connecting to %s on port %s for IMU, Encoder, and GPS logging...\n",
  	 k_Server, k_imuLogPort);
  log_sensors_sockfd = -1;
  sprintf(logbuf, "%.6f:ALL:IMU, Encoders, and GPS logging started in AUTOMATIC (the-force) mode\n", 
	  sensors_current_time());
  strncpy(sendbuf, logbuf, k_LogBufSize);
  while (log_sensors_sockfd == -1)
  {
    log_sensors_sockfd = ClientConnect(k_Server, k_imuLogPort);
  }
  if (!sensors_send_data(sendbuf, num_messages)){
    printf("connection failed, exiting.\n");
    return;
      }
  else
    printf("success!\n");
  //initialize variables
  g_imu_data = new imu_data_t;
  //open fd  for imu
  if (!sensors_open_serial_port(imu_fd, imu_file, sensors_speed))
  {
    perror("Error opening serial port for IMU:");
    return;
  }
  //init imu 
  if (!sensors_init(imu_fd, imu_init_string, imu_input_pos))
  {
    perror("Error in IMU init:");
    return;
  }
  //clear junk data
  struct timeval mark, now;
  gettimeofday(&mark, NULL);
  gettimeofday(&now, NULL);
  while (sensors_elapsed_ms(mark,now) < 200) {
    imu_read_data(g_imu_data);
    gettimeofday(&now, NULL);
  }  
  //success if we get here
  printf("initialize_imu() succeeded\n");
  return;
}

//for encoders (polling)
void initialize_encoders(unsigned int id) {
  //initialize variables
  g_encoders_data = new encoders_data_t;
  //open fd for encoders
  if (!sensors_open_serial_port(encoders_fd, encoders_file, sensors_speed))
  {
    perror("Error opening serial port for encoders:");
    return;
  }
  //init encoders
  if (!sensors_init(encoders_fd, encoders_init_string, encoders_input_pos))
  {
    perror("Error in encoders init:");
    return;
  }
  //clear junk data
  struct timeval mark, now;
  gettimeofday(&mark, NULL);
  gettimeofday(&now, NULL);
  while (sensors_elapsed_ms(mark,now) < 200) {
    encoders_read_data(g_encoders_data);
    gettimeofday(&now, NULL);
  }
  //success if we get here
  printf("initialize_encoders() succeeded\n");
  return;
}


void write_imu(unsigned int id) {
  fd_set recv_set;
  struct timeval timeout;
  FD_ZERO(&recv_set);
  FD_SET(imu_fd, &recv_set);
  timeout.tv_sec = 0;
  timeout.tv_usec = 1*1000; //1ms timeout
  while (select(imu_fd+1, &recv_set, NULL, NULL, &timeout) > 0) {
    imu_read_data(g_imu_data);
  }
  return;
}

void write_encoders(unsigned int id) {
  if (!encoders_read_data(g_encoders_data))
    printf("error getting encoders data in write_encoders\n");
  return;
}

void read_imu(unsigned int id) {return;} //nothing to do here

void read_encoders(unsigned int id) {return;} //nothing to do here

void finalize_imu(unsigned int id) {
  //close fds
  close(imu_fd);
  close(log_sensors_sockfd);
  //clean up memory
  delete g_imu_data;
  printf("finalize_imu complete\n");
  return;
}

void finalize_encoders(unsigned int id) {
  //close fds
  close(encoders_fd);
  //clean up memory
  delete g_encoders_data;
  printf("finalize_encoders complete\n");
  return;
}

void *imu_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;

  initialize_imu(id);

  BARRIER2("imu", "initialize");

  while (TRUE) 
  {
    /* This block only needs to be in one thread */
    pthread_mutex_lock(&halt_mutex);
    if (halt) running = FALSE;
    pthread_mutex_unlock(&halt_mutex);
    frame_number++;
    /* end block */  

    BARRIER("imu", "before pipeline");

    if (!running) break;
    double last = emperor_current_time();
    write_imu(id);

    if ((rep_count % sensor_cam_ratio) == 0) {BARRIER2("imu","after pipeline");}
    else {BARRIER("imu", "after pipeline");}

    rep_count++;

    read_imu(id);
    double now = emperor_current_time();

    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    //I think this timing might be wrong, but not sure it matters
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("imu %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused imu %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
    /* This block only needs to be in one thread */
    /* spin to sync to frame rate */
    while (TRUE) 
    {
      double now = current_time();
      if (now-last>=1.0/fps) 
      {
	last = now;
	break;
      }
      if (usleep(QUANTUM)) task_error("Call to usleep failed");
    }
    /* end block */
  }

  BARRIER2("imu", "finalize");

  finalize_imu(id);
  return NULL;
}

void *encoders_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;
  initialize_encoders(id);

  BARRIER2("encoders", "initialize");

  while (TRUE) 
  {
    BARRIER("encoders", "before pipeline");

    if (!running) break;
    write_encoders(id);

    if ((rep_count % sensor_cam_ratio) == 0) {BARRIER2("encoders","after pipeline");}
    else {BARRIER("encoders", "after pipeline");}

    rep_count++;

    double last = emperor_current_time();
    read_encoders(id);
    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */
   
    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("encoders %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused encoders %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }

  BARRIER2("encoders", "finalize");

  finalize_encoders(id);
  return NULL;
}

//for GPS
void initialize_gps(unsigned int id){
  //initialize variables
  g_parser = NMEAParser();
  g_gps_new_data = -1;
  memset(g_gps_buf, 0, k_LogBufSize);
  //open fd for GPS
  if (!sensors_open_serial_port(gps_fd, gps_file, gps_speed))
  {
    perror("Error opening serial port for GPS:");
    return;
  }
  //init GPS (just get file pointer from fd)
  gps_file_ptr = fdopen(gps_fd, "r");
  //success if we get here
  printf("initialize_gps() succeeded\n");
  return;
}

void write_gps(unsigned int id) {
  g_gps_new_data = gps_read_data(g_gps_buf);
  return;
}

void read_gps(unsigned int id) {return;} //nothing to do here

void finalize_gps(unsigned int id){
  //close fds/file
  close(gps_fd);
  fclose(gps_file_ptr);
  printf("finalize_gps complete\n");
  return;
}

void *gps_task(void *args){
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;
  initialize_gps(id);

  BARRIER2("gps", "initialize");

  while (TRUE) 
  {
    BARRIER("gps", "before pipeline");   

    if (!running) break;
    write_gps(id);

    if ((rep_count % sensor_cam_ratio) == 0) {BARRIER2("gps","after pipeline");}
    else {BARRIER("gps", "after pipeline");}

    rep_count++;

    double last = emperor_current_time();
    read_gps(id);
    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */

    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("gps %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused gps %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }
  
  BARRIER2("gps", "finalize");  
  finalize_gps(id);
  return NULL;
}


void initialize_buffer_and_send(unsigned int id) {
  //initialize message buffer, count
  msg_count = 0;
  memset(g_msg_buf, 0, k_msg_buf_bytes);
  //success if we get here
  printf("initialize_buffer_and_send() succeeded\n");
  return;
}

void write_buffer_and_send(unsigned int id) {return;} 
//nothing to do here--no other threads read from or write to msg_count and g_msg_buf

void read_buffer_and_send(unsigned int id) {
  int r;
  char imubuf[k_LogBufSize];
  char encoderbuf[k_LogBufSize];
  char gpsbuf[k_LogBufSize];
  if (!last_send) 
  { //check route complete and if true, set last send
    if (route_complete)
      last_send = true;
    //read g_imu_data and parse into text
    r = snprintf(imubuf, k_LogBufSize, "%.6f:IMU:time:%lu:dt:%lu:"
		 "Y:%.2f:P:%.2f:R:%.2f:"
		 "Y(a):%.2f:M_h(a):%.2f:M_h:%.2f:"
		 "Ax:%.2f:Ay:%.2f:Az:%.2f:Mx:%.2f:My:%.2f:Mz:%.2f:"
		 "Gx:%.2f:Gy:%.2f:Gz:%.2f\n",
		 sensors_current_time(),
		 g_imu_data->timestamp, g_imu_data->dt,
		 g_imu_data->data[0], g_imu_data->data[1], g_imu_data->data[2],
		 g_imu_data->data[3], g_imu_data->data[4], g_imu_data->data[5],
		 g_imu_data->data[6], g_imu_data->data[7], g_imu_data->data[8],
		 g_imu_data->data[9], g_imu_data->data[10], g_imu_data->data[11],
		 g_imu_data->data[12], g_imu_data->data[13], g_imu_data->data[14]);
    if (r > k_LogBufSize)
      sprintf(imubuf,"IMU:BOGUS READING");
    //write text to g_msg_buf
    if (msg_count < k_msg_buf_size) {//buffer has room
      strncpy(&g_msg_buf[msg_count * k_LogBufSize], imubuf, k_LogBufSize); //pad buffer   
      ++msg_count; //increment msg_count
    }
    else { //buffer is full
      printf("ERROR in read_buffer_and_send: buffer full on imu write\n");
      return;
    }
    //read g_encoders_data and parse into text
    r =  snprintf(encoderbuf,k_LogBufSize,
		  "%.6f:ENC:time:%lu:dt:%lu:L:%.1f:R:%.1f:MCL:%d:MCR:%d\n",
		  sensors_current_time(),
		  g_encoders_data->timestamp, g_encoders_data->dt,
		  g_encoders_data->ticks[0], g_encoders_data->ticks[1],
		  g_motor_cmd_L, g_motor_cmd_R);
    if (r > k_LogBufSize)
      sprintf(encoderbuf, "ENC:BOGUS READING");
    //write text to g_msg_buf
    if (msg_count < k_msg_buf_size) {//buffer has room
      strncpy(&g_msg_buf[msg_count * k_LogBufSize], encoderbuf, k_LogBufSize); //pad buffer
      ++msg_count; //increment msg_count
    }
    else { //buffer is full
      printf("ERROR in read_buffer_and_send: buffer full on encoder write\n");
      return;
    }
    if (g_gps_new_data == 0) {//if new GPS data
      //write g_gps_buf to g_msg_buf
      r = snprintf(gpsbuf,k_LogBufSize, "%.6f:GPS:%s\n", sensors_current_time(), g_gps_buf);
      if (r > k_LogBufSize)
	sprintf(gpsbuf, "GPS:BOGUS READING");
      if (msg_count < k_msg_buf_size) {//buffer has room
	strncpy(&g_msg_buf[msg_count * k_LogBufSize], gpsbuf, k_LogBufSize); //pad buffer   
	++msg_count; //increment msg_count
      }
      else { //buffer is full
	printf("ERROR in read_buffer_and_send: buffer full on gps write\n");
	return;
      } 
    }
    //write estimate to buffer
    if (msg_count < k_msg_buf_size) {//buffer has room
      strncpy(&g_msg_buf[msg_count * k_LogBufSize], global_estimate_buf, k_LogBufSize); 
      ++msg_count; //increment msg_count
    }
    else { //buffer is full
      printf("ERROR in read_buffer_and_send: buffer full on estimate write\n");
      return;
    }
    //write waypoint to buffer
    if (global_waypoint_flag) {
      if (msg_count < k_msg_buf_size) {//buffer has room
	strncpy(&g_msg_buf[msg_count * k_LogBufSize], global_waypoint_buf, k_LogBufSize); 
	++msg_count; //increment msg_count
	global_waypoint_flag = false; //reset flag
      }
      else { //buffer is full
	printf("ERROR in read_buffer_and_send: buffer full on waypoint write\n");
	return;
      }
    }
    //check msg_count
    if ((msg_count >= k_msg_buf_threshold) || halt) { //send data
      if (!sensors_send_data(g_msg_buf, msg_count))
	printf("ERROR sending buffer in read_buffer_and_send\n");
      //clear buffer
      memset(g_msg_buf, 0, k_msg_buf_bytes);
      //reset msg_count
      msg_count = 0;
    } //else just return
    return;
  }
}

void finalize_buffer_and_send(unsigned int id) {
  //send whatever is left in buffer
  if (msg_count > 0) {
    if (!sensors_send_data(g_msg_buf, msg_count))
      printf("ERROR sending buffer in finalize_buffer_and_send\n");
  }
  printf("finalize_buffer_and_send complete\n");
  return;} 

void *buffer_and_send_task(void *args) {
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;
  initialize_buffer_and_send(id);

  BARRIER2("buffer_and_send", "initialize");

  while (TRUE) 
  {
    BARRIER("buffer_and_send", "before pipeline");  

    if (!running) break;
    write_buffer_and_send(id);

    if ((rep_count % sensor_cam_ratio) == 0) {BARRIER2("buffer_and_send","after pipeline");}
    else {BARRIER("buffer_and_send", "after pipeline");}

    rep_count++;
    
    double last = emperor_current_time();
    read_buffer_and_send(id);
    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */
    
    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("buffer_and_send %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused buffer_and_send %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }

  BARRIER2("buffer_and_send", "finalize");
  finalize_buffer_and_send(id);
  return NULL;
}

//KF/move thread
void initialize_estimate_and_move(unsigned int id){
  //parse route into array of points (global)
  char *str_num, *str_x, *str_y;   //parse raw route into x,y points. Format of string is: n:x1,y1;x2,y2;...;xn,yn
  char msgbuf[k_traceBufSize];
  strncpy(msgbuf, g_routebuf, k_traceBufSize);
  str_num = strtok(msgbuf, ":");   // n:x1,y1;x2,y2;...;xn,yn
  g_num_waypoints = atoi(str_num);
  if (g_num_waypoints == 0) //bad string/no points, so must quit
  {
    printf("IMPROPERLY FORMATTED STRING passed to initialize_estimate_and_move, exiting\n");
    //play error sound here?
    route_complete = true;
    return;
  }
  //finish parsing route into points
  for (int i = 0; i < g_num_waypoints; i++) {
    str_x = strtok(NULL, ",");
    str_y = strtok(NULL, ";");
    g_waypoints[i].x = atof(str_x);
    g_waypoints[i].y = atof(str_y);
  }
  //initialize global point index
  g_waypoint_index = 0;
  memset(g_motor_prev, 0, k_maxBufSize);
  //initialize Kalman Filter
  g_KF.measurementNoiseCov = *(Mat_<float>(7,7) <<
			       mXN, 0,   0,       0,        0,    0,    0,     
			       0,   mYN, 0,       0,        0,    0,    0,     
			       0,   0,   mThetaN, 0,        0,    0,    0,     
			       0,   0,   0,       mdThetaN, 0,    0,    0,     
			       0,   0,   0,       0,        mSLN, 0,    0,     
			       0,   0,   0,       0,        0,    mSRN, 0,     
			       0,   0,   0,       0,        0,    0,    mAN);

  g_KF.processNoiseCov = *(Mat_<float>(8,8) <<
			   pXN, 0,   0,       0,        0,    0,    0,     0,     
			   0,   pYN, 0,       0,        0,    0,    0,     0,     
			   0,   0,   pThetaN, 0,        0,    0,    0,     0,    
			   0,   0,   0,       pdThetaN, 0,    0,    0,     0,     
			   0,   0,   0,       0,        pSLN, 0,    0,     0,     
			   0,   0,   0,       0,        0,    pSRN, 0,     0,    
			   0,   0,   0,       0,        0,    0,    pdSLN, 0,
			   0,   0,   0,       0,        0,    0,    0,     pdSRN);

  g_KF.controlMatrix = *(Mat_<float>(8,2) <<
			 0,     0,
			 0,     0,
			 0,     0,
			 0,     0,
			 0,     0,
			 0,     0,
			 alpha, 0,
			 0,     alpha);

  // measure x,y,theta,dtheta,sl,sr, and acceleration, which is avg of wheel accelerations
  g_MeasurementModel = *(Mat_<float>(7,8) <<
			 1, 0, 0, 0, 0, 0,  0,   0,
			 0, 1, 0, 0, 0, 0,  0,   0,
			 0, 0, 1, 0, 0, 0,  0,   0,
			 0, 0, 0, 1, 0, 0,  0,   0,
			 0, 0, 0, 0, 1, 0,  0,   0,
			 0, 0, 0, 0, 0, 1,  0,   0,
			 0, 0, 0, 0, 0, 0,  .5,  .5);
  
  // measure theta,dtheta,sl,sr, and acceleration, which is avg of wheel accelerations        
  g_MeasurementModel_noGPS = *(Mat_<float>(7,8) <<
			       0, 0, 0, 0, 0, 0,  0,   0,
			       0, 0, 0, 0, 0, 0,  0,   0,
			       0, 0, 1, 0, 0, 0,  0,   0,
			       0, 0, 0, 1, 0, 0,  0,   0,
			       0, 0, 0, 0, 1, 0,  0,   0,
			       0, 0, 0, 0, 0, 1,  0,   0,
			       0, 0, 0, 0, 0, 0,  .5,   .5);
  //initialize state to robot's pose
  g_KF.statePre.at<float>(0) = g_my_pose.x;
  g_KF.statePost.at<float>(0) = g_my_pose.x;
  g_KF.statePre.at<float>(1) = g_my_pose.y;
  g_KF.statePost.at<float>(1) = g_my_pose.y;
  g_KF.statePre.at<float>(2) = g_my_pose.theta; 
  g_KF.statePost.at<float>(2) = g_my_pose.theta;
  g_KF.statePre.at<float>(3) = 0; //dtheta
  g_KF.statePost.at<float>(3) = 0;
  g_KF.statePre.at<float>(4) = 0; //L wheel speed
  g_KF.statePost.at<float>(4) = 0;
  g_KF.statePre.at<float>(5) = 0; //R wheel speed
  g_KF.statePost.at<float>(5) = 0;
  g_KF.statePre.at<float>(6) = 0; //L wheel acceleration
  g_KF.statePost.at<float>(6) = 0;
  g_KF.statePre.at<float>(7) = 0; //R wheel acceleration
  g_KF.statePost.at<float>(7) = 0;

  //write first location estimate to global_estimate_buf
  char tempbuf[k_LogBufSize];
  sprintf(tempbuf,"ESTIMATE:X:%f:Y:%f:THETA:%f\n", 
	  g_my_pose.x, g_my_pose.y, g_my_pose.theta);
  strncpy(global_estimate_buf, tempbuf, k_LogBufSize);
  printf("initialize_estimate_and_move() complete\n");
  return;
}

void write_estimate_and_move(unsigned int id) {
  //copy local estimate to global
  strncpy(global_estimate_buf, local_estimate_buf, k_LogBufSize);
  //if new waypoint, write it and set flag
  if (strlen(local_waypoint_buf) > 0) {
    strncpy(global_waypoint_buf, local_waypoint_buf, k_LogBufSize);
    global_waypoint_flag = true;
  }
  //printf("write_estimate_and_move, task %u\n", id);
  return;} 

void read_estimate_and_move(unsigned int id) {
  float Lat, Long, Alt, HDOP, Quality, Heading, MagVar, Speed;
  int year, month, day, hour, min, sec;
  char logbuf[k_LogBufSize];
  char tempbuf[k_LogBufSize];
  Mat Measurement = Mat::zeros(7,1,CV_32F);
  Mat control = Mat::zeros(2,1,CV_32F);

  //read sensors and update estimate
  //parse g_imu_data and g_encoders_data into named variables
  //  unsigned long imu_time = g_imu_data->timestamp;
  //  unsigned long imu_dt = g_imu_data->dt;
  float Yaw = g_imu_data->data[0];
  //  float Pitch = g_imu_data->data[1];
  //  float Roll = g_imu_data->data[2];
  //  float Yawa = g_imu_data->data[3];
  //  float MAG_ha = g_imu_data->data[4];
  //  float MAG_h = g_imu_data->data[5];
  float Ax = g_imu_data->data[6];
  //  float Ay = g_imu_data->data[7];
  //  float Az = g_imu_data->data[8];
  //  float Mx = g_imu_data->data[9];
  //  float My = g_imu_data->data[10];
  //  float Mz = g_imu_data->data[11];
  //  float Gx = g_imu_data->data[12];
  //  float Gy = g_imu_data->data[13];
  float Gz = g_imu_data->data[14];
  //  unsigned long encoder_time = g_encoders_data->timestamp;
  unsigned long encoder_dt = g_encoders_data->dt;
  float L = g_encoders_data->ticks[0];
  float R = g_encoders_data->ticks[1];
  //if new GPS data, parse it
  if (g_gps_new_data == 0) {
    int gps_items = sscanf(g_gps_buf,"GGA:Lat:%f:Long:%f:Alt:%f m:HDOP:%f:"
  			   "Quality:%f:Time:%d:%d:%d",
  			   &Lat, &Long, &Alt, &HDOP, &Quality,
  			   &hour, &min, &sec);
    if (gps_items != 8){
      gps_items = sscanf(g_gps_buf,"RMC:Lat:%f:Long:%f:Heading:%f:MagVar:%f:"
  			 "Speed:%f kt:Date:%d-%d-%d:Time:%d:%d:%d",
  			 &Lat, &Long, &Heading, &MagVar, &Speed,
  			 &year, &month, &day, &hour, &min, &sec);
    }
    //update with GPS
    Measurement.at<float>(0) = Long;
    Measurement.at<float>(1) = Lat;
    Measurement.at<float>(2) = (-Yaw+90)*k_PI/180 ; 
    //degrees north is 0 east is positive->(radians east 0 north positive)
    Measurement.at<float>(3) = -(Gz-gyro_offset)*radians_per_gyro_unit;
    // rotation around z in degrees/sec ->(radians/sec)
    Measurement.at<float>(4) = L*tau_L/(((float)((int)encoder_dt))/1000.0);
    Measurement.at<float>(5) = R*tau_R/(((float)((int)encoder_dt))/1000.0);
    Measurement.at<float>(6) = -(Ax-1)/100; 
  }
  else {//update without GPS
    Measurement.at<float>(0) = 0; //no gps for now
    Measurement.at<float>(1) = 0; //no gps for now
    Measurement.at<float>(2) = (-Yaw+90)*k_PI/180 ; 
    //degrees north is 0 east is positive->(radians east 0 north positive)
    Measurement.at<float>(3) = -(Gz-gyro_offset)*radians_per_gyro_unit;
    // rotation around z in degrees/sec ->(radians/sec)
    Measurement.at<float>(4) = L*tau_L/(((float)((int)encoder_dt))/1000.0);
    Measurement.at<float>(5) = R*tau_R/(((float)((int)encoder_dt))/1000.0);
    Measurement.at<float>(6) = -(Ax-1)/100; 
  }
  //update current position via Kalman filter
  g_TransitionModel = ComputeTransitionMatrix(g_KF.statePost, encoder_dt/1000.0);
  //using encoder's dt for now

  // NEEDS WORK: hard coded and ignores input to rover motors
  float CL = 0; //g_motor_cmd_L;
  float CR = 0; //g_motor_cmd_R;
  control = *(Mat_<float>(2,1) << CL,CR);      

  //fix possible loop-around in thetas
  while (Measurement.at<float>(2) <= g_KF.statePost.at<float>(2) - k_PI)
    Measurement.at<float>(2) += 2*k_PI;
  while (Measurement.at<float>(2) >= g_KF.statePost.at<float>(2) + k_PI)
    Measurement.at<float>(2) -= 2*k_PI;
  
  // NEEDS WORK: we always ignore GPS
  g_KF = execute_time_step(g_KF, g_TransitionModel,
  			   g_MeasurementModel_noGPS, g_KF.controlMatrix, 
  			   Measurement, control);

  //KF updated, write x, y, theta back into the_robot
  g_my_pose.x = g_KF.statePost.at<float>(0);
  g_my_pose.y = g_KF.statePost.at<float>(1);
  g_my_pose.theta = g_KF.statePost.at<float>(2);
  
  //write out estimate
  sprintf(tempbuf,"ESTIMATE:X:%f:Y:%f:THETA:%f\n", 
	  g_my_pose.x, g_my_pose.y, g_my_pose.theta);
  strncpy(local_estimate_buf, tempbuf, k_LogBufSize);

  //delay here to let cameras get going before the robot moves
  if (frame_number < 50) return;
      
  //check distance between robot and point
  double the_distance = DistanceBetween(g_my_pose, g_waypoints[g_waypoint_index]);
  //if d < some threshold, declare at point and increment global point index
  if (the_distance <= k_distance_threshold) 
  {
    motor_stop(motor_fd); //stop robot
    //log command (no need to check if different from last here) b/c break is coming
    sprintf(logbuf,"REACHED POINT %d, auto-executed: motor_%s", g_waypoint_index+1, cmd_stop);
    int retval = emperor_log_data(logbuf, log_sockfd);
    if (retval != 0)
      printf("logging failed for \'%s'\n", logbuf);
    //***LOG INTO IMU LOG AS WELL***  
    sprintf(tempbuf,"\nWAYPOINT %d %f %f\n",g_waypoint_index+1, 
	    g_waypoints[g_waypoint_index].x, g_waypoints[g_waypoint_index].y);
    strncpy(local_waypoint_buf, tempbuf, k_LogBufSize);
    //clear g_motor_prev and increment g_waypoint_index
    memset(g_motor_prev, 0, k_maxBufSize);
    ++g_waypoint_index;
    //if at last point, stop motors and stop threads
    if (g_waypoint_index == g_num_waypoints) {
      motor_stop(motor_fd); //stop robot
      route_complete = true;
      //stop_barrier_threads(); //we're done!
      return;
    }
    else
      return;
  }
  else if (!route_complete) {  //move 
    //Steps: 1. Decide command 
    //       2. check against previous command-->send and log only if different
    //clear local waypoint buffer
    memset(local_waypoint_buf, 0, k_LogBufSize);
    double phi = AngleBetween(g_my_pose, g_waypoints[g_waypoint_index]);
    //fix possible loop-around in thetas
    while (phi <= g_my_pose.theta - k_PI)
      phi += 2*k_PI;
    while (phi >= g_my_pose.theta + k_PI)
      phi -= 2*k_PI;
    double phi_theta_diff = phi - g_my_pose.theta;
    char motor[k_maxBufSize];
    memset(motor,0,k_maxBufSize); //clear for new command
    if (fabs(phi_theta_diff) < k_angle_threshold_2) //drive straight
    {
      strncpy(motor, cmd_forward_2, strlen(cmd_forward_2)); //stay with speed 2 for now
      if (strncmp(g_motor_prev, motor, k_maxBufSize) == 0) //repeated command
	return; //go back to top of position-checking loop
      else
      {
	motor_forward_2(motor_fd); //send command to motors
	memset(g_motor_prev,0,k_maxBufSize); //copy motor to g_motor_prev
	strncpy(g_motor_prev, motor, strlen(motor));
      }
    }
    //********************NEED SOMETHING HERE TO BACK UP IF PAST POINT (FABS(PHI_THETA_DIF) CLOSE TO PI)
    else if (phi_theta_diff < 0) //need to turn or pivot right
    {//***NEED TO INCLUDE STOPS WHEN COMING OUT OF/GOING INTO PIVOTS
      //decide if pivot or turn
      if (fabs(phi_theta_diff) < k_angle_threshold_1) //turn right
      {
	strncpy(motor, cmd_forward_right_2, strlen(cmd_forward_right_2)); 
	//stay with speed 2 for now
	if (strncmp(g_motor_prev, motor, k_maxBufSize) == 0) //repeated command
	  return; //go back to top of position-checking loop
	else
	{
	  //motor_stop(motor_fd); //stop before turning in case coming out of a pivot
	  motor_forward_right_2(motor_fd); //send command to motors
	  memset(g_motor_prev,0,k_maxBufSize); //copy motor to g_motor_prev
	  strncpy(g_motor_prev, motor, strlen(motor));
	}
      }
      else //pivot right
      {
	strncpy(motor, cmd_pivot_right_2, strlen(cmd_pivot_right_2)); 
	if (strncmp(g_motor_prev, motor, k_maxBufSize) == 0) //repeated command
	  return; //go back to top of position-checking loop
	else
	{
	  //motor_stop(motor_fd); //stop before pivoting
	  motor_pivot_right_2(motor_fd); //send command to motors
	  memset(g_motor_prev,0,k_maxBufSize); //copy motor to g_motor_prev
	  strncpy(g_motor_prev, motor, strlen(motor));
	}
      }
    }
    else // phi_theta_diff > 0, so need to turn or pivot left
    {
      if (fabs(phi_theta_diff) < k_angle_threshold_1) //turn left
      {
	strncpy(motor, cmd_forward_left_2, strlen(cmd_forward_left_2)); 
	//stay with speed 2 for now
	if (strncmp(g_motor_prev, motor, k_maxBufSize) == 0) //repeated command
	  return; //go back to top of position-checking loop
	else
	{
	  //motor_stop(motor_fd); //stop before turning in case coming out of a pivot
	  motor_forward_left_2(motor_fd); //send command to motors
	  memset(g_motor_prev,0,k_maxBufSize); //copy motor to g_motor_prev
	  strncpy(g_motor_prev, motor, strlen(motor));
	}
      }
      else //pivot left
      {
	strncpy(motor, cmd_pivot_left_2, strlen(cmd_pivot_left_2)); 
	if (strncmp(g_motor_prev, motor, k_maxBufSize) == 0) //repeated command
	  return; //go back to top of position-checking loop
	else
	{
	  //motor_stop(motor_fd); //stop before pivoting
	  motor_pivot_left_2(motor_fd); //send command to motors
	  memset(g_motor_prev,0,k_maxBufSize); //copy motor to g_motor_prev
	  strncpy(g_motor_prev, motor, strlen(motor));
	}
      }
    }
    //log the command if different from last 
    //(returns will keep execution from getting here on repeated commands
    memset(logbuf,0,k_LogBufSize);
    sprintf(logbuf,"auto-executed: motor_%s", motor);
    //printf("%s\n", logbuf);
    int retval = emperor_log_data(logbuf,log_sockfd);
    if (retval != 0)
      printf("logging failed for \'%s'\n", logbuf);
  }
  return;
}

void finalize_estimate_and_move(unsigned int id) 
{
  motor_stop(motor_fd); //extra stop just for good measure
  printf("finalize_estimate_and_move complete\n");
  return;
}

void *estimate_and_move_task(void *args)
{
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;
  initialize_estimate_and_move(id);

  BARRIER2("estimate_and_move", "initialize");

  while (TRUE) 
  {
    BARRIER("estimate_and_move", "before pipeline");

    if (!running) break;
    write_estimate_and_move(id);

    if ((rep_count % sensor_cam_ratio) == 0) {BARRIER2("estimate_and_move","after pipeline");}
    else {BARRIER("estimate_and_move", "after pipeline");}
    
    rep_count++;
    
    double last = emperor_current_time();
    if (!route_complete)
      read_estimate_and_move(id);

    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("estimate_and_move %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused estimate_and_move %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }

  BARRIER2("estimate_and_move", "finalize");
  finalize_estimate_and_move(id);
  return NULL;
}


//new camera thread 30Oct15
void initialize_cameras(unsigned int id)
{
    g_numCameras = PGR_Init(&g_busMgr);
    if ( g_numCameras < 1 )
    {
      perror("Insufficient number of cameras in initialize_cameras:");
      return;
    }
    g_PG = new PointGrey_t[g_numCameras];
    if (PGR_StartCameras(&g_busMgr, g_PG, g_numCameras) != 0)
    {
      perror("Error starting cameras:");
      PGR_StopAndCleanup(g_PG, g_numCameras);
      return;
    }
    if (Network_StartCameras(g_PG, g_numCameras) != 0)
    {
      printf("Error starting network\n"); //don't return here (not sure why??)
    }
    char logbuf[k_LogBufSize];
    sprintf(logbuf, "executed: %s", cmd_start_cameras);
    int retval = emperor_log_data(logbuf, log_sockfd);
    if (retval != 0)
      printf("logging failed for \'%s\'\n", logbuf);
    sleep(1);//small sleep to allow cameras to get started before moving
    //setup completed
    printf("initialize_cameras() succeeded\n");
    return;
}

void write_cameras(unsigned int id)
{
  for (unsigned int i = 0; i < g_numCameras; i++)
    PGR_GetFrame(&g_PG[i]);
}
void read_cameras(unsigned int id)//{return;} //nothing to do here
{
  for (unsigned int i = 0; i < g_numCameras; i++)
  {
    OpenCV_CompressFrame(&g_PG[i]);
    OpenCV_SendFrame(&g_PG[i]);
  }
}


void finalize_cameras(unsigned int id)
{
  sleep(2); //small sleep to allow cameras to run a few seconds after reaching destination
  char logbuf[k_LogBufSize];
  sprintf(logbuf, "executed: %s", cmd_stop_cameras);
  int retval = emperor_log_data(logbuf, log_sockfd);
  if (retval != 0)
    printf("logging failed for \'%s\'\n", logbuf);
  printf("Cameras stopped\n");
  //cleanup 
  PGR_StopAndCleanup(g_PG, g_numCameras);
  delete g_PG;
  printf("finalize_cameras complete\n" );
  return;
}

void *cameras_task(void *args)
{
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;

  initialize_cameras(id);

  BARRIER2("cameras", "initialize");

  while (TRUE) 
  {
    frame_number_cameras++;

    write_cameras(id);

    if (!running) break; 
    //need to do this right before the barrier to prevent a race condition / hang
    BARRIER2("cameras", "after pipeline");

    double last = emperor_current_time();
    read_cameras(id);
    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */

    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    //I think this timing might be wrong, but not sure it matters
    double fraction_remaining = 1.0-fps2*(now-last);
    if (fraction_remaining<0.0) {
      printf("camera %u can't keep up in frame %lu, overused: %lf\n",
  	     id, frame_number_cameras, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused camera %u thread time in frame %lu: %lf\n",
  	     id, frame_number_cameras, fraction_remaining);
    }
  }

  BARRIER2("cameras", "finalize");

  finalize_cameras(id);
  return NULL;
}

//new bump switch thread 5Nov15
void initialize_bump_switches(unsigned int id){
  //initialize variables
  g_bump_retval = 0;
  g_bump_gpio_num = 0;
  memset(g_bump_readbuffer,0,bump_read_size);
  memset(g_bump_logbuf,0,k_LogBufSize);
  FD_ZERO(&g_bump_recv_set);
  //write in log
  sprintf(g_bump_logbuf, "Bump switch monitoring active");
  g_bump_retval = emperor_log_data(g_bump_logbuf, log_sockfd);
  if (g_bump_retval != 0)
    printf("logging failed for \'%s\'\n", g_bump_logbuf);
  return;
}

void write_bump_switches(unsigned int id)
{
  memset(g_bump_logbuf, 0, sizeof(g_bump_logbuf));  //clear buffer
  //wrapping recv in a select here to ensure recv doesn't hang
  FD_ZERO(&g_bump_recv_set);
  FD_SET(gpio_fd, &g_bump_recv_set);
  //reset timeout here to ensure it gets reset every time
  g_bump_timeout.tv_sec = 0;
  g_bump_timeout.tv_usec = 1000 * 2; //2ms timeout
  g_bump_retval = select(gpio_fd+1, &g_bump_recv_set, NULL, NULL, &g_bump_timeout);
  if (g_bump_retval < 0)
  {
    if (errno != EINTR) //sigalrm timer interrupts select
    {
      printf("write_bump_switches():select error, gpio_fd = %d\n",
	     gpio_fd);
      perror("write_bump_switches():select");
    }
    else
      return;  //treat as a timeout if we got retval < 0 with errno == EINTR
  }
  else if (g_bump_retval == 0) //timeout
    return; //done with this iteration
  else //g_bump_retval >= 1-->we have data to receive
  {
    g_bump_retval = read(gpio_fd, g_bump_readbuffer, bump_read_size);
    if (g_bump_retval <= 0)
    { //what error handling to do here??
      printf("write_bump_switches read retval = %d\n", g_bump_retval);
      return;//exit here
    }
    g_bump_gpio_num = atoi(strtok(g_bump_readbuffer," "));
    if (g_bump_gpio_num == bump_rear)
    { // bumped rear, so stop and go forward
      motor_stop(motor_fd);
      motor_forward_4(motor_fd);
      usleep(bump_move_time);
      motor_stop(motor_fd);
      //log it
      sprintf(g_bump_logbuf, "Rear bump activated, stopping");
      emperor_log_data(g_bump_logbuf, log_sockfd);
    }
    else if (g_bump_gpio_num == bump_front)
    { // bumped front, so stop and go back
      motor_stop(motor_fd);
      motor_reverse_4(motor_fd);
      usleep(bump_move_time);
      motor_stop(motor_fd);
      //log it
      sprintf(g_bump_logbuf, "Front bump activated, stopping");
      emperor_log_data(g_bump_logbuf, log_sockfd);
    }
    //NEEDSWORK: here we may want to do something to let viewer know about the bump so that a change in the route can be calculated and resent--basically, recovery from this error
  }
  return;
}

void read_bump_switches(unsigned int id) {return;} //nothing to do here

void finalize_bump_switches(unsigned int id){
  //close fd
  close(gpio_fd);
  printf("finalize_bump_switches complete\n");
  return;
}

void *bump_switches_task(void *args)
{
  struct task_args *task_args = (struct task_args *)args;
  unsigned int id = task_args->id;
  unsigned long int rep_count = 1;
  initialize_bump_switches(id);

  BARRIER2("bump_switches", "initialize");

  while (TRUE) 
  {
    BARRIER("bump_switches", "before pipeline");   

    if (!running) break;
    //    double last = emperor_current_time();
    write_bump_switches(id);

    if ((rep_count % sensor_cam_ratio) == 0) {
      BARRIER2("bump_switches","after pipeline");}
    else 
      BARRIER("bump_switches", "after pipeline");

    rep_count++;
    double last = emperor_current_time();
    read_bump_switches(id);
    double now = emperor_current_time();
    /* SAB: I know this timing is bogus, but I don't think I need to worry 
       about it.  The sensors and cameras all run at the proper speeds. 
       If I really cared, I could duplicate this timing on the write task 
       above the barrier. */

    /* This intentionally ignores the time for the two barriers, the
       conditional break, the conditional printfs, and the loop. And it does
       two calls to current_time() instead of one. Because otherwise the
       timings become entangled with other threads. */
    double fraction_remaining = 1.0-fps*(now-last);
    if (fraction_remaining<0.0) {
      printf("bump_switches %u can't keep up in frame %lu, overused: %lf\n",
	     id, frame_number, -fraction_remaining);
    }
    else if (time_threads) {
      printf("unused bump_switches %u thread time in frame %lu: %lf\n",
	     id, frame_number, fraction_remaining);
    }
  }
  
  BARRIER2("bump_switches", "finalize");  
  finalize_bump_switches(id);
  return NULL;
}


//downloaded from http://man7.org/tlpi/code/online/diff/sockets/read_line.c.html on 26 Jul 14
/* Read characters from 'fd' until a newline is encountered. If a newline
+  character is not encountered in the first (n - 1) bytes, then the excess
+  characters are discarded. The returned string placed in 'buf' is
+  null-terminated and includes the newline character if it was read in the
+  first (n - 1) bytes. The function return value is the number of bytes
+  placed in buffer (which includes the newline character if encountered,
+  but excludes the terminating null byte). */

 ssize_t readLine(int fd, void *buffer, size_t n)
 {
     ssize_t numRead;                    /* # of bytes fetched by last read() */
     size_t totRead;                     /* Total bytes read so far */
     char *buf;
     char ch;
 
     if (n <= 0 || buffer == NULL) {
         errno = EINVAL;
         return -1;
     }
 
     buf = (char*)buffer;                       /* No pointer arithmetic on "void *" */
 
     totRead = 0;
     for (;;) {
         numRead = read(fd, &ch, 1);
 
         if (numRead == -1) {
             if (errno == EINTR)         /* Interrupted --> restart read() */
                 continue;
             else
                 return -1;              /* Some other error */
 
         } else if (numRead == 0) {      /* EOF */
             if (totRead == 0)           /* No bytes read; return 0 */
                 return 0;
             else                        /* Some bytes read; add '\0' */
                 break;
 
         } else {                        /* 'numRead' must be 1 if we get here */
             if (totRead < n - 1) {      /* Discard > (n - 1) bytes */
                 totRead++;
                 *buf++ = ch;
             }
 
             if (ch == '\n')   //strip the newline here
	     {
	       ch = '\0';
	       totRead--;
	       break;
	     }
         }
     }
 
     *buf = '\0';
     return totRead;
 }

/** 
 * Set a file descriptor to blocking or non-blocking mode.
 *
 * @param fd The file descriptor
 * @param blocking 0:non-blocking mode, 1:blocking mode
 *
 * @return 1:success, 0:failure.

 * downloaded from http://code.activestate.com/recipes/577384-setting-a-file-descriptor-to-blocking-or-non-block/ on 12Nov14
 **/
int fd_set_blocking(int fd, int blocking) {
    /* Save the current flags */
    int flags = fcntl(fd, F_GETFL, 0);
    if (flags == -1)
        return 0;

    if (blocking)
        flags &= ~O_NONBLOCK;
    else
        flags |= O_NONBLOCK;
    return fcntl(fd, F_SETFL, flags) != -1;
}
