# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "rospy_tutorials: 2 messages, 2 services")

set(MSG_I_FLAGS "-Irospy_tutorials:/root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
)
_generate_msg_cpp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/HeaderString.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
)

### Generating Services
_generate_srv_cpp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
)
_generate_srv_cpp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/BadTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
)

### Generating Module File
_generate_module_cpp(rospy_tutorials
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(rospy_tutorials_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
)
_generate_msg_lisp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/HeaderString.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
)

### Generating Services
_generate_srv_lisp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
)
_generate_srv_lisp(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/BadTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
)

### Generating Module File
_generate_module_lisp(rospy_tutorials
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(rospy_tutorials_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
)
_generate_msg_py(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/msg/HeaderString.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
)

### Generating Services
_generate_srv_py(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
)
_generate_srv_py(rospy_tutorials
  /root/ros_core_ws/src/ros_tutorials/rospy_tutorials/srv/BadTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
)

### Generating Module File
_generate_module_py(rospy_tutorials
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(rospy_tutorials_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "rospy_tutorials: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rospy_tutorials
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(rospy_tutorials_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rospy_tutorials
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(rospy_tutorials_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rospy_tutorials
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(rospy_tutorials_genpy std_msgs_genpy)
