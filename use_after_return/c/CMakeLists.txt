cmake_minimum_required( VERSION 3.15 )

project ( use_after_return LANGUAGES C )

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)  # 不使用编译器扩展

message( STATUS "CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}" )
message( STATUS "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}" )

### asan
option(ENABLE_ASAN "Enable AddressSanitizer" OFF)

if(ENABLE_ASAN)
    message(STATUS "AddressSanitizer enabled")
    add_compile_options(-g -Wall -fsanitize=address -fno-omit-frame-pointer)
    add_link_options(-fsanitize=address)
endif()

### test script
set(TEST_SCRIPTS memcheck.sh)

foreach(script ${TEST_SCRIPTS})
    add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${script}
        #COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy
                ${CMAKE_CURRENT_SOURCE_DIR}/${script}
                ${CMAKE_CURRENT_BINARY_DIR}/${script}
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/${script}
        COMMENT "Copying test script ${script}"
    )
endforeach()

add_custom_target(copy_scripts ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/memcheck.sh
)

### compile
file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.c)

FOREACH (src_file ${SOURCES})
    get_filename_component(exe_file ${src_file} NAME_WLE)
    add_executable(${exe_file} ${src_file})
    #target_link_libraries(${exe_file} PRIVATE asan)
    add_dependencies(${exe_file} copy_scripts)
ENDFOREACH()

