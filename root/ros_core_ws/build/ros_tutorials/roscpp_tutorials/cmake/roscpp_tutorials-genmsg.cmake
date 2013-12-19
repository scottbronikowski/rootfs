# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "roscpp_tutorials: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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

### Generating Services
_generate_srv_cpp(roscpp_tutorials
  /root/ros_core_ws/src/ros_tutorials/roscpp_tutorials/srv/TwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/roscpp_tutorials
)

### Generating Module File
_generate_module_cpp(roscpp_tutorials
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/roscpp_tutorials
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(roscpp_tutorials_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(roscpp_tutorials
  /root/ros_core_ws/src/ros_tutorials/roscpp_tutorials/srv/TwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/roscpp_tutorials
)

### Generating Module File
_generate_module_lisp(roscpp_tutorials
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/roscpp_tutorials
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(roscpp_tutorials_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(roscpp_tutorials
  /root/ros_core_ws/src/ros_tutorials/roscpp_tutorials/srv/TwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/roscpp_tutorials
)

### Generating Module File
_generate_module_py(roscpp_tutorials
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/roscpp_tutorials
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(roscpp_tutorials_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "roscpp_tutorials: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/roscpp_tutorials
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(roscpp_tutorials_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/roscpp_tutorials
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(roscpp_tutorials_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/roscpp_tutorials\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/roscpp_tutorials
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(roscpp_tutorials_genpy std_msgs_genpy)
