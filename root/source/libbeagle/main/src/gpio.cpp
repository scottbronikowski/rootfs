/*
 * Modified by Scott Bronikowski
 * Date: 20 May 2014
 */

/*
 * Copyright (c) 2012 bwgz.org
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <fstream>
#include <iostream>
#include <dirent.h>
#include <stdlib.h>
#include <gpio.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

GPIO::GPIO(int number) {
  this->number = number;
  fd = -1;
  
  char buffer[1024];
  sprintf(buffer, "/sys/class/gpio/gpio%d", number);
  path = buffer;
  
  DIR *dir = opendir(path.c_str());
  if (dir != NULL) {
    existed = true;
    closedir(dir);
  }
  else {
    existed = false;
    ofstream out;
    out.open("/sys/class/gpio/export");
    out << number;
    out.close();
  }
  printf("completed original constructor\n");
}

GPIO::GPIO(int number, string direction) {
  printf("starting new constructor, number = %d, direction = %s\n",
	 number, direction.c_str());
  this->number = number;
  fd = -1;
  
  char buffer[1024];
  sprintf(buffer, "/sys/class/gpio/gpio%d", number);
  path = buffer;
  
  DIR *dir = opendir(path.c_str());
  if (dir != NULL) {
    existed = true;
    closedir(dir);
    //so close the damn thing so it can be reopened
    ofstream out;
    out.open("/sys/class/gpio/unexport");
    out << number;
    out.close();
  }
  // else {
  existed = false;
  ofstream out;
  out.open("/sys/class/gpio/export");
  out << number; //create gpio file node
  out.close();
  
  out.open((path + "/direction").c_str());
  out << direction;  //set gpio direction
  out.close();
  //open file
  path += "/value";
  if (direction.compare("in") == 0) {
    fd = open(path.c_str(), O_RDONLY);
    printf("opened file %s as read only with fd = %d\n",
	   path.c_str(), fd);
  }
  else if (direction.compare("out") == 0) {
    fd = open(path.c_str(), O_WRONLY);
    printf("opened file %s as write only with fd = %d\n",
	   path.c_str(), fd);
  }
  else {
    printf("Unrecognized direction string\n");
  }
  if (fd <= 0) { 
    printf("Failed to open file %s\n", path.c_str());
  }
  // }
}

GPIO::~GPIO() {
  if (fd > 0) {
    close(fd);
  }
  if (!existed) {
    DIR *dir = opendir(path.c_str());
    if (dir != NULL) {
      existed = false;
      ofstream out;
      out.open("/sys/class/gpio/unexport");
      out << number;
      out.close();
    }
  }
}

void GPIO::direction(string direction) {
	ofstream out;
	out.open((path + "/direction").c_str());
	out << direction;
	out.close();
}

void GPIO::value(string value) {
	ofstream out;
	out.open((path + "/value").c_str());
	out << value;
	out.close();
}

void GPIO::value(int value) {
	ofstream out;
	out.open((path + "/value").c_str());
	out << value;
	out.close();
}

string *GPIO::value(string *value) {
	ifstream in;
	in.open((path + "/value").c_str());
	in >> *value;
	in.close();
	return value;
}

int GPIO::value() {
	string value;

	ifstream in;
	in.open((path + "/value").c_str());
	in >> value;
	in.close();
	return atoi(value.c_str());
}

int GPIO::value2() {
  int retval;
  char buf[1];
  
  retval = read(fd, buf, 1);
  if (retval != 1) {
    //printf("value2: read error\n");
    //perror("value2");
  }
  return atoi(buf);
}

void GPIO::dump() {
	cout << "number: " << number << endl;
	cout << "path: " << path << endl;
}
