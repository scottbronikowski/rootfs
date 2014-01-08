
// g++ -o drive-robot drive-robot.cc -lcurses

#include<stdio.h>
//#include<curses.h>
#include<unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>

int main ()
{
  int i=0;
  mkfifo ("my_stdin", 0777);
  int fifo_fid = open ("my_stdin", O_RDWR);
  assert (fifo_fid);

  int fd = file
  
  //initscr();     //in ncurses
  //noecho();       /* don't echo input */
  //keypad (stdscr, TRUE);   // enable function keys; see ncurses.h for key
  timeout(0);
  bool quit_flg = false;
  
  mvaddstr (0, 0, "");
  /* printw 
    ("Use arrow keys, 'PageUp', 'PageDwon', 'Home' to drive. 'q' to quit.\n"
    "Other keys are 1 2 3 < > . , o c s\n");*/
  printw("Enter decimal value to send to robot. 'q' to quit.\n");

  while (quit_flg == false)
    {
      usleep(10000);		// 10ms is responsive enough
      i=getch();
      mvaddstr (4, 0, "");
      switch (i)
        {
	case KEY_HOME:          // same as Home key
          printw ("Home    ");
          i = 'H';
          write (fifo_fid, &i, 1);
          break;
        case KEY_PPAGE:		// same as PageUp
          printw ("Up      ");
          i = 'U';
          write (fifo_fid, &i, 1);
          break;
        case KEY_NPAGE:		// same as PageDown
          printw ("Down    ");
          i = 'D';
          write (fifo_fid, &i, 1);
          break;
        case KEY_UP:		// Same as up-arrow
          printw ("Foward  ");
          i = 'F';
          write (fifo_fid, &i, 1);
          break;
        case KEY_DOWN:		// Same as down-arrow
          printw ("Backward");
          i = 'B';
          write (fifo_fid, &i, 1);
          break;
        case KEY_RIGHT:		// Same as right-arrow
          printw ("Right   ");
          i = 'R';
          write (fifo_fid, &i, 1);
          break;
        case KEY_LEFT:		// Same as left arrow
          printw ("Left    ");
          i = 'L';
          write (fifo_fid, &i, 1);
          break;
        case '0':
          printw ("0.5cm   ");
          write (fifo_fid, &i, 1);
          break;
        case '1':
          printw ("1cm     ");
          write (fifo_fid, &i, 1);
          break;
        case '2':
          printw ("2cm     ");
          write (fifo_fid, &i, 1);
          break;
        case '3':
          printw ("5cm    ");
          write (fifo_fid, &i, 1);
          break;
        case '4':
          printw ("10cm    ");
          write (fifo_fid, &i, 1);
          break;
        case 's':
          printw ("Store   ");
          write (fifo_fid, &i, 1);
          break;
        case 'd':
          printw ("Delete   ");
          write (fifo_fid, &i, 1);
          break;
        case 'o':
          printw ("Open    ");
          write (fifo_fid, &i, 1);
          break;
        case 'c':
          printw ("Close   ");
          write (fifo_fid, &i, 1);
          break;
        case 'z':
          printw ("Zigzag  ");
          write (fifo_fid, &i, 1);
          break;
        case '>':
          printw ("Joint1 > ");
          write (fifo_fid, &i, 1);
          break;
        case '<':
          printw ("Joint1 < ");
          write (fifo_fid, &i, 1);
          break;
        case '.':
          printw ("Joint2 > ");
          write (fifo_fid, &i, 1);
          break;
        case ',':
          printw ("Joint2 < ");
          write (fifo_fid, &i, 1);
          break;
        case 'h':
          printw ("hold     ");
          write (fifo_fid, &i, 1);
          break;
        case 'r':
          printw ("Restore  ");
          write (fifo_fid, &i, 1);
          break;
        case 'q':
          quit_flg = true;
          write (fifo_fid, &i, 1);
          break;
        default:
          break;
        }
      //      fprintf (stderr, "i=%d %c\n", i,i);
    }
  endwin();
  fprintf (stderr, "\nclosing fifo in 1 sec... \n"
	   "hopefully your program quited already.\n");
  sleep (1);
  close (fifo_fid);
  return 0;
}

