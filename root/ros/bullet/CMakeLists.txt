cmake_minimum_required(VERSION 2.6)
include($ENV{ROS_ROOT}/core/rosbuild/rosbuild.cmake)
set(ROSPACK_MAKEDIST true)

#include(FindPkgConfig)
rosbuild_init()

rosbuild_add_boost_directories()

MAKE_DIRECTORY(${PROJECT_SOURCE_DIR}/src/)

# Build Bullet
execute_process(COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.bullet
                RESULT_VARIABLE _make_failed)
if(_make_failed)
  message(FATAL_ERROR "Build of Bullet failed")
endif(_make_failed)

### local includes
#include_directories(include)
link_directories(${PROJECT_SOURCE_DIR}/lib)
add_definitions(-DBT_USE_DOUBLE_PRECISION -DBT_EULER_DEFAULT_ZYX)


rosbuild_make_distribution(2.80)
