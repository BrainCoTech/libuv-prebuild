cmake_minimum_required(VERSION 3.0)

# static_libuv
find_library(
    static_libuv
    libuv-win-${CMAKE_GENERATOR_PLATFORM}
    ..
)

# shared_libuv
find_library(
    shared_libuv
    uv
    ../libuv-win-${CMAKE_GENERATOR_PLATFORM}-dll
)

# dep_libs
list(APPEND
    dep_libs
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
target_include_directories(test_static PRIVATE ../../libuv/include)
target_link_libraries(test_static ${static_libuv} ${dep_libs})

# test_shared
add_executable(test_shared main.c)
target_include_directories(test_shared PRIVATE ../../libuv/include)
target_link_libraries(test_shared ${shared_libuv} ${dep_libs})
