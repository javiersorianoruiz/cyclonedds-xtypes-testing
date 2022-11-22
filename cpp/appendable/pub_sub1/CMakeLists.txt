
cmake_minimum_required(VERSION 3.5)

# Set the project name
project (pub_sub1 CXX)

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
execute_process(
    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/test.cpp 
    COMMAND rm -f ${CMAKE_CURRENT_SOURCE_DIR}/test.hpp
    # TO DO:  solve the export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/cyclonedds-cxx/lib/ 
    COMMAND /usr/local/lib/cyclonedds/bin/idlc -l cxx -Wno-implicit-extensibility -o ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/test.idl WORKING_DIRECTORY  ${CMAKE_CURRENT_SOURCE_DIR})

# Add an executable publisher1
add_executable(publisher1 publisher.cpp test.cpp)
target_link_libraries(publisher1 ddscxx ddsc)

# Add an executable subscriber1
add_executable(subscriber1 subscriber.cpp test.cpp)
target_link_libraries(subscriber1 ddscxx ddsc)