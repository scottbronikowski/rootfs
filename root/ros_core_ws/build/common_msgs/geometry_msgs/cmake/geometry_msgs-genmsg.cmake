# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "geometry_msgs: 23 messages, 0 services")

set(MSG_I_FLAGS "-Igeometry_msgs:/root/ros_core_ws/src/common_msgs/geometry_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PointStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PolygonStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose2D.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/QuaternionStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TransformStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3Stamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_cpp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/WrenchStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(geometry_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(geometry_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PointStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PolygonStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose2D.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/QuaternionStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TransformStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3Stamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)
_generate_msg_lisp(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/WrenchStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(geometry_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(geometry_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PointStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PolygonStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Polygon.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point32.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose2D.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/PoseWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/QuaternionStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TransformStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Transform.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovarianceStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/TwistWithCovariance.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3Stamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)
_generate_msg_py(geometry_msgs
  /root/ros_core_ws/src/common_msgs/geometry_msgs/msg/WrenchStamped.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Wrench.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(geometry_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(geometry_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "geometry_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/geometry_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(geometry_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/geometry_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(geometry_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/geometry_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(geometry_msgs_genpy std_msgs_genpy)
