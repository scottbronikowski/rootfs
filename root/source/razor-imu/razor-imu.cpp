/*
  Implementation for interface to Sparkfun 9DOF Razor IMU.  Based off RazorAHRS developed by Peter Bartz (https://github.com/ptrbrtz/razor-9dof-ahrs)

  Author: Scott Bronikowski
  Date: 6 June 2014
*/

#include "razor-imu.h"

//global constants
const speed_t razor_speed = B57600;

int razor_open_serial_port(const char* port)
{
  int fd;
  // O_NDELAY allows open even with no carrier detect (e.g. needed for Razor)
  if ((fd = open(port, O_RDWR | O_NOCTTY | O_NDELAY)) != -1)
  {
    // make I/O blocking again
    int flags;
    // clear O_NDELAY to make I/O blocking again
    // in fact this is semi-blocking, since we set VTIME on the port
    if (((flags = fcntl(fd, F_GETFL, 0)) != -1) &&
	(fcntl(fd, F_SETFL, flags & ~O_NDELAY)) == -1)
    {//something went wrong
      perror("razor_open_serial_port:fcntl");
      return -1;
    }
    else //blocking IO set, now set other attributes
    {
      // get port attributes
      struct termios tio;
      if (tcgetattr(fd, &tio) != 0)
      {
	perror("razor_open_serial_port:tcgetattr");
	return -1;
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
      tio.c_cc[VMIN]  = 0;
      tio.c_cc[VTIME] = 10; // 10 * 100ms = 1s
  
      // set port speed
      if (cfsetispeed(&tio, razor_speed) != 0)
      {
	perror("razor_open_serial_port:cfsetispeed");
	return -1;
      }
      if (cfsetospeed(&tio, razor_speed) != 0)
      {
	perror("razor_open_serial_port:cfsetospeed");
      }
      // set port attributes
      // must be done after setting speed!
      if (tcsetattr(fd, TCSANOW, &tio) != 0)
      {
	perror("razor_open_serial_port:tcsetattr");
	return -1;
      }

 
    }
  }
  else // something didn't work
  {
    perror("razor_open_serial_port:open");
  }
  return fd; //returns -1 on error
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
