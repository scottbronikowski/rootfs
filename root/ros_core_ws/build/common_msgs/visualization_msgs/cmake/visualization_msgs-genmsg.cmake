# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "visualization_msgs: 10 messages, 0 services")

set(MSG_I_FLAGS "-Ivisualization_msgs:/root/ros_core_ws/src/common_msgs/visualization_msgs/msg;-Igeometry_msgs:/root/ros_core_ws/src/common_msgs/geometry_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/ImageMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerFeedback.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerInit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerUpdate.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MarkerArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_cpp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(visualization_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(visualization_msgs_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/ImageMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerFeedback.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerInit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerUpdate.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MarkerArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)
_generate_msg_lisp(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(visualization_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(visualization_msgs_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/ImageMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerFeedback.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerInit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerUpdate.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerControl.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarkerPose.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/InteractiveMarker.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MarkerArray.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Point.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Vector3.msg;/root/ros_core_ws/src/common_msgs/visualization_msgs/msg/Marker.msg;/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Pose.msg;/root/ros_core_ws/src/common_msgs/geometry_msgs/msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)
_generate_msg_py(visualization_msgs
  /root/ros_core_ws/src/common_msgs/visualization_msgs/msg/MenuEntry.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(visualization_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(visualization_msgs_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "visualization_msgs: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/visualization_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(visualization_msgs_gencpp geometry_msgs_gencpp)
add_dependencies(visualization_msgs_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/visualization_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(visualization_msgs_genlisp geometry_msgs_genlisp)
add_dependencies(visualization_msgs_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/visualization_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(visualization_msgs_genpy geometry_msgs_genpy)
add_dependencies(visualization_msgs_genpy std_msgs_genpy)
