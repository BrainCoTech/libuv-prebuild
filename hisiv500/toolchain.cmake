set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# toolchain
set(tools /opt/hisi-linux/x86-arm/arm-hisiv500-linux)
set(CMAKE_C_COMPILER ${tools}/bin/arm-hisiv500-linux-uclibcgnueabi-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/arm-hisiv500-linux-uclibcgnueabi-g++)

# root path
set(CMAKE_FIND_ROOT_PATH /opt/hisi-linux/x86-arm/arm-hisiv500-linux/arm-hisiv500-linux-uclibcgnueabi)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# use C99
set(CMAKE_C_STANDARD 99 CACHE STRING "C99 Standard (toolchain)" FORCE)
set(CMAKE_C_STANDARD_REQUIRED YES CACHE BOOL "C99 Standard required" FORCE)

# flags
set(flags "-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${flags}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flags}")
