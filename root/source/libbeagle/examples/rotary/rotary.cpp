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

#include <stdio.h>
#include <stdlib.h>
//#include <beaglebone.h>
#include <rotary.h>
#include <csignal>
#include <signal.h>
#include <sys/time.h>

Rotary* rotary;

double rotary_current_time(void) 
{
  struct timeval time;
  if (gettimeofday(&time, NULL)!=0) printf("gettimeofday failed");
  return ((double)time.tv_sec)+((double)time.tv_usec)/1e6;
}

void temp_handler(int signum) {
  //printf("in signal handler\n");
  // if (rotary->loop_count % (25000) == 0)
  //   printf("Loop count = %ld, time =%.6f\n", rotary->loop_count,
  // 	   rotary_current_time());
  rotary->handler(signum);
  return;
}

void rotary_sigaction(void) { 
  struct sigaction sigact;
  sigact.sa_handler = temp_handler;
  sigemptyset(&sigact.sa_mask);
  sigact.sa_flags = SA_RESTART;
  if (sigaction(SIGALRM, &sigact, NULL)) { 
    perror("sigaction failed");
    exit(-1);
  }
}

void rotary_interrupt_on(int frame_rate) { 
  struct itimerval itimerval;
  itimerval.it_interval.tv_sec = 0;
  itimerval.it_interval.tv_usec = 1000000/frame_rate;
  itimerval.it_value.tv_sec = 0;
  itimerval.it_value.tv_usec = 1000000/frame_rate;
  setitimer(ITIMER_REAL, &itimerval, (struct itimerval *)0);
}



int main(int argc, char **argv) {
  //int number_a = GPIO2_6;
  //int number_b = GPIO2_7;
  int number_a = 173;
  int number_b = 175; //gpio pin numbers for left wheel encoder
  int usec = 40; //microseconds between firings
  int numiterations = 1000000/usec;

	if (argc == 3) {
		number_a = atoi(argv[1]);
		number_b = atoi(argv[2]);
	}

	//Rotary rotary(number_a, number_b);
	rotary = new Rotary(number_a, number_b);

	// rotary.run();
	// while (1) {
	//   //printf("phase: %d  position: %d\n", rotary.phase(), rotary.position());
	//   //		usleep(3750);
	//   printf("Loop count = %d\n", rotary.loop_count);
	//   sleep(1);
	// }
	// rotary.stop();

	//set timer and signal handler
	rotary_sigaction();
	rotary_interrupt_on(numiterations);

	double start = rotary_current_time();
	//run in a loop
	while (rotary->loop_count < numiterations) {
	  
	  //sleep(1);

	}
	double end = rotary_current_time();
	printf("elapsed time for %d iterations with %d "
	       "microseconds between iterations = %.6f\n", 
	       numiterations, usec, end - start);
}
