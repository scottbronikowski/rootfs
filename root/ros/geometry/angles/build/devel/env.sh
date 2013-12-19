#!/usr/bin/env sh
# generated from catkin/cmake/templates/env.sh.in

if [ $# -eq 0 ] ; then
  /bin/echo "Entering environment at '/root/ros/geometry/angles/build/devel', type 'exit' to leave"
  . "/root/ros/geometry/angles/build/devel/setup.sh"
  "$SHELL" -i
  /bin/echo "Exiting environment at '/root/ros/geometry/angles/build/devel'"
else
  . "/root/ros/geometry/angles/build/devel/setup.sh"
  exec "$@"
fi
