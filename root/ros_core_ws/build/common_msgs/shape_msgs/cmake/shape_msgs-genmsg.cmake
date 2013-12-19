# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "shape_msgs: 4 messages, 0 services")

set(MSG_I_FLAGS "-Ishape_msgs:/root/ros_core_ws/src/common_msgs/shape_msgs/msg;-Igeometry_msgs:/root/ros_core_ws/src/common_msgs/geometry_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Mesh.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
)
_generate_msg_cpp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
)
_generate_msg_cpp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Plane.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
)
_generate_msg_cpp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/SolidPrimitive.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(shape_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(shape_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Mesh.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
)
_generate_msg_lisp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
)
_generate_msg_lisp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Plane.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
)
_generate_msg_lisp(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/SolidPrimitive.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(shape_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(shape_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Mesh.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
)
_generate_msg_py(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/MeshTriangle.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
)
_generate_msg_py(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/Plane.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
)
_generate_msg_py(shape_msgs
  /root/ros_core_ws/src/common_msgs/shape_msgs/msg/SolidPrimitive.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(shape_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(shape_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "shape_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/shape_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(shape_msgs_gencpp geometry_msgs_gencpp)
add_dependencies(shape_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/shape_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(shape_msgs_genlisp geometry_msgs_genlisp)
add_dependencies(shape_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/shape_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(shape_msgs_genpy geometry_msgs_genpy)
add_dependencies(shape_msgs_genpy std_msgs_genpy)
