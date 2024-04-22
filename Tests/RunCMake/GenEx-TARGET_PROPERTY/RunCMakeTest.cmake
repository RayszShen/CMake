include(RunCMake)

run_cmake(ALIAS_GLOBAL)
run_cmake(BadInvalidName)
run_cmake(BadNonTarget)
run_cmake(BadSelfReference)
run_cmake(INCLUDE_DIRECTORIES)
run_cmake(LinkImplementationCycle1)
run_cmake(LinkImplementationCycle2)
run_cmake(LinkImplementationCycle3)
run_cmake(LinkImplementationCycle4)
run_cmake(LinkImplementationCycle5)
run_cmake(LinkImplementationCycle6)
run_cmake(LOCATION)
run_cmake(SOURCES)
run_cmake(TransitiveBuild)
run_cmake(TransitiveLink-CMP0166-OLD)
run_cmake(TransitiveLink-CMP0166-NEW)

block()
  run_cmake(Scope)
  set(RunCMake_TEST_BINARY_DIR ${RunCMake_BINARY_DIR}/Scope-build)
  set(RunCMake_TEST_NO_CLEAN 1)
  run_cmake_command(Scope-build ${CMAKE_COMMAND} --build . --config Debug)
endblock()
