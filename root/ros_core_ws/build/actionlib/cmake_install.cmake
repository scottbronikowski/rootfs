# Install script for directory: /root/ros_core_ws/src/actionlib

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
  INCLUDE("/root/ros_core_ws/build/actionlib/catkin_generated/safe_execute_install.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/action" TYPE FILE FILES
    "/root/ros_core_ws/src/actionlib/action/Test.action"
    "/root/ros_core_ws/src/actionlib/action/TestRequest.action"
    "/root/ros_core_ws/src/actionlib/action/TwoInts.action"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/msg" TYPE FILE FILES
    "/root/ros_core_ws/devel/share/actionlib/msg/TestAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestResult.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/msg" TYPE FILE FILES
    "/root/ros_core_ws/devel/share/actionlib/msg/TestAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestResult.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/msg" TYPE FILE FILES
    "/root/ros_core_ws/devel/share/actionlib/msg/TestAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestRequestResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TestResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsAction.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsActionFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsActionGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsActionResult.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsFeedback.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsGoal.msg"
    "/root/ros_core_ws/devel/share/actionlib/msg/TwoIntsResult.msg"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/cmake" TYPE FILE FILES "/root/ros_core_ws/build/actionlib/catkin_generated/installspace/actionlib-msg-paths.cmake")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/include/actionlib")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/share/common-lisp/ros/actionlib")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/root/ros_core_ws/devel/lib/python2.7/dist-packages/actionlib")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/lib/python2.7/dist-packages/actionlib" REGEX "/\\_\\_init\\_\\_\\.py$" EXCLUDE REGEX "/\\_\\_init\\_\\_\\.pyc$" EXCLUDE)
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/root/ros_core_ws/devel/lib/python2.7/dist-packages/actionlib" FILES_MATCHING REGEX "/actionlib/.+/__init__.pyc?$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/root/ros_core_ws/build/actionlib/catkin_generated/installspace/actionlib.pc")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib/cmake" TYPE FILE FILES
    "/root/ros_core_ws/build/actionlib/catkin_generated/installspace/actionlibConfig.cmake"
    "/root/ros_core_ws/build/actionlib/catkin_generated/installspace/actionlibConfig-version.cmake"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/actionlib" TYPE FILE FILES "/root/ros_core_ws/src/actionlib/package.xml")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/actionlib" TYPE PROGRAM FILES
    "/root/ros_core_ws/src/actionlib/tools/axclient.py"
    "/root/ros_core_ws/src/actionlib/tools/axserver.py"
    "/root/ros_core_ws/src/actionlib/tools/dynamic_action.py"
    "/root/ros_core_ws/src/actionlib/tools/library.py"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  IF(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so")
    FILE(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so"
         RPATH "")
  ENDIF()
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/root/ros_core_ws/devel/lib/libactionlib.so")
  IF(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so")
    FILE(RPATH_REMOVE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so")
    IF(CMAKE_INSTALL_DO_STRIP)
      EXECUTE_PROCESS(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libactionlib.so")
    ENDIF(CMAKE_INSTALL_DO_STRIP)
  ENDIF()
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/actionlib" TYPE DIRECTORY FILES "/root/ros_core_ws/src/actionlib/include/actionlib/" FILES_MATCHING REGEX "/[^/]*\\.h$")
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/root/ros_core_ws/build/actionlib/test/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

