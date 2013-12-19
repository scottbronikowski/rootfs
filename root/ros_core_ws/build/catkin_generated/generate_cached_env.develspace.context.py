catkin_EXTRAS_DIR="/root/ros_core_ws/src/catkin/cmake"

ENV_SCRIPT="/root/ros_core_ws/devel/env.sh"
OUTPUT_SCRIPT="/root/ros_core_ws/build/catkin_generated/env_cached.sh"

PREPEND_SPACE_DIR="/root/ros_core_ws/devel"
CMAKE_PREFIX_PATH="/root/ros_core_ws/devel".split(';') if "/root/ros_core_ws/devel" != "" else []
PYTHON_INSTALL_DIR="lib/python2.7/dist-packages"
