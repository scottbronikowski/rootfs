#!/usr/bin/env sh
# generated from catkin/cmake/templates/env.sh.in

if [ $# -eq 0 ] ; then
  /bin/echo "Entering environment at '/root/ros_core_ws/devel', type 'exit' to leave"
  . "/root/ros_core_ws/devel/setup.sh"
  "$SHELL" -i
  /bin/echo "Exiting environment at '/root/ros_core_ws/devel'"
else
  . "/root/ros_core_ws/devel/setup.sh"
  exec "$@"
fi
