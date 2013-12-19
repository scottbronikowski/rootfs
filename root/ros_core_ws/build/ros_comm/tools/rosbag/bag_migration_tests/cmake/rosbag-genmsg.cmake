# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "rosbag: 12 messages, 0 services")

set(MSG_I_FLAGS "-Irosbag:/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current;-Irosgraph_msgs:/root/ros_core_ws/src/ros_comm/messages/rosgraph_msgs/msg;-Istd_msgs:/root/ros_core_ws/src/std_msgs/msg")

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
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Constants.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Converged.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedAddSub.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedMixed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/PartiallyMigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Renamed4.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SubUnmigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)
_generate_msg_cpp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
)

### Generating Services

### Generating Module File
_generate_module_cpp(rosbag
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(rosbag_gencpp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Constants.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Converged.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedAddSub.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedMixed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/PartiallyMigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Renamed4.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SubUnmigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)
_generate_msg_lisp(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
)

### Generating Services

### Generating Module File
_generate_module_lisp(rosbag
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(rosbag_genlisp ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Constants.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Converged.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedAddSub.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedMixed.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedImplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/PartiallyMigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/std_msgs/msg/Header.msg;/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/MigratedExplicit.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Renamed4.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Simple.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SimpleMigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/SubUnmigrated.msg
  "${MSG_I_FLAGS}"
  "/root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)
_generate_msg_py(rosbag
  /root/ros_core_ws/src/ros_comm/tools/rosbag/bag_migration_tests/msg_current/Unmigrated.msg
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
)

### Generating Services

### Generating Module File
_generate_module_py(rosbag
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(rosbag_genpy ALL
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)


debug_message(2 "rosbag: Iflags=${MSG_I_FLAGS}")


if(gencpp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/rosbag
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(rosbag_gencpp rosgraph_msgs_gencpp)
add_dependencies(rosbag_gencpp std_msgs_gencpp)

if(genlisp_INSTALL_DIR)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/rosbag
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(rosbag_genlisp rosgraph_msgs_genlisp)
add_dependencies(rosbag_genlisp std_msgs_genlisp)

if(genpy_INSTALL_DIR)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/rosbag
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "/rosbag/.+/__init__.pyc?$"
  )
endif()
add_dependencies(rosbag_genpy rosgraph_msgs_genpy)
add_dependencies(rosbag_genpy std_msgs_genpy)
