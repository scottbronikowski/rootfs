# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "stereo_msgs: 1 messages, 0 services")

set(MSG_I_FLAGS "-Istereo_msgs:/root/ros_core_ws/src/common_msgs/stereo_msgs/msg;-Isensor_msgs:/root/ros_core_ws/src/common_msgs/sensor_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(stereo_msgs
  /root/ros_core_ws/src/common_msgs/stereo_msgs/msg/DisparityImage.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/RegionOfInterest.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/Image.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/stereo_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(stereo_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/stereo_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(stereo_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(stereo_msgs
  /root/ros_core_ws/src/common_msgs/stereo_msgs/msg/DisparityImage.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/RegionOfInterest.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/Image.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/stereo_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(stereo_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/stereo_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(stereo_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(stereo_msgs
  /root/ros_core_ws/src/common_msgs/stereo_msgs/msg/DisparityImage.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/RegionOfInterest.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/sensor_msgs/msg/Image.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/stereo_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(stereo_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/stereo_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(stereo_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "stereo_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/stereo_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(stereo_msgs_gencpp sensor_msgs_gencpp)
add_dependencies(stereo_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/stereo_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(stereo_msgs_genlisp sensor_msgs_genlisp)
add_dependencies(stereo_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/stereo_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/stereo_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(stereo_msgs_genpy sensor_msgs_genpy)
add_dependencies(stereo_msgs_genpy std_msgs_genpy)
