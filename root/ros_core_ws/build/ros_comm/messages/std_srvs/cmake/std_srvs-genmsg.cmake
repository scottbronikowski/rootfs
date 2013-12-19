# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "std_srvs: 0 messages, 1 services")

set(MSG_I_FLAGS "")

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
_generate_srv_cpp(std_srvs
  /root/ros_core_ws/src/ros_comm/messages/std_srvs/srv/Empty.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/std_srvs
)

### Generating Module File
_generate_module_cpp(std_srvs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/std_srvs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(std_srvs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(std_srvs
  /root/ros_core_ws/src/ros_comm/messages/std_srvs/srv/Empty.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/std_srvs
)

### Generating Module File
_generate_module_lisp(std_srvs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/std_srvs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(std_srvs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(std_srvs
  /root/ros_core_ws/src/ros_comm/messages/std_srvs/srv/Empty.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/std_srvs
)

### Generating Module File
_generate_module_py(std_srvs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/std_srvs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(std_srvs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "std_srvs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/std_srvs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/std_srvs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/std_srvs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/std_srvs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
