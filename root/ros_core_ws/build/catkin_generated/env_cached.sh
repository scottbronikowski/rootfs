#!/usr/bin/env sh
# generated from catkin/python/catkin/environment_cache.py

# based on a snapshot of the environment before and after calling the env script
# it emulates the modifications of the env script.sh without recurring computations

# new environment variables
export CATKIN_TEST_RESULTS_DIR="/root/ros_core_ws/build/test_results"
export CMAKE_PREFIX_PATH="/root/ros_core_ws/devel"
export CPATH="/root/ros_core_ws/devel/include"
export LD_LIBRARY_PATH="/root/ros_core_ws/devel/lib"
export PKG_CONFIG_PATH="/root/ros_core_ws/devel/lib/pkgconfig"
export PYTHONPATH="/root/ros_core_ws/devel/lib/python2.7/dist-packages"
export ROSCONSOLE_CONFIG_FILE="/root/ros_core_ws/src/ros_comm/tools/rosconsole/config/rosconsole.config"
export ROS_DISTRO="groovy"
export ROS_ETC_DIR="/root/ros_core_ws/devel/etc/ros"
export ROS_MASTER_URI="http://localhost:11311"
export ROS_PACKAGE_PATH="/root/ros_core_ws/src"
export ROS_ROOT="/root/ros_core_ws/src/ros/core/roslib/../.."
export ROS_TEST_RESULTS_DIR="/root/ros_core_ws/build/test_results"

# modified environment variables
export PATH="/root/ros_core_ws/devel/bin:$PATH"
export PWD="/root/ros_core_ws/build"

exec "$@"