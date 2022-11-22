
cmake_minimum_required(VERSION 3.5)

# Set the project name
project (pub_sub2 CXX)

#include for cyclonedds-cxx
include_directories (/usr/local/lib/cyclonedds-cxx/include/ddscxx/)

#path library cyclonedds-cxx
link_directories(/usr/local/lib/cyclonedds-cxx/lib/)

#include for cyclonedds
include_directories (/usr/local/lib/cyclonedds/include/)

#path library cyclonedds
link_directories(/usr/local/lib/cyclonedds/lib/)

#Compiling IDL files with IDLC
message(STATUS "Directory CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "Directory ENV{LD_LIBRARY_PATH}: $ENV{LD_LIBRARY_PATH}")

#execute_process(
#    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/test.cpp 
#    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/test.hpp
#    COMMAND /usr/local/lib/cyclonedds/bin/idlc -l cxx -Wno-implicit-extensibility -o ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/test.idl WORKING_DIRECTORY  ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command(
    COMMAND /usr/local/lib/cyclonedds/bin/idlc -l cxx -Wno-implicit-extensibility -o ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/test.idl 
    WORKING_DIRECTORY  ${CMAKE_CURRENT_SOURCE_DIR} 
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/test.idl
    OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/test.cpp
    COMMENT "Compiling IDLC test.idl"
    )

#Name of binaries will have as prefix the name of the parent folder
get_filename_component(parent_PATH "${CMAKE_CURRENT_SOURCE_DIR}/.." ABSOLUTE)
get_filename_component(parent_NAME "${parent_PATH}" NAME)
#message(STATUS "parent_NAME: ${parent_NAME}")

# Add an executable publisher2
add_executable(${parent_NAME}_publisher2 publisher.cpp test.cpp)
target_link_libraries(${parent_NAME}_publisher2 ddscxx ddsc)

# Add an executable subscriber2
add_executable(${parent_NAME}_subscriber2 subscriber.cpp test.cpp)
target_link_libraries(${parent_NAME}_subscriber2 ddscxx ddsc)