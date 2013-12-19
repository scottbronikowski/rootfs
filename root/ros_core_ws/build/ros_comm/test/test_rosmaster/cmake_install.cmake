# Install script for directory: /root/ros_core_ws/src/ros_comm/test/test_rosmaster

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/test_rosmaster/msg" TYPE FILE FILES
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Arrays.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Composite.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeA.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/CompositeB.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Embed.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Empty.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Floats.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgA.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgB.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/RosmsgC.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/Simple.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/String.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TVals.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestArrays.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestPrimitives.msg"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/msg/TestString.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/test_rosmaster/srv" TYPE FILE FILES
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/AddTwoInts.srv"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvA.srv"
    "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/srv/RossrvB.srv"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/test_rosmaster/cmake" TYPE FILE FILES "/root/ros_core_ws/build/ros_comm/test/test_rosmaster/catkin_generated/installspace/test_rosmaster-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/include/test_rosmaster")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/share/common-lisp/ros/test_rosmaster")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/root/ros_core_ws/devel/lib/python2.7/dist-packages/test_rosmaster")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/lib/python2.7/dist-packages/test_rosmaster")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/root/ros_core_ws/build/ros_comm/test/test_rosmaster/catkin_generated/installspace/test_rosmaster.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/test_rosmaster/cmake" TYPE FILE FILES
    "/root/ros_core_ws/build/ros_comm/test/test_rosmaster/catkin_generated/installspace/test_rosmasterConfig.cmake"
    "/root/ros_core_ws/build/ros_comm/test/test_rosmaster/catkin_generated/installspace/test_rosmasterConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/test_rosmaster" TYPE FILE FILES "/root/ros_core_ws/src/ros_comm/test/test_rosmaster/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

