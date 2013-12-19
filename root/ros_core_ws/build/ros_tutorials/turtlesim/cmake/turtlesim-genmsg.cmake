# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "turtlesim: 3 messages, 5 services")

set(MSG_I_FLAGS "-Iturtlesim:/root/ros_core_ws/src/ros_tutorials/turtlesim/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Color.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_msg_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Pose.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_msg_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Velocity.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)

### Generating Services
_generate_srv_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Kill.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_srv_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/SetPen.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_srv_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Spawn.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_srv_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportAbsolute.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)
_generate_srv_cpp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportRelative.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
)

### Generating Module File
_generate_module_cpp(turtlesim
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(turtlesim_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Color.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_msg_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Pose.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_msg_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Velocity.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)

### Generating Services
_generate_srv_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Kill.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_srv_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/SetPen.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_srv_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Spawn.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_srv_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportAbsolute.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)
_generate_srv_lisp(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportRelative.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
)

### Generating Module File
_generate_module_lisp(turtlesim
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(turtlesim_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Color.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_msg_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Pose.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_msg_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/msg/Velocity.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)

### Generating Services
_generate_srv_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Kill.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_srv_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/SetPen.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_srv_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/Spawn.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_srv_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportAbsolute.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)
_generate_srv_py(turtlesim
  /root/ros_core_ws/src/ros_tutorials/turtlesim/srv/TeleportRelative.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
)

### Generating Module File
_generate_module_py(turtlesim
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(turtlesim_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "turtlesim: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/turtlesim
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(turtlesim_gencpp std_msgs_gencpp)
add_dependencies(turtlesim_gencpp std_srvs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/turtlesim
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(turtlesim_genlisp std_msgs_genlisp)
add_dependencies(turtlesim_genlisp std_srvs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/turtlesim
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(turtlesim_genpy std_msgs_genpy)
add_dependencies(turtlesim_genpy std_srvs_genpy)
