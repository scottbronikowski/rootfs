/*

  Implementation for main control program to run vader-rover for automated driving.
  Basically a merge of the old emperor and run-sensors programs, along with Dan's code in log_to_track.cpp to do Kalman filter position finding from sensor data

  Author: Scott Bronikowski
  Date: 16 October 2014
*/

#include "the-force.h"

//global constants
//(from emperor)
const int BACKLOG = 5;
const char* k_CommandPort = "1999";
const int k_maxBufSize = 50;
//used for buffer of trace points, replaces k_maxBufSize in send/receive
const int k_traceBufSize = 1300; //max # of bytes in trace
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
//const int k_LogBufSize = 256; //defined in header
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
const std::string encoders_init_string = "#ob#o1#s";
const std::string imu_init_string = "#omb#o1#oe0#s"; //#o0 for POLLING #o1 for streaming

//global variables
//extern'd
//(from emperor)
int sockfd, log_sockfd;
int cam_thread_should_die = TRUE; //cam thread not running
int gpio_thread_should_die = TRUE; //gpio thread not running
pthread_t cam_thread, gpio_thread;
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
pthread_t producer_threads[3];
pthread_t consumer_thread;
bool producer_threads_should_die;
bool consumer_thread_should_die;
char g_msg_buf[k_msg_buf_bytes];
pthread_mutex_t msg_buf_and_count_lock;
//not extern'd
//(from emperor)
char motor_prev[k_maxBufSize];
char pan_prev[k_maxBufSize];
char tilt_prev[k_maxBufSize];
//(from run-sensors)
encoders_data_t* g_encoders_data;
imu_data_t* g_imu_data;
NMEAParser g_parser;


int main(int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  printf("Starting The Force\n");
  //printf("sizeof(long long int) = %d\n", sizeof(long long int));
  //printf("sizeof(double) = %d\n", sizeof(double));
  //printf("timestamp: %.6f\n", emperor_current_time()); //6 decimal places is microseconds
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
  sprintf(logbuf, "Logging started");
  emperor_log_data(logbuf, log_sockfd);
  printf("success!\n");
  printf("log_sockfd = %d\n", log_sockfd);

  //start bump switch monitoring thread here
  gpio_thread_should_die = FALSE;
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
  pthread_create(&gpio_thread, &attributes, emperor_monitor_bump_switches, NULL);
  sprintf(logbuf, "Bump switch monitoring active");
  retval = emperor_log_data(logbuf, log_sockfd);
  if (retval != 0)
    printf("logging failed for \'%s\'\n", logbuf);
  pthread_attr_destroy(&attributes);
  printf("%s\n", logbuf);

  //start the functions from run-sensors
  printf("Starting sensors...");
  //call setup function
  if (!run_sensors_setup())
  {
    printf("run_sensors_setup() failed\n");
    the_force_terminator(SIGTERM); 
    return -1;
  }
  //call start function
  run_sensors_start();
  printf("sensors started successfully\n");
  
  //***PROBABLY NEED TO START CAMERAS AUTOMATICALLY SOMEWHERE AROUND HERE****
  // OR MAYBE only start them only when a route has been received

  //register signal handler for termination
  signal(SIGINT, the_force_terminator);
  signal(SIGTERM, the_force_terminator);

  char msgbuf[k_maxBufSize];
  char prevmsgbuf[k_maxBufSize];
  memset(prevmsgbuf, 0, sizeof(prevmsgbuf));
  memset(motor_prev, 0, sizeof(motor_prev));
  memset(pan_prev, 0, sizeof(pan_prev));
  memset(tilt_prev, 0, sizeof(tilt_prev));

  //loop on listening for commands  **THIS IS WHERE THE CHANGES START***
  while(1)
  {
    memset(msgbuf, 0, sizeof(msgbuf)); //clear buffer
    retval = recv(sockfd, &msgbuf, sizeof(msgbuf), 0);
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
    if (strncmp(msgbuf, prevmsgbuf, k_maxBufSize) != 0) //received new command
    {
      // printf("Received %d bytes: %s\n", retval, msgbuf);
      strncpy(prevmsgbuf, msgbuf, k_maxBufSize);
    }
    else //got a repeat of the last received command, so ignore it
      continue;
    //do stuff with commands received
    retval = emperor_parse_and_execute(msgbuf);
    if (retval != 0)
    {
      printf("Error in emperor_parse_and_execute\n");
      the_force_terminator(SIGTERM);
      return -1;
    }
  }
  //cleanup done in terminator
  return 0;
}


void the_force_terminator(int signum)
{

  //***MIGHT WANT TO HAVE THE SHUTDOWN THREAD SEND A STOP FIRST, JUST IN CASE
  motor_stop(motor_fd);
  //stop sensors
  sensors_terminator(SIGTERM);
  
  //emperor_log_data("Logging stopped", log_sockfd);
  //printf("received signal %d\n", signum);
  if (!cam_thread_should_die) //only stop if already running
    {
      int retval;
      cam_thread_should_die = TRUE;
      pthread_join(cam_thread, NULL);
      retval = emperor_log_data((char*)"Cameras stopped in the_force_terminator", 
				log_sockfd);
      if (retval != 0)
	printf("logging failed for: ");
      printf("Cameras stopped in the_force_terminator\n");
    }
  //kill bump switch thread
  gpio_thread_should_die = TRUE;
  pthread_join(gpio_thread, NULL);
   //cleanup socket and file handles
  close(pan_fd);
  close(tilt_fd);
  close(motor_fd);
  close(gpio_fd);
  close(log_sockfd);
  printf("data logging socket closed\n");
  close(sockfd);
  printf("command socket closed, exiting\n");
  exit(signum);
}


void* emperor_run_cameras(void* args)
{
  BusManager busMgr;
  unsigned int numCameras = PGR_Init(&busMgr);
  //printf("in emperor_run_cameras, cam_thread_should_die = %d\n",
  //	 cam_thread_should_die);
  if ( numCameras < 1 )
  {
    printf( "Insufficient number of cameras... exiting\n" );
    pthread_exit(NULL);
  }
  //printf("numCameras = %u\n", numCameras);
  PointGrey_t* PG = new PointGrey_t[numCameras];
  //printf("PG got newed\n");
  if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
  {
    printf("Error starting cameras\n");
    PGR_StopAndCleanup(PG, numCameras);
    pthread_exit(NULL);
  }
  //printf("PGR_StartCameras succeeded\n");
  if (Network_StartCameras(PG, numCameras) != 0)
  {
    printf("Error starting network\n"); //don't return here
  }
  //setup completed
  printf("Rover: Image transfer commencing.\n");

  while(!cam_thread_should_die)
  {
    for (unsigned int i = 0; i < numCameras; i++)
    {
      PGR_GetFrame(&PG[i]);
      OpenCV_CompressFrame(&PG[i]);
      OpenCV_SendFrame(&PG[i]);
    }
  }
  //cleanup 
  PGR_StopAndCleanup(PG, numCameras);
  printf( "Cam thread done!\n" );
  pthread_exit(NULL);
}

void* emperor_monitor_bump_switches(void* args)
{
  int retval, gpio_num;
  char readbuffer[bump_read_size];
  char logbuf[k_LogBufSize];
  fd_set recv_set;
  struct timeval timeout;
 
  while (!gpio_thread_should_die)
  {
    memset(logbuf, 0, sizeof(logbuf));  //clear buffer
    //wrapping recv in a select here to ensure loop checks 
    //gpio_thread_should_die every timeout
    FD_ZERO(&recv_set);
    FD_SET(gpio_fd, &recv_set);
    //reset timeout inside loop to ensure it gets reset every time
    timeout.tv_sec = 0;
    timeout.tv_usec = 1000 * 100; //100ms timeout
    retval = select(gpio_fd+1, &recv_set, NULL, NULL, &timeout);
    if (retval < 0)
    {
      if (errno != EINTR) //sigalrm timer interrupts select
      {
	printf("emperor_monitor_bump_switches():select error, gpio_fd = %d\n",
	       gpio_fd);
	perror("emperor_monitor_bump_switches():select");
      }
      else
      	continue;  //treat as a timeout if we got retval == 0 with errno == EINTR
    }
    else if (retval == 0) //timeout
    {
      // printf("select timeout at %.6f, gpio_fd = %d, timeout = %ld.%06ld\n", 
      // 	     emperor_current_time(), gpio_fd, timeout.tv_sec, timeout.tv_usec);
      continue; //go back to the top of the loop and recheck gpio_thread_should_die
    }
    else //retval >= 1-->we have data to receive
    {
      retval = read(gpio_fd, readbuffer, bump_read_size);
      if (retval <= 0)
      { //what error handling to do here??
	printf("emperor_monitor_bump_switches read retval = %d\n", retval);
	break;
      }
      gpio_num = atoi(strtok(readbuffer," "));
      if (gpio_num == bump_rear)
      { // bumped rear, so stop and go forward
	motor_stop(motor_fd);
	motor_forward_4(motor_fd);
	usleep(bump_move_time);
	motor_stop(motor_fd);
	//log it
	sprintf(logbuf, "Rear bump activated, stopping");
	emperor_log_data(logbuf, log_sockfd);
      }
      else if (gpio_num == bump_front)
      { // bumped front, so stop and go back
	motor_stop(motor_fd);
	motor_reverse_4(motor_fd);
	usleep(bump_move_time);
	motor_stop(motor_fd);
	//log it
	sprintf(logbuf, "Front bump activated, stopping");
	emperor_log_data(logbuf, log_sockfd);
      }
    }
  }
  printf("gpio thread exiting\n");
  pthread_exit(NULL);
}

int emperor_parse_and_execute(char* msgbuf)
{
  char logbuf[k_LogBufSize];
  int retval;
  if (strncmp(msgbuf, cmd_start_cameras, strlen(cmd_start_cameras)) == 0) 
  { //start cameras
    //printf("Matched start_cameras command\n");
    //do stuff
    if (cam_thread_should_die) //only start if not already running
    {
      cam_thread_should_die = FALSE;
      pthread_attr_t attributes;
      pthread_attr_init(&attributes);
      pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
      pthread_create(&cam_thread, &attributes, emperor_run_cameras, NULL);
      sprintf(logbuf, "executed: %s", msgbuf);
      retval = emperor_log_data(logbuf, log_sockfd);
      if (retval != 0)
	printf("logging failed for \'%s\'\n", logbuf);
      pthread_attr_destroy(&attributes);
    }
    return 0;
  }
  if (strncmp(msgbuf, cmd_stop_cameras, strlen(cmd_stop_cameras)) == 0)
  { //stop cameras
    //printf("Matched stop_cameras command\n");
    //do stuff
    if (!cam_thread_should_die) //only stop if already running
    {
      cam_thread_should_die = TRUE;
      pthread_join(cam_thread, NULL);
      sprintf(logbuf, "executed: %s", msgbuf);
      retval = emperor_log_data(logbuf, log_sockfd);
      if (retval != 0)
	printf("logging failed for \'%s\'\n", logbuf);
      printf("Cameras stopped\n");
    }
    return 0;
  }  
  if (strncmp(msgbuf, cmd_servo, strlen(cmd_servo)) == 0)
  { //tilt & motor
    // printf("Matched servo & motor command\n");
    //do stuff
    //parse the command
    char *servo, *tilt, *pan, *motor;
    servo = strtok(msgbuf, " :");
    tilt = strtok(NULL, " :");
    pan = strtok(NULL, " :");
    motor = strtok(NULL, " :");
    // printf("Parsed: servo = %s, tilt = %s, pan = %s, motor = %s\n", 
    // 	   servo, tilt, pan, motor);
    // printf("strlen: servo = %d, tilt = %d, tilt = %d, motor = %d\n", 
    // 	   strlen(servo), strlen(tilt), strlen(pan), strlen(motor));
   
    //write commands to pan and tilt fds 
    //  first check if command is duplicated
    if ((strncmp(pan, pan_prev, strlen(pan)) !=0) ||
	(strncmp(tilt, tilt_prev, strlen(tilt)) != 0)) //if either is different
    {
      memset(pan_prev, 0, sizeof(pan_prev));
      strncpy(pan_prev, pan, strlen(pan));
      memset(tilt_prev, 0, sizeof(tilt_prev));
      strncpy(tilt_prev, tilt, strlen(tilt));
      retval = write(tilt_fd, tilt, strlen(tilt));
      if(retval < 0)
      {
	printf("error writing tilt\n");
	return -1;
      }
      //printf("wrote tilt...");
      retval = write(pan_fd, pan, strlen(pan));
      if(retval < 0)
      {
	printf("error writing pan\n");
	return -1;
      }
      //printf("wrote pan\n");
      //now log pan & tilt
      sprintf(logbuf, "executed: pan_%s, tilt_%s", pan, tilt );
      retval = emperor_log_data(logbuf, log_sockfd);
      if (retval != 0)
	printf("logging failed for \'%s\'\n", logbuf);
    }
    //send motor command
    //  first check if motor command is new -- no need to send repeats
    if (strncmp(motor, motor_prev, strlen(motor)) != 0)
    {
      // printf("new motor command: motor_prev = %s, motor = %s\n", motor_prev, motor);
      memset(motor_prev, 0, sizeof(motor_prev));
      strncpy(motor_prev, motor, strlen(motor));

      if (strncmp(motor, cmd_stop, strlen(cmd_stop)) == 0) //stop
 	motor_stop(motor_fd);
      else if (strncmp(motor, cmd_forward_1, strlen(cmd_forward_1)) == 0) //forward_1
      	motor_forward_1(motor_fd);
      else if (strncmp(motor, cmd_forward_2, strlen(cmd_forward_2)) == 0) //forward_2
	motor_forward_2(motor_fd);
      else if (strncmp(motor, cmd_forward_3, strlen(cmd_forward_3)) == 0) //forward_3
	motor_forward_3(motor_fd);
      else if (strncmp(motor, cmd_forward_4, strlen(cmd_forward_4)) == 0) //forward_4
	motor_forward_4(motor_fd);
      else if (strncmp(motor, cmd_reverse_1, strlen(cmd_reverse_1)) == 0) //reverse_1
	motor_reverse_1(motor_fd);
      else if (strncmp(motor, cmd_reverse_2, strlen(cmd_reverse_2)) == 0) //reverse_2
	motor_reverse_2(motor_fd);
      else if (strncmp(motor, cmd_reverse_3, strlen(cmd_reverse_3)) == 0) //reverse_3
	motor_reverse_3(motor_fd);
      else if (strncmp(motor, cmd_reverse_4, strlen(cmd_reverse_4)) == 0) //reverse_4
	motor_reverse_4(motor_fd);
      else if (strncmp(motor, cmd_forward_right_1, 
		       strlen(cmd_forward_right_1)) == 0) //forward_right_1
	motor_forward_right_1(motor_fd);
      else if (strncmp(motor, cmd_forward_right_2, 
		       strlen(cmd_forward_right_2)) == 0) //forward_right_2
	motor_forward_right_2(motor_fd);
      else if (strncmp(motor, cmd_forward_left_1, 
		       strlen(cmd_forward_left_1)) == 0) //forward_left_1
	motor_forward_left_1(motor_fd);
      else if (strncmp(motor, cmd_forward_left_2, 
		       strlen(cmd_forward_left_2)) == 0) //forward_left_2
	motor_forward_left_2(motor_fd);
      else if (strncmp(motor, cmd_pivot_left_1, 
		       strlen(cmd_pivot_left_1)) == 0) //pivot_left_1
	motor_pivot_left_1(motor_fd);
      else if (strncmp(motor, cmd_pivot_left_2, 
		       strlen(cmd_pivot_left_2)) == 0) //pivot_left_2
	motor_pivot_left_2(motor_fd);
      else if (strncmp(motor, cmd_pivot_right_1, 
		       strlen(cmd_pivot_right_1)) == 0) //pivot_right_1
	motor_pivot_right_1(motor_fd);
      else if (strncmp(motor, cmd_pivot_right_2, 
		       strlen(cmd_pivot_right_2)) == 0) //pivot_right_2
	motor_pivot_right_2(motor_fd);
      else if (strncmp(motor, cmd_reverse_right_1, 
		       strlen(cmd_reverse_right_1)) == 0) //reverse_right_1
	motor_reverse_right_1(motor_fd);
      else if (strncmp(motor, cmd_reverse_right_2, 
		       strlen(cmd_reverse_right_2)) == 0) //reverse_right_2
	motor_reverse_right_2(motor_fd);
      else if (strncmp(motor, cmd_reverse_left_1, 
		       strlen(cmd_reverse_left_1)) == 0) //reverse_left_1
	motor_reverse_left_1(motor_fd);
      else if (strncmp(motor, cmd_reverse_left_2, 
		       strlen(cmd_reverse_left_2)) == 0) //reverse_left_2
	motor_reverse_left_2(motor_fd);
      //now log the motor command
      sprintf(logbuf, "executed: motor_%s", motor);
      retval = emperor_log_data(logbuf, log_sockfd);
      if (retval != 0)
	printf("logging failed for \'%s\'\n", logbuf);
    }
    return 0;
  }
  //if we get here without returning, it means we didn't match any commands
  //printf("emperor_parse_and_execute error: no command matched msgbuf\n");
  return -1;
}


//int emperor_log_data(char* databuf)
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
  {
    //printf("sent: %s\n", sendbuf);
    return 0; //success
  }
}

double emperor_current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

//(from run-sensors)
bool run_sensors_setup(void)
{
  int retval;
  char logbuf[k_LogBufSize];
  //initialize message buffer, count and their joint lock
  msg_count = 0;
  memset(g_msg_buf, 0, k_msg_buf_bytes);
  pthread_mutex_init(&msg_buf_and_count_lock, NULL);
  //connect to seykhl
  printf("Connecting to %s on port %s for IMU, Encoder, and GPS logging...\n",
  	 k_Server, k_imuLogPort);
  log_sensors_sockfd = -1;
  sprintf(logbuf, "ALL:IMU, Encoders, and GPS logging started");
  while (log_sensors_sockfd == -1)
  {
    log_sensors_sockfd = ClientConnect(k_Server, k_imuLogPort);
  }
  retval = sensors_log_data(logbuf); //LOCKING DONE INTERNALLY in sensors_log_data
  if (retval != 0)
  {
    printf("connection failed, exiting.\n");
    return false;
  }
  else
    printf("success!\n");
  //initialize variables
  producer_threads_should_die = false;
  consumer_thread_should_die = false;
  g_encoders_data = new encoders_data_t;
  g_imu_data = new imu_data_t;
  g_parser = NMEAParser();
  //open fds for imu, encoders, GPS
  if (!sensors_open_serial_port(imu_fd, imu_file, sensors_speed))
  {
    perror("Error opening serial port for IMU:");
    return false;
  }
  if (!sensors_open_serial_port(encoders_fd, encoders_file, sensors_speed))
  {
    perror("Error opening serial port for encoders:");
    return false;
  }
  if (!sensors_open_serial_port(gps_fd, gps_file, gps_speed))
  {
    perror("Error opening serial port for GPS:");
    return false;
  }
  //printf("fds opened\n");

  //init imu & encoders
  if (!sensors_init(imu_fd, imu_init_string, imu_input_pos))
  {
    perror("Error in IMU init:");
    return false;
  }
  if (!sensors_init(encoders_fd, encoders_init_string, encoders_input_pos))
  {
    perror("Error in encoders init:");
    return false;
  }
  //init GPS (just get file pointer from fd)
  gps_file_ptr = fdopen(gps_fd, "r");

  //success if we get here
  printf("run_sensors_setup() succeeded\n");
  return true;
}

void run_sensors_start(void)
{
  pthread_attr_t attributes;
  pthread_attr_init(&attributes);
  pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
  //run null loop to clear serial buffer
  struct timeval mark, now;
  //char dummybuf[k_LogBufSize];
  gettimeofday(&mark, NULL);
  gettimeofday(&now, NULL);
  while (sensors_elapsed_ms(mark, now) < 200)
  {
    imu_read_data(g_imu_data); //read the data and do nothing
    encoders_read_data(g_encoders_data);
    //gps_read_data(dummybuf);
    gettimeofday(&now, NULL);  //update time hack
  }
  //start the threads
  pthread_create(&producer_threads[0], &attributes, producer_imu, NULL);
  pthread_create(&producer_threads[1], &attributes, producer_encoders, NULL);
  pthread_create(&producer_threads[2], &attributes, producer_gps, NULL);
  pthread_create(&consumer_thread, &attributes, consumer, NULL);
  pthread_attr_destroy(&attributes); //done with this
  printf("run_sensors_start() complete\n");
}

void* producer_imu(void* args)
{
  //printf("in producer_imu\n");
  int r;
  char imubuf[k_LogBufSize];
  while (!producer_threads_should_die)
  {
    memset(imubuf, 0, k_LogBufSize);
    if (imu_read_data(g_imu_data))
    { //successful read, so put into imubuf
      r = snprintf(imubuf, k_LogBufSize, "IMU:time:%lu:dt:%lu:"
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
      if (r > k_LogBufSize)
	sprintf(imubuf,"IMU:BOGUS READING");
    }
    else //read failed, so log failure
      sprintf(imubuf, "IMU:IMU data read failed");
    //send the data to the message buffer
    if (sensors_log_data(imubuf) != 0)
      printf("producer_imu: sensors_log_data(imubuf) failed\n");
  }
  return NULL;
}

void* producer_encoders(void* args)
{
  //printf("in producer_encoders\n");
  char encoderbuf[k_LogBufSize];
  while (!producer_threads_should_die)
  {
    memset(encoderbuf, 0, k_LogBufSize);
    if (encoders_read_data(g_encoders_data))
    { //successful read, so put into encoderbuf
      sprintf(encoderbuf,"ENC:time:%lu:dt:%lu:L:%.3f:R:%.3f",
	      g_encoders_data->timestamp, g_encoders_data->dt,
	      g_encoders_data->cm[0], g_encoders_data->cm[1]);
    }
    else  //read failed, so log failure
      sprintf(encoderbuf, "ENC:Encoders data read failed");
    //send the data to the message buffer
    if (sensors_log_data(encoderbuf) != 0)
      printf("producer_encoders: sensors_log_data(encoderbuf) failed\n");
  }
  return NULL;
}

void* producer_gps(void* args)
{
  //printf("in producer_gps\n");
  int retval;
  char gpsbuf[k_LogBufSize];
  char tempbuf[k_LogBufSize];
  while (!producer_threads_should_die)
  {
    memset(gpsbuf, 0, k_LogBufSize);
    memset(tempbuf, 0, k_LogBufSize);
    retval = gps_read_data(tempbuf);
    if (retval == 0)
    { //successful read, so send it
      sprintf(gpsbuf, "GPS:%s", tempbuf);
      if (sensors_log_data(gpsbuf) != 0)
	printf("producer_gps: sensors_log_data(gpsbuf) failed\n");
    }
    else if (retval == -1)  //read failed, so log failure and try again
      sprintf(gpsbuf, "GPS:GPS data read failed");
    // else retval == 1, which is a no read, so try again
  }
  return NULL;
}

void* consumer(void* args)
{
  //printf("in consumer\n");
  char sendbuf[k_msg_buf_bytes];
  int num_messages;
  int threshold = (int)(0.9 * k_msg_buf_size);
  memset(sendbuf, 0, k_msg_buf_bytes);
  while (!consumer_thread_should_die)
  {
    pthread_mutex_lock(&msg_buf_and_count_lock); //GRABBING THE LOCK
    //printf("consumer has lock\n");
    if (msg_count >= threshold)
    {
      num_messages = msg_count; //copy message count
      memcpy(sendbuf, g_msg_buf, (num_messages * k_LogBufSize)); //copy the buffer
      msg_count = 0; //reset msg_count
      pthread_mutex_unlock(&msg_buf_and_count_lock); //RELEASING THE LOCK
      if (!sensors_send_data(sendbuf, num_messages)) //sending the copy
      { //had an error in sensors_send_data
	printf("THIS SHOULDN'T HAVE HAPPENED\n");
      }
      memset(sendbuf, 0, k_msg_buf_bytes);
    }
    else
    {//release lock and wait a bit before checking again
      pthread_mutex_unlock(&msg_buf_and_count_lock); //RELEASING THE LOCK
      usleep(1000);  //might need to sleep longer here
    }
  }
  return NULL;
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
      //printf("Opened %s with bytes_per_read = %d\n", filename, bytes_per_read);
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
  // int testretval = write(imu_fd, framerequest, strlen(framerequest));
  // if (testretval != (int)strlen(framerequest))
  // {
  //   printf("razor_read_data error writing frame requests, testretval = %d\n", 
  // 	   testretval);
  //   return false;
  // }
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

int sensors_log_data(char* logbuf)
{
  double now = sensors_current_time(); 
  char temp[k_LogBufSize];
  int retval;
  memset(temp, 0, k_LogBufSize);
  retval = snprintf(temp, k_LogBufSize, "%.6f:%s\n", now, logbuf);
  if (retval >= k_LogBufSize)
  {
    printf("sensors_log_data: message truncated: %s\n  %s\n", logbuf, temp);
    return -1;
  }
  else if (retval < 0)
  {
    printf("sensors_log_data: encoding eror\n");
    return -1;
  }
  else 
  { //if we get here, we've got something to write to g_msg_buf
    pthread_mutex_lock(&msg_buf_and_count_lock); //GRABBING THE LOCK
    //printf("producer has lock\n");
    if (msg_count < k_msg_buf_size)
    { //we have room in the buffer, so add the new message
      memset(&g_msg_buf[msg_count * k_LogBufSize], 0, k_LogBufSize); //clear out old data
      strncpy(&g_msg_buf[msg_count * k_LogBufSize], temp, k_LogBufSize); //use this to pad buffer
      ++msg_count; //increment msg_count
      pthread_mutex_unlock(&msg_buf_and_count_lock); //RELEASING THE LOCK
      //printf("producer released lock after logging to buffer\n");
      //printf("logged: %s", msgbuf);
      return 0; //success
    }
    else
    { //buffer is full
      pthread_mutex_unlock(&msg_buf_and_count_lock); //RELEASING THE LOCK
      printf("sensors_log_data: buffer full, message discarded\n");
      printf("%s", temp);
      return -1;
    }
  }
}

bool sensors_send_data(char* msgbuf, int num_messages)
{
  int msgsize = num_messages * k_LogBufSize;
  //first send the number of messages
  int r = send(log_sensors_sockfd, &num_messages, sizeof(num_messages), 0);
  if (r != sizeof(num_messages))
  {
    printf("sensors_send_data: num_messages send failed\n");
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
  {
    //printf("sensors_send_data: retval =%d, msgsize = %d\n", retval, msgsize);
    return true; //success
  }
}

void sensors_terminator(int signum)
{
  usleep(1000000);  //sleep for 1 sec to ensure data gets out of buffer
  producer_threads_should_die = true;
  consumer_thread_should_die = true;
  //join threads
  pthread_join(producer_threads[0], NULL);
  pthread_join(producer_threads[1], NULL);
  pthread_join(producer_threads[2], NULL);
  pthread_join(consumer_thread, NULL);
  //close fds/file
  close(gps_fd);
  fclose(gps_file_ptr);
  close(imu_fd);
  close(encoders_fd);
  close(log_sensors_sockfd);
  //clean up memory
  delete g_encoders_data;
  delete g_imu_data;
  printf("the-force: sensors cleanup complete\n");
  exit(signum);
}

int gps_read_data(char* logbuf)
{
  int retval, length;
  int success = 0;
  int failure = -1;
  int no_read = 1;
  char tempbuf[k_LogBufSize];
  struct GPSInfo gpsinfo;
  if (fgets(tempbuf, k_LogBufSize, gps_file_ptr) != NULL)
  {
    length = strlen(tempbuf);
    if (length <= 0) //error
    {
      perror("gps_read_data:");
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
  else
    return no_read;
}
