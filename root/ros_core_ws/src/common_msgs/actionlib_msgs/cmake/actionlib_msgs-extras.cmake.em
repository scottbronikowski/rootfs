# need genmsg for _prepend_path()
find_package(catkin REQUIRED COMPONENTS genmsg)

include(CMakeParseArguments)

@[if DEVELSPACE]@
# find program in develspace
find_program_required(GENACTION_BIN genaction.py PATHS @(CMAKE_CURRENT_SOURCE_DIR)/scripts NO_DEFAULT_PATH)
@[else]@
# find program in installspace
find_program_required(GENACTION_BIN genaction.py PATHS @(CMAKE_INSTALL_PREFIX)/lib/@(PROJECT_NAME) NO_DEFAULT_PATH)
@[end if]@

macro(add_action_files)
  cmake_parse_arguments(ARG "NOINSTALL" "DIRECTORY" "FILES" ${ARGN})
  if(ARG_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "add_action_files() called with unused arguments: ${ARG_UNPARSED_ARGUMENTS}")
  endif()

  if(NOT ARG_DIRECTORY)
    set(ARG_DIRECTORY "action")
  endif()

  if(NOT IS_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DIRECTORY})
    message(FATAL_ERROR "add_action_files() directory not found: ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DIRECTORY}")
  endif()

  # if FILES are not passed search action files in the given directory
  list(FIND ARGV "FILES" _index)
  if(_index EQUAL -1)
    file(GLOB ARG_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DIRECTORY}" "${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DIRECTORY}/*.action")
    list(SORT ARG_FILES)
  endif()
  _prepend_path(${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DIRECTORY} "${ARG_FILES}" FILES_W_PATH)

  list(APPEND ${PROJECT_NAME}_ACTION_FILES ${FILES_W_PATH})
  foreach(file ${FILES_W_PATH})
    debug_message(2 "add_action_files() action file: ${file}")
    assert_file_exists(${file} "action file not found")
  endforeach()

  if(NOT ARG_NOINSTALL)
    install(FILES ${FILES_W_PATH} DESTINATION share/${PROJECT_NAME}/${ARG_DIRECTORY})
  endif()

  foreach(actionfile ${FILES_W_PATH})
    get_filename_component(ACTION_SHORT_NAME ${actionfile} NAME_WE)
    set(MESSAGE_DIR ${CATKIN_DEVEL_PREFIX}/share/${PROJECT_NAME}/msg)
    set(OUTPUT_FILES
      ${ACTION_SHORT_NAME}Action.msg
      ${ACTION_SHORT_NAME}ActionGoal.msg
      ${ACTION_SHORT_NAME}ActionResult.msg
      ${ACTION_SHORT_NAME}ActionFeedback.msg
      ${ACTION_SHORT_NAME}Goal.msg
      ${ACTION_SHORT_NAME}Result.msg
      ${ACTION_SHORT_NAME}Feedback.msg)

    _prepend_path(${MESSAGE_DIR}/ "${OUTPUT_FILES}" OUTPUT_FILES_W_PATH)

    message(STATUS "Generating .msg files for action ${PROJECT_NAME}/${ACTION_SHORT_NAME} ${actionfile}")

    stamp(${actionfile})

    if(${actionfile} IS_NEWER_THAN ${MESSAGE_DIR}/${ACTION_SHORT_NAME}Action.msg)
      safe_execute_process(COMMAND ${CATKIN_ENV} ${GENACTION_BIN} ${actionfile} -o ${MESSAGE_DIR})
    endif()

    add_message_files(
      BASE_DIR ${MESSAGE_DIR}
      FILES ${OUTPUT_FILES})
  endforeach()
endmacro()
