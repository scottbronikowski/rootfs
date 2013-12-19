#!/usr/bin/env sh
# generated from catkin/python/catkin/environment_cache.py

# based on a snapshot of the environment before and after calling the env script
# it emulates the modifications of the env script.sh without recurring computations

# new environment variables
export CATKIN_TEST_RESULTS_DIR="/root/ros/geometry/angles/build/test_results"
export ROS_TEST_RESULTS_DIR="/root/ros/geometry/angles/build/test_results"

# modified environment variables
export CMAKE_PREFIX_PATH="/root/ros/geometry/angles/build/devel:$CMAKE_PREFIX_PATH"
export CPATH="/root/ros/geometry/angles/build/devel/include:$CPATH"
export LD_LIBRARY_PATH="/root/ros/geometry/angles/build/devel/lib:$LD_LIBRARY_PATH"
export PATH="/root/ros/geometry/angles/build/devel/bin:$PATH"
export PKG_CONFIG_PATH="/root/ros/geometry/angles/build/devel/lib/pkgconfig:$PKG_CONFIG_PATH"
export PYTHONPATH="/root/ros/geometry/angles/build/devel/lib/python2.7/dist-packages:$PYTHONPATH"
export ROS_PACKAGE_PATH="/root/ros/geometry/angles:/root/ros_core_ws/install/share:/root/ros_core_ws/install/stacks"

exec "$@"