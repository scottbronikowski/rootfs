/*
  Implementation for interface to Sparkfun 9DOF Razor IMU.  Based off RazorAHRS developed by Peter Bartz (https://github.com/ptrbrtz/razor-9dof-ahrs)

  Author: Scott Bronikowski
  Date: 6 June 2014
*/

#include "razor-imu.h"
#include <math.h>


//global constants
const speed_t razor_speed = B57600;
const char* imu_file = "/dev/RazorIMU";
const int razor_connect_timeout_ms = 5000;

//global vars
int gl_imu_fd;
size_t razor_input_pos;

bool razor_open_serial_port()
{
  // O_NDELAY allows open even with no carrier detect (e.g. needed for Razor)
  if ((gl_imu_fd = open(imu_file, O_RDWR | O_NOCTTY | O_NDELAY)) == -1)
  { // something didn't work
    perror("razor_open_serial_port:open");
    return false;
  }
  else
  { //we have a valid fd
    // make I/O blocking again
    if (!razor_set_blocking_io())
    {//something went wrong
      perror("razor_open_serial_port:razor_set_blocking_io");
      return false;
    }
    else //blocking IO set, now set other attributes
    {
      // get port attributes
      struct termios tio;
      if (tcgetattr(gl_imu_fd, &tio) != 0)
      {
	perror("razor_open_serial_port:tcgetattr");
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
      if (cfsetispeed(&tio, razor_speed) != 0)
      {
	perror("razor_open_serial_port:cfsetispeed");
	return false;
      }
      if (cfsetospeed(&tio, razor_speed) != 0)
      {
	perror("razor_open_serial_port:cfsetospeed");
	return false;
      }
      // set port attributes
      // must be done after setting speed!
      if (tcsetattr(gl_imu_fd, TCSANOW, &tio) != 0)
      {
	perror("razor_open_serial_port:tcsetattr");
	return false;
      }
      return true; //if we get here, everything worked
    }
  }
}

bool razor_init()
{
  char in;
  int result;
  struct timeval t0, t1, t2;
  const std::string synch_token = "#SYNCH";
  const std::string new_line = "\r\n";

  // start time
  gettimeofday(&t0, NULL);

  // request synch token to see if Razor is really present
  const std::string contact_synch_id = "00"; 
  const std::string contact_synch_request = "#s" + contact_synch_id; 
  const std::string contact_synch_reply = synch_token + contact_synch_id + new_line;
  if (write(gl_imu_fd, contact_synch_request.data(), 
	    contact_synch_request.length()) != 
      (ssize_t)contact_synch_request.length())
  {
    perror("razor_init:first synch");
    return false;
  }
  gettimeofday(&t1, NULL);
 // set non-blocking I/O
  if (!razor_set_nonblocking_io()) return false;

  /* look for tracker */
  while (true)
  {
    // try to read one byte from the port
    result = read(gl_imu_fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (razor_read_token(contact_synch_reply, in))
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
    if (razor_elapsed_ms(t1, t2) > 200)
    {
      // 200ms elapsed since last request and no answer -> request synch again
      // (this happens when DTR is connected and Razor resets on connect)
      if (write(gl_imu_fd, contact_synch_request.data(), 
		contact_synch_request.length()) !=
	  (ssize_t)contact_synch_request.length())
      {
	perror("razor_init:second synch");
	return false;
      }
      t1 = t2;
    }
    if (razor_elapsed_ms(t0, t2) > razor_connect_timeout_ms)
      // timeout -> tracker not present
      throw std::runtime_error("Can not init: tracker does not answer.");
  }

  /* configure tracker */
  // set correct binary output mode, disale continuous streaming, disable errors and
  // request synch token. So we're good, no matter what state the tracker
  // currently is in.
  const std::string config_synch_id = "01";
  const std::string config_synch_reply = synch_token + config_synch_id + new_line;

  //std::string config = "#o0#oe0#s" + config_synch_id; //frame requests
  std::string config = "#o1#oe0#s" + config_synch_id; //constant output
  config = "#omb" + config;
  // if (_mode == YAW_PITCH_ROLL) config = "#ob" + config;
  // else if (_mode == ACC_MAG_GYR_RAW) config = "#osrb" + config;
  // else if (_mode == ACC_MAG_GYR_CALIBRATED) config = "#oscb" + config;
  // else throw std::runtime_error("Can not init: unknown 'mode' parameter.");  
  if (write(gl_imu_fd, config.data(), config.length()) != (ssize_t)config.length())
  {
    perror("razor_init:write init");
    return false;
  }
  
  // set blocking I/O
  // (actually semi-blocking, because VTIME is set)
  if (!razor_set_blocking_io()) return false;

  while (true)
  {    
    // try to read one byte from the port
    result = read(gl_imu_fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      if (razor_read_token(config_synch_reply, in))
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


bool razor_set_blocking_io()
{
  int flags;
  // clear O_NDELAY to make I/O blocking again
  // in fact this is semi-blocking, since we set VTIME on the port
  if (((flags = fcntl(gl_imu_fd, F_GETFL, 0)) != -1) &&
      (fcntl(gl_imu_fd, F_SETFL, flags & ~O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool razor_set_nonblocking_io()
{
  int flags;
  // set O_NDELAY to make I/O non-blocking
  if (((flags = fcntl(gl_imu_fd, F_GETFL, 0)) != -1) &&
      (fcntl(gl_imu_fd, F_SETFL, flags | O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool razor_is_io_blocking(int fd)
{
  return (fcntl(fd, F_GETFL, 0) & O_NDELAY);
}

long razor_elapsed_ms(struct timeval start, struct timeval end)
{
  return static_cast<long> ((end.tv_sec - start.tv_sec) * 1000 + (end.tv_usec - start.tv_usec) / 1000);
}

bool razor_read_token(const std::string &token, char c)
{
  if (c == token[razor_input_pos++])
  {
    if (razor_input_pos == token.length())
    {
      // synch token found
      razor_input_pos = 0;
      return true;
    }
  }
  else
  {
    razor_input_pos = 0;
  }
  return false;
}

bool razor_read_data(razor_data_t* data)
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
    if ((result = read(gl_imu_fd, &c, 1)) > 0)
    { //read binary stream
      // (type-punning: aliasing with char* is ok)
      (reinterpret_cast<char*> (&data->data))[razor_input_pos++] = c;
      if (razor_input_pos == 60) // we received a full frame
      {                 //***HARDCODED for 15 data elements * 4 bytes each
	//got the floats, so now get the two unsigned longs (timestamp and dt)
	for (int j = 0; j < 2; j++)
	{
	  for (int i = 0; i < 4; i++)
	  {
	    //if ((result = read(gl_imu_fd, &c, 1)) > 0)
	    if ((result = read(gl_imu_fd, &buf[i], 1)) > 0)
	    {
	      //printf("buf[i] = %d\n", buf[i]);
	      continue;
	      //printf("c = %d\n", c);
	      //t += c * (unsigned long)pow(256.0,(float)i);
	    }
	    else if (result < 0)
	      perror("razor_read_data:failed timestamp read");
	  }
	  memcpy(&t, buf, 4);
	  if (j == 0)
	    data->timestamp = t;
	  else if (j == 1)
	  {
	    data->dt = t;
	    //done, so reset position counter and return success
	    razor_input_pos = 0;
	    return true;
	  }
	}
      }
    }
    else if (result < 0)
    {
      if (errno != EAGAIN && errno != EINTR)
      {
        perror("razor_read_data:cannot read from serial port");
        return false; //failure
      }
    }
    //else result is 0, so no data available (keep waiting)
  }

  //  return true;
}

//From original RazorAHRS.cpp --> this does the reading of the data
// void*
// RazorAHRS::_thread(void *arg)
// {
//   char c;
//   int result;
  
//   try
//   {
//     if (!_init_razor())
//     {
//       error("Tracker init failed.");
//       return arg;
//     }
//   }
//   catch(std::runtime_error& e)
//   {
//     error("Tracker init failed: " + std::string(e.what()));
//     return arg;
//   }
  
//   while (!_stop_thread)
//   {
//     if ((result = read(_serial_port, &c, 1)) > 0) // blocks only for VTIME before returning
//     {
//       // read binary stream
//       // (type-punning: aliasing with char* is ok)
//       (reinterpret_cast<char*> (&_input_buf))[_input_pos++] = c;
      
//       if (_mode == YAW_PITCH_ROLL) {  // 3 floats
//         if (_input_pos == 12) // we received a full frame
//         {
//           // convert endianess if necessary
//           if (_big_endian())
//           {
//             _swap_endianess(_input_buf.ypr, 3);
//           }
          
//           // invoke callback
//           data(_input_buf.ypr);
          
//           _input_pos = 0;
//         }
//       } else { // raw or calibrated sensor data (9 floats)
//         if (_input_pos == 36) // we received a full frame
//         {
//           // convert endianess if necessary
//           if (_big_endian())
//           {
//             _swap_endianess(_input_buf.amg, 9);
//           }
          
//           // invoke callback
//           data(_input_buf.amg);
          
//           _input_pos = 0;
//         }
//       }
//     }
//     // error?
//     else if (result < 0)
//     {
//       if (errno != EAGAIN && errno != EINTR)
//       {
//         error("Can not read from serial port (3).");
//         return arg;
//       }
//     }
//     // else if result is 0, no data was available
//   }

//   return arg;
// }


//from Example.cpp

// // Razor data callback handler
// // Will be called from (and in) Razor background thread!
// // 'data' depends on mode that was set when creating the RazorAHRS object. In this case 'data'
// // holds 3 float values: yaw, pitch and roll.
// void on_data(const float data[])
// {
//   cout << "  " << fixed << setprecision(1) 
//   << "Yaw = " << setw(6) << data[0] << "      Pitch = " << setw(6) << data[1] << "      Roll = " << setw(6) << data[2] << endl;

//   // NOTE: make a copy of the yaw/pitch/roll data if you want to save it or send it to another
//   // thread. Do not save or pass the pointer itself, it will not be valid after this function
//   // returns!
  
//   // If you created the Razor object using RazorAHRS::ACC_MAG_GYR_RAW or RazorAHRS::ACC_MAG_GYR_CALIBRATED
//   // instead of RazorAHRS::YAW_PITCH_ROLL, 'data' would contain 9 values that could be printed like this:
  
//   // cout << "  " << fixed << setprecision(1)
//   // << "ACC = " << setw(6) << data[0] << ", " << setw(6) << data[1] << ", " << setw(6) << data[2]
//   // << "        MAG = " << setw(7) << data[3] << ", " << setw(7) << data[4] << ", " << setw(7) << data[5]
//   // << "        GYR = " << setw(7) << data[6] << ", " << setw(7) << data[7] << ", " << setw(7) << data[8] << endl;

// }
