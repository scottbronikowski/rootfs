# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "topic_tools: 0 messages, 4 services")

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
_generate_srv_cpp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxAdd.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
)
_generate_srv_cpp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxDelete.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
)
_generate_srv_cpp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxList.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
)
_generate_srv_cpp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxSelect.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
)

### Generating Module File
_generate_module_cpp(topic_tools
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(topic_tools_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxAdd.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
)
_generate_srv_lisp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxDelete.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
)
_generate_srv_lisp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxList.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
)
_generate_srv_lisp(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxSelect.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
)

### Generating Module File
_generate_module_lisp(topic_tools
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(topic_tools_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxAdd.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
)
_generate_srv_py(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxDelete.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
)
_generate_srv_py(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxList.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
)
_generate_srv_py(topic_tools
  /root/ros_core_ws/src/ros_comm/tools/topic_tools/srv/MuxSelect.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
)

### Generating Module File
_generate_module_py(topic_tools
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(topic_tools_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "topic_tools: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/topic_tools
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(topic_tools_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/topic_tools
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(topic_tools_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/topic_tools
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(topic_tools_genpy std_msgs_genpy)
