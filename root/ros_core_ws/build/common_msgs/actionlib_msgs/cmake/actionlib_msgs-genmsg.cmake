# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "actionlib_msgs: 3 messages, 0 services")

set(MSG_I_FLAGS "-Iactionlib_msgs:/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_cpp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_cpp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatusArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/actionlib_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(actionlib_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/actionlib_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(actionlib_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_lisp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_lisp(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatusArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/actionlib_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(actionlib_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/actionlib_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(actionlib_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_py(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs
)
_generate_msg_py(actionlib_msgs
  /root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatusArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalStatus.msg;/root/ros_core_ws/src/common_msgs/actionlib_msgs/msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(actionlib_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(actionlib_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "actionlib_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/actionlib_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(actionlib_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/actionlib_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(actionlib_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/actionlib_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(actionlib_msgs_genpy std_msgs_genpy)
