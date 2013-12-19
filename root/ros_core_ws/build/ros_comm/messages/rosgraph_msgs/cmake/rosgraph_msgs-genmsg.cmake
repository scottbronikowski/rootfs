# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "rosgraph_msgs: 2 messages, 0 services")

set(MSG_I_FLAGS "-Irosgraph_msgs:/root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Clock.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosgraph_msgs
)
_generate_msg_cpp(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Log.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosgraph_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(rosgraph_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosgraph_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(rosgraph_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Clock.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosgraph_msgs
)
_generate_msg_lisp(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Log.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosgraph_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(rosgraph_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosgraph_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(rosgraph_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Clock.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosgraph_msgs
)
_generate_msg_py(rosgraph_msgs
  /root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg/Log.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosgraph_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(rosgraph_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosgraph_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(rosgraph_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "rosgraph_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosgraph_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(rosgraph_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosgraph_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(rosgraph_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosgraph_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosgraph_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(rosgraph_msgs_genpy std_msgs_genpy)
