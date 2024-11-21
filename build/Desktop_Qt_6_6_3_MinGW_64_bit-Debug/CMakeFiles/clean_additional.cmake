# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appBYD_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appBYD_autogen.dir\\ParseCache.txt"
  "appBYD_autogen"
  )
endif()
