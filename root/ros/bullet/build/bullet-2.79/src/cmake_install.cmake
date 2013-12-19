# Install script for directory: /root/ros/bullet/build/bullet-2.79/src

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/root/ros/bullet")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "Release")
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
  list(APPEND CPACK_ABSOLUTE_DESTINATION_FILES
   "/root/ros/bullet/include/bullet/btBulletCollisionCommon.h;/root/ros/bullet/include/bullet/btBulletDynamicsCommon.h;/root/ros/bullet/include/bullet/Bullet-C-Api.h")
FILE(INSTALL DESTINATION "/root/ros/bullet/include/bullet" TYPE FILE FILES
    "/root/ros/bullet/build/bullet-2.79/src/btBulletCollisionCommon.h"
    "/root/ros/bullet/build/bullet-2.79/src/btBulletDynamicsCommon.h"
    "/root/ros/bullet/build/bullet-2.79/src/Bullet-C-Api.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/MiniCL/cmake_install.cmake")
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/BulletMultiThreaded/cmake_install.cmake")
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/BulletSoftBody/cmake_install.cmake")
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/BulletCollision/cmake_install.cmake")
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/BulletDynamics/cmake_install.cmake")
  INCLUDE("/root/ros/bullet/build/bullet-2.79/src/LinearMath/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

