if(CMAKE_HOST_WIN32 AND CODEPAGE)
  # Run cmake in a new Window to isolate its console code page.
  execute_process(COMMAND cmd /c start /min /wait ""
    ${CMAKE_COMMAND} -DTEST_ENCODING_EXE=${TEST_ENCODING_EXE}
                     -DENCODING=${ENCODING}
                     -DCODEPAGE=${CODEPAGE}
                     -P ${CMAKE_CURRENT_LIST_DIR}/Encoding-windows.cmake)

  # Load our internal UTF-8 representation of the output.
  file(READ "out.txt" out)
else()
  include(${CMAKE_CURRENT_LIST_DIR}/Encoding-common.cmake)
endif()
message("${out}")
