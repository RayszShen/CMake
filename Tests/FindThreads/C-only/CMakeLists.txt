cmake_minimum_required(VERSION 3.10)
project(FindThreads_C-only C)

find_package(Threads REQUIRED)

if (NOT WIN32)
  add_executable(thr ${CMAKE_CURRENT_SOURCE_DIR}/../../../Modules/CheckForPthreads.c)
  target_link_libraries(thr Threads::Threads)
endif ()
