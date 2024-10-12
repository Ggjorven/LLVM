cmake_minimum_required(VERSION 3.12)

add_executable(Starter)

target_sources(Starter PRIVATE "src/**.cpp")

target_link_libraries(Starter 
    PRIVATE LLVM::Core
            LLVM::ExecutionEngine
            LLVM::Object
            LLVM::OrcJIT
            LLVM::Support
            LLVM::native)
