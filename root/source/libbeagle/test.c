#include <errno.h>
#include <fcntl.h>
#include <poll.h>
#include <stdio.h>
 
#define A 0
#define B 1
 
void dump_value(int fd) {
        char buffer[1024];
        lseek(fd, 0, 0);
 
        int size = read(fd, buffer, sizeof(buffer));
        buffer[size] = NULL;
 
        printf("\t\t size: %d  buffer: %s\n", size, buffer);
}
 
void dump_event(int fd, struct pollfd *pfd) {
        short revents = pfd->revents;
 
        printf("revents: 0x%04X\n", revents);
        if (revents & POLLERR) {
                printf("\t POLLERR  errno: %d\n", errno);
 
                if (errno == EAGAIN) {
                        printf("\t\t EAGAIN\n");
                }
                if (errno == EINTR) {
                        printf("\t\t EINTR\n");
                }
                if (errno == EINVAL) {
                        printf("\t\t EINVAL\n");
                }
        }
 
        if (revents & POLLHUP) {
                printf("\t POLLHUP\n");
        }
 
        if (revents & POLLNVAL) {
                printf("\t POLLINVAL\n");
        }
 
        if (revents & POLLIN) {
                printf("\t POLLIN\n");
 
                dump_value(fd);
        }
        if (revents & POLLPRI) {
                printf("\t POLLPRI\n");
 
                dump_value(fd);
        }
        if (revents & POLLOUT) {
                printf("\t POLLOUT\n");
        }
        if (revents & POLLRDNORM) {
                printf("\t POLLNORM\n");
        }
        if (revents & POLLRDBAND) {
                printf("\t POLLRDBAND\n");
        }
        if (revents & POLLWRNORM) {
                printf("\t POLLWRNORM\n");
        }
        if (revents & POLLWRBAND) {
                printf("\t POLLWRBAND\n");
        }
}
 
int get_lead(int fd) {
        int value;
        lseek(fd, 0, 0);
 
        char buffer[1024];
        int size = read(fd, buffer, sizeof(buffer));
        if (size != -1) {
                buffer[size] = NULL;
                value = atoi(buffer);
        }
        else {
                value = -1;
        }
 
        return value;
}
 
void main() {
  int fd[2];
  
  fd[A] = open("/sys/class/gpio/gpio173/value", O_RDONLY);
  fd[B] = open("/sys/class/gpio/gpio175/value", O_RDONLY);
  
  struct pollfd pfd[2];
  
  pfd[A].fd = fd[A];
  pfd[A].events = POLLPRI;
  pfd[A].revents = 0;
  
  pfd[B].fd = fd[B];
  pfd[B].events = POLLPRI;
  pfd[B].revents = 0;
  
  int lead[2];
  int iteration = 0;
  while (1) {
    int ready = poll(pfd, 2, -1);
    /* if (iteration % 1000 == 0) */
    /*   printf("ready: %d\n", ready); */
    
    if (pfd[A].revents != 0) {
      /* if (iteration % 1000 == 0) */
      /* 	printf("\t Lead A\n"); */
      //dump_event(fd[A], &pfd[A]);
      lead[A] = get_lead(fd[A]);
    }
    if (pfd[B].revents != 0) {
      /* if (iteration % 1000 == 0) */
      /* 	printf("\t Lead B\n"); */
      //dump_event(fd[B], &pfd[B]);
      lead[B] = get_lead(fd[B]);
    }
    /* if (iteration % 1000 == 0) */
    /*   printf("\t\t A: %d  B: %d\n", lead[A], lead[B]); */
  }
}
