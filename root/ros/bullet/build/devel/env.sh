#!/usr/bin/env sh
# generated from catkin/cmake/templates/env.sh.in

if [ $# -eq 0 ] ; then
  /bin/echo "Entering environment at '/root/ros/bullet/build/devel', type 'exit' to leave"
  . "/root/ros/bullet/build/devel/setup.sh"
  "$SHELL" -i
  /bin/echo "Exiting environment at '/root/ros/bullet/build/devel'"
else
  . "/root/ros/bullet/build/devel/setup.sh"
  exec "$@"
fi
