cmake_minimum_required( VERSION 3.15 )

project ( hello_world_project LANGUAGES CXX )

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

message( STATUS "CMAKE_PROJECT_NAME = ${CMAKE_PROJECT_NAME}" )
message( STATUS "PROJECT_SOURCE_DIR = ${PROJECT_SOURCE_DIR}" )

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

add_executable( link_a_first a.cc b.cc )
add_dependencies( link_a_first copy_scripts )

add_executable( link_b_first b.cc a.cc )
add_dependencies( link_b_first copy_scripts )

add_executable( link_a_first_asan a.cc b.cc )
target_compile_options( link_a_first_asan PRIVATE
    -g -Wall -fsanitize=address -fno-omit-frame-pointer
)
target_link_options( link_a_first_asan PRIVATE
    -fsanitize=address
)
add_dependencies( link_a_first_asan copy_scripts )

add_executable( link_b_first_asan b.cc a.cc )
target_compile_options( link_b_first_asan PRIVATE
    -g -Wall -fsanitize=address -fno-omit-frame-pointer
)
target_link_options( link_b_first_asan PRIVATE
    -fsanitize=address
)
add_dependencies( link_b_first_asan copy_scripts )
