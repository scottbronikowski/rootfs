/*
  Implementation for interface to Sparkfun 9DOF Razor IMU.  Based off RazorAHRS developed by Peter Bartz (https://github.com/ptrbrtz/razor-9dof-ahrs)

  Author: Scott Bronikowski
  Date: 6 June 2014
*/

#include "razor-imu.h"

//global constants
const speed_t razor_speed = B57600;
const char* imu_file = "/dev/RazorIMU";
const int razor_connect_timeout_ms = 5000;

//global vars
int imu_fd;


bool razor_open_serial_port()
{
  // O_NDELAY allows open even with no carrier detect (e.g. needed for Razor)
  if ((imu_fd = open(imu_file, O_RDWR | O_NOCTTY | O_NDELAY)) == -1)
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
      if (tcgetattr(imu_fd, &tio) != 0)
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
      tio.c_cc[VMIN]  = 143; //set minimum number of bytes per read
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
      if (tcsetattr(imu_fd, TCSANOW, &tio) != 0)
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
  write(imu_fd, contact_synch_request.data(), contact_synch_request.length());
  gettimeofday(&t1, NULL);
 // set non-blocking I/O
  if (!razor_set_nonblocking_io()) return false;

  /* look for tracker */
  while (true)
  {
    // try to read one byte from the port
    result = read(imu_fd, &in, 1);
    
    // one byte read
    if (result > 0)
    {
      // if (_read_token(contact_synch_reply, in))
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
      write(imu_fd, contact_synch_request.data(), contact_synch_request.length());
      t1 = t2;
    }
    if (razor_elapsed_ms(t0, t2) > razor_connect_timeout_ms)
      // timeout -> tracker not present
      throw std::runtime_error("Can not init: tracker does not answer.");
  }


  return true;
}


bool razor_set_blocking_io()
{
  int flags;
  // clear O_NDELAY to make I/O blocking again
  // in fact this is semi-blocking, since we set VTIME on the port
  if (((flags = fcntl(imu_fd, F_GETFL, 0)) != -1) &&
      (fcntl(imu_fd, F_SETFL, flags & ~O_NDELAY)) != -1)
    return true;
  else
    return false;
}

bool razor_set_nonblocking_io()
{
  int flags;
  // set O_NDELAY to make I/O non-blocking
  if (((flags = fcntl(imu_fd, F_GETFL, 0)) != -1) &&
      (fcntl(imu_fd, F_SETFL, flags | O_NDELAY)) != -1)
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



/*FROM ORIGINAL RAZORAHRS.CPP */

// RazorAHRS::RazorAHRS(const std::string &port, DataCallbackFunc data_func, ErrorCallbackFunc error_func,
//     Mode mode, int connect_timeout_ms, speed_t speed)
//     : _mode(mode)
//     , _input_pos(0)
//     , _connect_timeout_ms(connect_timeout_ms)
//     , data(data_func)
//     , error(error_func)
//     , _thread_id(0)
//     , _stop_thread(false)
// {  
//   // check data type sizes
//   assert(sizeof(char) == 1);
//   assert(sizeof(float) == 4);

//   // open serial port
//   if (port == "")
//     throw std::runtime_error("No port specified!");
//   if (!_open_serial_port(port.c_str()))
//     throw std::runtime_error("Could not open serial port!");  
      
//   // get port attributes
//   struct termios tio;
//   if (int errorID = tcgetattr(_serial_port, &tio))
//     throw std::runtime_error("Could not get serial port attributes! Error # " + to_str(errorID));
  
//   /* see http://www.easysw.com/~mike/serial/serial.html */
//   /* and also http://linux.die.net/man/3/tcsetattr */
//   // basic raw/non-canonical setup
//   cfmakeraw(&tio);
  
//   // enable reading and ignore control lines
//   tio.c_cflag |= CREAD | CLOCAL;

//   // set 8N1
//   tio.c_cflag &= ~PARENB; // no parity bit
//   tio.c_cflag &= ~CSTOPB; // only one stop bit
//   tio.c_cflag &= ~CSIZE;  // clear data bit number
//   tio.c_cflag |= CS8;     // set 8 data bits
  
//   // no hardware flow control
//   tio.c_cflag &= ~CRTSCTS;
//   // no software flow control  
//   tio.c_iflag &= ~(IXON | IXOFF | IXANY);
  
//   // poll() is broken on OSX, so we set VTIME and use read(), which is ok since
//   // we're reading only one port anyway
//   tio.c_cc[VMIN]  = 0;
//   tio.c_cc[VTIME] = 10; // 10 * 100ms = 1s
  
//   // set port speed
//   if (int errorID = cfsetispeed(&tio, speed))
//     throw std::runtime_error(" " + to_str(errorID)
//         + ": Could not set new serial port input speed to "
//         + to_str(speed) + ".");
//   if (int errorID = cfsetospeed(&tio, speed))
//     throw std::runtime_error(" " + to_str(errorID)
//         + ": Could not set new serial port output speed to "
//         + to_str(speed) + ".");

//   // set port attributes
//   // must be done after setting speed!
//   if (int errorID = tcsetattr(_serial_port, TCSANOW, &tio))
//   {
//     throw std::runtime_error(" " + to_str(errorID)
//         + ": Could not set new serial port attributes.");
//   }

//   // start input/output thread
//   _start_io_thread();
// }

// bool
// RazorAHRS::_open_serial_port(const char *port)
// {
//   // O_NDELAY allows open even with no carrier detect (e.g. needed for Razor)
//   if ((_serial_port = open(port, O_RDWR | O_NOCTTY | O_NDELAY)) != -1)
//   {
//     // make I/O blocking again
//     if (_set_blocking_io()) return true;
//   }
  
//   // something didn't work
//   close(_serial_port);
//   return false;
// }

// bool
// RazorAHRS::_set_blocking_io()
// {
//   int flags;
  
//   // clear O_NDELAY to make I/O blocking again
//   // in fact this is semi-blocking, since we set VTIME on the port
//   if (((flags = fcntl(_serial_port, F_GETFL, 0)) != -1) &&
//       (fcntl(_serial_port, F_SETFL, flags & ~O_NDELAY)) != -1)
//   {
//     return true;
//   }
  
//   return false;
// }
