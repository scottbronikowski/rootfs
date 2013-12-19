# Install script for directory: /root/ros_core_ws/src/std_msgs

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/root/ros_core_ws/install")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/std_msgs/msg" TYPE FILE FILES
    "/root/ros_core_ws/src/std_msgs/msg/Bool.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Byte.msg"
    "/root/ros_core_ws/src/std_msgs/msg/ByteMultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Char.msg"
    "/root/ros_core_ws/src/std_msgs/msg/ColorRGBA.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Duration.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Empty.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Float32.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Float32MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Float64.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Float64MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Header.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int16.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int16MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int32.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int32MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int64.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int64MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int8.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Int8MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/MultiArrayDimension.msg"
    "/root/ros_core_ws/src/std_msgs/msg/MultiArrayLayout.msg"
    "/root/ros_core_ws/src/std_msgs/msg/String.msg"
    "/root/ros_core_ws/src/std_msgs/msg/Time.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt16.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt16MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt32.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt32MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt64.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt64MultiArray.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt8.msg"
    "/root/ros_core_ws/src/std_msgs/msg/UInt8MultiArray.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/std_msgs/cmake" TYPE FILE FILES "/root/ros_core_ws/build/std_msgs/catkin_generated/installspace/std_msgs-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/include/std_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/share/common-lisp/ros/std_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/root/ros_core_ws/devel/lib/python2.7/dist-packages/std_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/lib/python2.7/dist-packages/std_msgs")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/root/ros_core_ws/build/std_msgs/catkin_generated/installspace/std_msgs.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/std_msgs/cmake" TYPE FILE FILES
    "/root/ros_core_ws/build/std_msgs/catkin_generated/installspace/std_msgsConfig.cmake"
    "/root/ros_core_ws/build/std_msgs/catkin_generated/installspace/std_msgsConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/std_msgs" TYPE FILE FILES "/root/ros_core_ws/src/std_msgs/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/std_msgs" TYPE DIRECTORY FILES "/root/ros_core_ws/src/std_msgs/include/std_msgs/" REGEX "/[^/]*\\.h$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

