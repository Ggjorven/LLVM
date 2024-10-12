cmake_minimum_required(VERSION 3.12)

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

project(External.LLVM
        VERSION ${LLVM_PACKAGE_VERSION}
        DESCRIPTION "LLVM packages and modules")

function(make_llvm_target module)
  add_library(LLVM::${module} INTERFACE IMPORTED GLOBAL)
  target_include_directories(LLVM::${module} SYSTEM INTERFACE ${LLVM_INCLUDE_DIRS})
  target_compile_definitions(LLVM::${module} INTERFACE ${LLVM_DEFINITIONS})
  
  if(NOT (LLVM_REQUIRES_RTTI OR LLVM_ENABLE_RTTI))
    if(MSVC)
      target_compile_options(LLVM::${module} INTERFACE "/GR-")
    elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "Clang" OR ${CMAKE_CXX_COMPILER_ID} MATCHES "GNU")
      target_compile_options(LLVM::${module} INTERFACE "-fno-rtti")
    endif()
  endif()

  llvm_map_components_to_libnames(llvm_libs ${module})
  target_link_libraries(LLVM::${module} INTERFACE ${llvm_libs})
endfunction()

make_llvm_target(Core)
make_llvm_target(ExecutionEngine)
make_llvm_target(Object)
make_llvm_target(OrcJIT)
make_llvm_target(Support)
make_llvm_target(native)

