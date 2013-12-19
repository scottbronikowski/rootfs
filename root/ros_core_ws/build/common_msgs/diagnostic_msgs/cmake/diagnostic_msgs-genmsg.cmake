# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "diagnostic_msgs: 3 messages, 1 services")

set(MSG_I_FLAGS "-Idiagnostic_msgs:/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_cpp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_cpp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
)

### Generating Services
_generate_srv_cpp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/srv/SelfTest.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
)

### Generating Module File
_generate_module_cpp(diagnostic_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(diagnostic_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_lisp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_lisp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
)

### Generating Services
_generate_srv_lisp(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/srv/SelfTest.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
)

### Generating Module File
_generate_module_lisp(diagnostic_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(diagnostic_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_py(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
)
_generate_msg_py(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
)

### Generating Services
_generate_srv_py(diagnostic_msgs
  /root/ros_core_ws/src/common_msgs/diagnostic_msgs/srv/SelfTest.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/DiagnosticStatus.msg;/root/ros_core_ws/src/common_msgs/diagnostic_msgs/msg/KeyValue.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
)

### Generating Module File
_generate_module_py(diagnostic_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(diagnostic_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "diagnostic_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/diagnostic_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(diagnostic_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/diagnostic_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(diagnostic_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/diagnostic_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(diagnostic_msgs_genpy std_msgs_genpy)
