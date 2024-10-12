cmake_minimum_required(VERSION 3.12)

set(CMAKE_CXX_STANDARD 20)

project(LLVM
        VERSION 1.0
        DESCRIPTION "A simple cmake app for using LLVM.")

add_subdirectory(Starter)

add_subdirectory(vendor)