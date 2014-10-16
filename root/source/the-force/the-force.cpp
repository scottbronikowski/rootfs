/*

  Implementation for main control program to run vader-rover for automated driving.
  Basically a merge of the old emperor and run-sensors programs, along with Dan's code in log_to_track.cpp to do Kalman filter position finding from sensor data

  Author: Scott Bronikowski
  Date: 16 October 2014
*/

#include "the-force.h"
#include <pthread.h>

//global constants
const int BACKLOG = 5;
const char* k_CommandPort = "1999";
const int k_maxBufSize = 50;
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
const char* k_imuLogPort = "2004";
const int k_LogBufSize = 256; //100;
//for bump switch monitoring
const int bump_move_time = 50000;
const int bump_read_size = 24;
const int bump_front = 185; //gpio 185
const int bump_rear = 184; //gpio 184
const char* gpio_file = "/dev/gpio-event";
const char* gps_file = "/dev/GPS";

//global variables
//extern'd
int sockfd, log_sockfd, log_imu_sockfd;
int cam_thread_should_die = TRUE; //cam thread not running
int gpio_thread_should_die = TRUE; //gpio thread not running
pthread_t cam_thread, gpio_thread;
int pan_fd, tilt_fd, motor_fd, gpio_fd;//gl_imu_fd declared in razor-imu.h
//not extern'd
char motor_prev[k_maxBufSize];
char pan_prev[k_maxBufSize];
char tilt_prev[k_maxBufSize];
razor_data_t* imu_data;

int main(int /*argc*/, char** /*argv*/)
{
  char logbuf[k_LogBufSize];
  int retval;
  printf("Starting Emperor\n");
  //printf("sizeof(long long int) = %d\n", sizeof(long long int));
  //printf("sizeof(double) = %d\n", sizeof(double));
  //printf("timestamp: %.6f\n", emperor_current_time()); //6 decimal places is microseconds
  printf("Please ensure that driver-gui.sc (viewer '()) is running on %s\n", k_Server);
  pan_fd = open(pan_file, O_WRONLY);
  if (pan_fd < 1)
  {
    perror("pan:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
  tilt_fd = open(tilt_file, O_WRONLY);
  if (tilt_fd < 1)
  {
    perror("tilt:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
  motor_fd = initport();
  if (motor_fd < 1)
  {
    perror("motor:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
  gpio_fd = open(gpio_file, O_RDONLY);
  if (gpio_fd < 1)
  {
    perror("gpio:");
    emperor_signal_handler(SIGTERM);
    return -1;
  }
  // //open fd for RazorIMU -- gl_imu_fd declared in razor-imu.h
  // if (!razor_open_serial_port())
  // {
  //   printf("Error in razor_open_serial_port\n");
  //   if (gl_imu_fd < 1)
  //   {
  //     perror("imu:");
  //     emperor_signal_handler(SIGTERM);
  //     return -1;
  //   }
  // }
  // if (!razor_init())
  // {
  //   perror("razor_init failed");
  //   emperor_signal_handler(SIGTERM);
  //   return -1;
  // }
  // imu_data = new razor_data_t;

  // //test IMU
  // if (!razor_read_data(imu_data))
  // {
  //   perror("razor_read_data failed");
  //   emperor_signal_handler(SIGTERM);
  //   return -1;
  // } 
  // else
  // {  //read succeeded, so print it out
  //   printf("Yaw(raw) = %.2f, Yaw(adj) = %.2f, MAG_h = %.2f\n",
  // 	   imu_data->data[0], imu_data->data[1], imu_data->data[2]);
  // 	   //imu_data->heading[0], imu_data->heading[1], imu_data->heading[2]);
  //   printf("Ax = %.2f, Ay = %.2f, Az = %.2f\n",
  // 	   imu_data->data[3], imu_data->data[4], imu_data->data[5]);
  //          //imu_data->accel[0], imu_data->accel[1], imu_data->accel[2]);
  //   printf("Mx = %.2f, My = %.2f, Mz = %.2f\n",
  // 	   imu_data->data[6], imu_data->data[7], imu_data->data[8]);
  // 	   //imu_data->mag[0], imu_data->mag[1], imu_data->mag[2]);
  //   printf("Gx = %.2f, Gy = %.2f, Gz = %.2f\n",
  // 	   imu_data->data[9], imu_data->data[10], imu_data->data[11]);
  // 	   //imu_data->gyro[0], imu_data->gyro[1], imu_data->gyro[2]);
  // }

  // //now test in text to compare
  // const char* initstring = "#o0#omt"; //set for output on request, my format, text
  // int testretval = write(gl_imu_fd, initstring, strlen(initstring));
  // //test if the write worked
  // if (testretval != (int)strlen(initstring))
  // {
  //   if (testretval == -1)
  //   {
  //     perror("IMU test write initstring:");
  //     emperor_signal_handler(SIGTERM);
  //     return -1;
  //   }
  //   else
  //   {
  //     printf("Other IMU test write error, testretval = %d, "
  // 	     "strlen(initstring) = %d\n", testretval, strlen(initstring));
  //     emperor_signal_handler(SIGTERM);
  //     return -1;
  //   }
  // }
  // //if we get here, initstring got written
  // printf("Wrote new initstring to gl_imu_fd\n");
  // //now try to write a #f to get a frame then read it
  // const char* framerequest = "#f";
  // testretval = write(gl_imu_fd, framerequest, strlen(framerequest));
  // if (testretval != (int)strlen(framerequest))
  // {
  //   printf("IMU error writing frame requests, testretval = %d\n", testretval);
  //   emperor_signal_handler(SIGTERM);
  //   return -1;
  // }
  // char imubuf[k_LogBufSize];
  // testretval = read(gl_imu_fd, imubuf, k_LogBufSize);
  // if (testretval < 1)
  // {
  //   perror("IMU test read:");
  //   emperor_signal_handler(SIGTERM);
  //   return -1;
  // }
  // else
  // {
  //   printf("bytes read = %d\n", testretval);
  //   printf("data read: %s", imubuf);
  //   printf("newline after, not before\n");
  // }
  


  //open fd for GPS
  
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
  //printf("log_sockfd = %d\n", log_sockfd);

  // printf("Connecting to %s on port %s for IMU logging...\n", k_Server, 
  // 	 k_imuLogPort);
  // log_imu_sockfd = -1;
  // while (log_imu_sockfd == -1)
  // {
  //   log_imu_sockfd = ClientConnect(k_Server, k_imuLogPort);
  // }

  // emperor_log_data(logbuf, log_imu_sockfd);
  // printf("success!\n");
  // //printf("log_imu_sockfd = %d\n", log_imu_sockfd);

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
  //***START IMU AND GPS THREAD(S) HERE***
  
  //*Trying IMU as a sigaction instead of a thread
  // emperor_imu_sigaction();
  // emperor_imu_interrupt_on(imu_rate);
  
  // imu_thread_should_die = FALSE;
  // pthread_attr_init(&attributes);
  // pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_JOINABLE);
  // pthread_create(&imu_thread, &attributes, emperor_run_imu, NULL);
  // sprintf(logbuf, "IMU initialized and logging");
  // retval = emperor_log_data(logbuf, log_sockfd);
  // if (retval != 0)
  //   printf("logging failed for \'%s\'\n", logbuf);
  // //pthread_attr_destroy(&attributes);
  // printf("%s\n", logbuf);
 

  //register signal handler for termination
  signal(SIGINT, emperor_signal_handler);
  signal(SIGTERM, emperor_signal_handler);

  char msgbuf[k_maxBufSize];
  char prevmsgbuf[k_maxBufSize];
  memset(prevmsgbuf, 0, sizeof(prevmsgbuf));
  memset(motor_prev, 0, sizeof(motor_prev));
  memset(pan_prev, 0, sizeof(pan_prev));
  memset(tilt_prev, 0, sizeof(tilt_prev));


  //int retval;
  //loop on listening for commands
  while(1)
  {
    memset(msgbuf, 0, sizeof(msgbuf)); //clear buffer
    retval = recv(sockfd, &msgbuf, sizeof(msgbuf), 0);
    if (retval < 0)
    {
      printf("Error in recv\n");
      emperor_signal_handler(SIGTERM);
      return -1;
    }
    if (retval == 0)
    {
      printf("Sender closed connection\n");
      emperor_signal_handler(SIGTERM);
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
      emperor_signal_handler(SIGTERM);
      return -1;
    }
  }
  //cleanup done in signal handler
  return 0;
}


void emperor_signal_handler(int signum)
{
  //emperor_log_data("Logging stopped", log_sockfd);
  //printf("received signal %d\n", signum);
  if (!cam_thread_should_die) //only stop if already running
    {
      int retval;
      cam_thread_should_die = TRUE;
      pthread_join(cam_thread, NULL);
      retval = emperor_log_data((char*)"Cameras stopped in emperor_signal_handler", 
				log_sockfd);
      if (retval != 0)
	printf("logging failed for: ");
      printf("Cameras stopped in emperor_signal_handler\n");
    }
  //kill bump switch thread
  gpio_thread_should_die = TRUE;
  pthread_join(gpio_thread, NULL);
  //kill imu/gps thread
  // imu_thread_should_die = TRUE;
  // pthread_join(imu_thread, NULL);
  delete imu_data;
  //cleanup socket and file handles
  close(pan_fd);
  close(tilt_fd);
  close(motor_fd);
  close(gpio_fd);
  //close(gl_imu_fd);
  // //usleep(100000);
  // close(log_imu_sockfd);
  // printf("IMU logging socket closed\n");
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
    //return NULL;
    pthread_exit(NULL);
  }
  //printf("numCameras = %u\n", numCameras);
  PointGrey_t* PG = new PointGrey_t[numCameras];
  //printf("PG got newed\n");
  if (PGR_StartCameras(&busMgr, PG, numCameras) != 0)
  {
    printf("Error starting cameras\n");
    PGR_StopAndCleanup(PG, numCameras);
    //return NULL;
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
  //return NULL;
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
    return 0; //success
}


double emperor_current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

// void* emperor_run_imu(void* args)
// {
//   //int retval;
//   char logbuf[k_LogBufSize];
//   //printf("In emperor_run_imu, imu_thread_should_die = %d\n", imu_thread_should_die);
//   while (!imu_thread_should_die)
//   {
//     //PUT TIMER IN HERE

//     memset(logbuf, 0, sizeof(logbuf));  //clear buffer
//     if (razor_read_data(imu_data))
//     { //successful read, so put data into logbuf
//       sprintf(logbuf, "IMU:Yaw(r)=%.2f;Yaw(a)=%.2f;MAG_h=%.2f;"
// 	      "Ax=%.2f;Ay=%.2f;Az=%.2f;Mx=%.2f;My=%.2f;Mz=%.2f;"
// 	      "Gx=%.2f;Gy=%.2f;Gz=%.2f",
// 	      imu_data->data[0], imu_data->data[1], imu_data->data[2],
// 	      imu_data->data[3], imu_data->data[4], imu_data->data[5],
// 	      imu_data->data[6], imu_data->data[7], imu_data->data[8],
// 	      imu_data->data[9], imu_data->data[10], imu_data->data[11]);
//     }
//     else
//     { //read failed, so log the failure
//       sprintf(logbuf,"IMU data read failure");
//     }
//     //emperor_log_data(logbuf); **OLD**
//     //log to separate log file
//     emperor_log_data(logbuf, log_imu_sockfd);

//     //printf("logged: %s\n", logbuf);
//     usleep(80000); //tweaking this number to get ~10 updates/sec
//   }
//   printf("imu thread exiting\n");
//   pthread_exit(NULL);
// }

// void emperor_imu_handler(int signum)
// {
//   char logbuf[k_LogBufSize];
//   memset(logbuf, 0, sizeof(logbuf));  //clear buffer
//   if (razor_read_data(imu_data))
//   { //successful read, so put data into logbuf
//     sprintf(logbuf, "IMU:Yaw(r)=%.2f;Yaw(a)=%.2f;MAG_h=%.2f;"
// 	    "Ax=%.2f;Ay=%.2f;Az=%.2f;Mx=%.2f;My=%.2f;Mz=%.2f;"
// 	    "Gx=%.2f;Gy=%.2f;Gz=%.2f",
// 	    imu_data->data[0], imu_data->data[1], imu_data->data[2],
// 	    imu_data->data[3], imu_data->data[4], imu_data->data[5],
// 	    imu_data->data[6], imu_data->data[7], imu_data->data[8],
// 	    imu_data->data[9], imu_data->data[10], imu_data->data[11]);
//   }
//   else
//   { //read failed, so log the failure
//     sprintf(logbuf,"IMU data read failure");
//   }
//   emperor_log_data(logbuf, log_imu_sockfd);
// }

// void emperor_imu_sigaction(void) 
// { 
//   struct sigaction sigact;
//   sigact.sa_handler = emperor_imu_handler;
//   sigemptyset(&sigact.sa_mask);
//   sigact.sa_flags = SA_RESTART;
//   if (sigaction(SIGALRM, &sigact, NULL)) { 
//     perror("sigaction failed");
//     exit(-1);
//   }
// }

// void emperor_imu_interrupt_on(int rate) 
// { 
//   struct itimerval itimerval;
//   itimerval.it_interval.tv_sec = 0;
//   itimerval.it_interval.tv_usec = 1000000/rate;
//   itimerval.it_value.tv_sec = 0;
//   itimerval.it_value.tv_usec = 1000000/rate;
//   setitimer(ITIMER_REAL, &itimerval, (struct itimerval *)0);
// }
