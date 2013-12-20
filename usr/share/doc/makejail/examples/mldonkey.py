# Tested on GNU/Linux Debian sid
# mldonkey from cvs compiled and run in /home/alain/mldonkey
# Set personals string values in this file and the wrapper code.

# First you have to create a wrapper to execute mldonkey as non-root
# See for example mldonkey_wrapper. at the bottom of this file, you
# can compile it with "gcc -o mldonkey_wrapper mldonkey_wrapper.c"
# It's better than su and sudo which are suid programs
#
# Make sure you can run the wrapper as root outside the jail and that everything
# works fine
#
# Run makejail using this configuration file
#
# Then you can start mldonkey with this command as root :
# chroot /var/chroot/mldonkey /home/alain/mldonkey/mldonkey_wrapper
#
# If you system uses /proc and if there is a comment about it at the
# end of makejail output you must create it (for example at each system startup)

chroot="/var/chroot/mldonkey"

testCommandsInsideJail=["/home/alain/mldonkey/mldonkey_wrapper"]
processNames=["mldonkey"]

preserve=["/dev/log",
		  "/home/alain/mldonkey/*.ini"]

forceCopy=["/home/alain/mldonkey/*.ini"]

testCommandsOutsideJail=["su - alain -c /home/alain/mldonkey/mldonkey_gui"]

# The users which should be allowed to run mldonkey
# Make sure they can execute /usr/local/mldonkey before building the jail

users=["alain"]
groups=["alain"]

keepStraceOutputs=1

# Below is the code of mldonkey_wrapper.c
#
##include <errno.h>
##include <unistd.h>
##include <pwd.h>
#
#main (ac,av)
#{
#  int status;
#  struct passwd *pnew;
#  char **newav;
#
#  pnew=getpwnam("alain");
#
#  status=setregid(pnew->pw_gid,pnew->pw_gid);
#  if (status != 0)
#        {
#          printf("wrapper.c: error in setgeuid, errno = %d\n",errno);
#          return;
#        }
#
#  status=setreuid(pnew->pw_uid,pnew->pw_uid);
#  if (status != 0)
#        {
#          printf("wrapper.c: error in setreuid, errno = %d\n",errno);
#          return;
#        }
#
#  printf("Root privileged dropped successfully\n");
#
#  chdir("/home/alain/mldonkey");
#  printf("Changed working directory to /home/alain\n");
#
#  newav=(char**)malloc(6);
#  newav[0]="mldonkey";
#  newav[1]="-ask_for_gui";
#  newav[2]="false";
#  newav[3]="-start_gui";
#  newav[4]="false";
#  newav[5]=0;
#
#  execv("/home/alain/mldonkey/mldonkey",newav);
#
#  free(newav);
#
#}
