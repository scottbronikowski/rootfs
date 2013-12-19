# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "test_rosmaster: 16 messages, 3 services")

set(MSG_I_FLAGS "-Itest_rosmaster:/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg")

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
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Composite.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Embed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgB.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgC.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TVals.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestArrays.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestPrimitives.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)

### Generating Services
_generate_srv_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_srv_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvA.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)
_generate_srv_cpp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvB.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
)

### Generating Module File
_generate_module_cpp(test_rosmaster
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(test_rosmaster_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Composite.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Embed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgB.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgC.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TVals.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestArrays.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestPrimitives.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_msg_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)

### Generating Services
_generate_srv_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_srv_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvA.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)
_generate_srv_lisp(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvB.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
)

### Generating Module File
_generate_module_lisp(test_rosmaster
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(test_rosmaster_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Composite.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Embed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg;/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Floats.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgA.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgB.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgC.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TVals.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestArrays.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestPrimitives.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_msg_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)

### Generating Services
_generate_srv_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/AddTwoInts.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_srv_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvA.srv
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)
_generate_srv_py(test_rosmaster
  /root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvB.srv
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
)

### Generating Module File
_generate_module_py(test_rosmaster
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(test_rosmaster_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "test_rosmaster: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/test_rosmaster
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/test_rosmaster
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/test_rosmaster
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
