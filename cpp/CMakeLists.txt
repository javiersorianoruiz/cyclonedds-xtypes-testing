cmake_minimum_required(VERSION 3.5)

# Set the project name
project (xtypes_cpp CXX)

#IDLC compiler needs to know the path where libs/plugins cyclonedds-cxx are installed
#So, environment variable LD_LIBRARY_PATH has to be modified including this path
set(ENV{LD_LIBRARY_PATH} "/usr/local/lib/cyclonedds-cxx/lib/:$ENV{LD_LIBRARY_PATH}")
message(STATUS "Directory ENV{LD_LIBRARY_PATH}: $ENV{LD_LIBRARY_PATH}")


add_subdirectory(appendable)
add_subdirectory(mutable)
add_subdirectory(renaming_fields)
