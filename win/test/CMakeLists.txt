cmake_minimum_required(VERSION 3.0)

# libuv_header
set(libuv_header ../../libuv/include)

# libuv_static
find_library(
    libuv_static
    uv
    ../${CMAKE_GENERATOR_PLATFORM}/static
)

# libuv_shared
find_library(
    libuv_shared
    uv
    ../${CMAKE_GENERATOR_PLATFORM}/shared
)

# libuv_deps
list(APPEND libuv_deps
    advapi32
    iphlpapi
    psapi
    shell32
    user32
    userenv
    ws2_32
)

# test_static
add_executable(test_static main.c)
target_include_directories(test_static PRIVATE ${libuv_header} )
target_link_libraries(test_static ${libuv_static} ${libuv_deps})

# test_shared
add_executable(test_shared main.c)
target_include_directories(test_shared PRIVATE ${libuv_header})
target_link_libraries(test_shared ${libuv_shared} ${libuv_deps})
