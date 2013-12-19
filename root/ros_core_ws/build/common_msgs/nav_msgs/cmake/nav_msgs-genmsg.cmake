# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "nav_msgs: 5 messages, 2 services")

set(MSG_I_FLAGS "-Inav_msgs:/root/ros_core_ws/src/common_msgs/nav_msgs/msg;-Igeometry_msgs:/root/ros_core_ws/src/common_msgs/geometry_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

#better way to handle this?
set (ALL_GEN_OUTPUT_FILES_cpp "")

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/GridCells.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)
_generate_msg_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)
_generate_msg_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)
_generate_msg_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Odometry.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)
_generate_msg_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)

### Generating Services
_generate_srv_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetMap.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)
_generate_srv_cpp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetPlan.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
)

### Generating Module File
_generate_module_cpp(nav_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(nav_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/GridCells.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)
_generate_msg_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)
_generate_msg_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)
_generate_msg_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Odometry.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)
_generate_msg_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)

### Generating Services
_generate_srv_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetMap.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)
_generate_srv_lisp(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetPlan.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
)

### Generating Module File
_generate_module_lisp(nav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(nav_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/GridCells.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)
_generate_msg_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)
_generate_msg_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)
_generate_msg_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Odometry.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)
_generate_msg_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)

### Generating Services
_generate_srv_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetMap.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/MapMetaData.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/OccupancyGrid.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)
_generate_srv_py(nav_msgs
  /root/ros_core_ws/src/common_msgs/nav_msgs/srv/GetPlan.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/nav_msgs/msg/Path.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
)

### Generating Module File
_generate_module_py(nav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(nav_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "nav_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/nav_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(nav_msgs_gencpp geometry_msgs_gencpp)
add_dependencies(nav_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/nav_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(nav_msgs_genlisp geometry_msgs_genlisp)
add_dependencies(nav_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/nav_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(nav_msgs_genpy geometry_msgs_genpy)
add_dependencies(nav_msgs_genpy std_msgs_genpy)
