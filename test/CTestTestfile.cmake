# CMake generated Testfile for 
# Source directory: /home/algosup/Documents/Github/cpp_tests
# Build directory: /home/algosup/Documents/Github/cpp_tests/test
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(UnitTests "/home/algosup/Documents/Github/cpp_tests/test/unit_tests")
set_tests_properties(UnitTests PROPERTIES  _BACKTRACE_TRIPLES "/home/algosup/Documents/Github/cpp_tests/CMakeLists.txt;19;add_test;/home/algosup/Documents/Github/cpp_tests/CMakeLists.txt;0;")
subdirs("googletest")
