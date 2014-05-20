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

#ifndef _GPIO_H
#define _GPIO_H

#include <string>

using namespace std;

class GPIO {
private:
  bool existed;
  int number;
  string path;
  //need to add fd to avoid many open/closes of the file; open in constructor, close in destructor 
  int fd;

public:
  GPIO(int number);
  GPIO(int number, string direction); //new constructor to open fd
  ~GPIO();
  
  void direction(string direction);
  
  void value(string value);
  void value(int value);
  
  string *value(string *value);
  int value();
  int value2();  //uses already opened fd
  
  void dump();
};

#endif
