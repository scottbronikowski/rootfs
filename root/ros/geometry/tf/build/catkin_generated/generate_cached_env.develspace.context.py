catkin_EXTRAS_DIR="/root/ros_core_ws/install/share/catkin/cmake"

ENV_SCRIPT="/root/ros/geometry/tf/build/devel/env.sh"
OUTPUT_SCRIPT="/root/ros/geometry/tf/build/catkin_generated/env_cached.sh"

PREPEND_SPACE_DIR="/root/ros/geometry/tf/build/devel"
CMAKE_PREFIX_PATH="/root/ros/geometry/tf/build/devel;/root/ros_core_ws/install".split(';') if "/root/ros/geometry/tf/build/devel;/root/ros_core_ws/install" != "" else []
PYTHON_INSTALL_DIR="lib/python2.7/dist-packages"
