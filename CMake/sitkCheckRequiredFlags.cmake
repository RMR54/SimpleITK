#
#
#

include(CheckCXXCompilerFlag)



#
# Check if we need to enable C++11 with a compiler flag
#


string(FIND "${SimpleITK_REQUIRED_CXX_FLAGS}" "-std=c++11" required)
if(required LESS 0)

  check_cxx_compiler_flag( "-std=c++11" CXX_HAS_stdcxx11)
  if (CXX_HAS_stdcxx11)

    message(STATUS "Checking if c++11 is required...")
    try_compile(SITK_CHECK_CXX11_REQUIRED
      ${SimpleITK_BINARY_DIR}/CMakeTmp
      ${SimpleITK_SOURCE_DIR}/CMake/sitk_check_cxx11_required.cxx
      OUTPUT_VARIABLE OUTPUT)
    if(${SITK_CHECK_CXX11_REQUIRED})
      message(STATUS "Checking if c++11 is required... NO" )
    else()
      message(STATUS "Checking if c++11 is required... YES" )
      file(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
        "Checking if C++11 required try_compile failed with the following output:\n"
        "${OUTPUT}\n")
      set(SimpleITK_REQUIRED_CXX_FLAGS "${SimpleITK_REQUIRED_CXX_FLAGS} -std=c++11")
    endif()

  endif()

endif()
