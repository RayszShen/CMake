if("x${RunCMake_TEST}" STREQUAL "xNoMinimumRequired")
  # No cmake_minimum_required(VERSION)
elseif(RunCMake_TEST MATCHES "^CMP0048")
  cmake_minimum_required(VERSION 2.8.12) # old enough to not set CMP0048
else()
  cmake_minimum_required(VERSION 3.10)
endif()
project(${RunCMake_TEST} NONE)
include(${RunCMake_TEST}.cmake)
