catkin_EXTRAS_DIR="/root/ros_core_ws/install/share/catkin/cmake"

ENV_SCRIPT="/root/ros/bullet/build/devel/env.sh"
OUTPUT_SCRIPT="/root/ros/bullet/build/catkin_generated/env_cached.sh"

PREPEND_SPACE_DIR="/root/ros/bullet/build/devel"
CMAKE_PREFIX_PATH="/root/ros/bullet/build/devel;/root/ros_core_ws/install".split(';') if "/root/ros/bullet/build/devel;/root/ros_core_ws/install" != "" else []
PYTHON_INSTALL_DIR="lib/python2.7/dist-packages"
