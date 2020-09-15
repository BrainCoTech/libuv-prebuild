# libuv-prebuild
Libuv prebuild.

This libraries automatically builds and tests [libuv](https://github.com/libuv/libuv/commit/cc506dd97c7348abb54ef5c51eb563e1b512b45f)

Pre-built libraries are provided in the release.

## Includes libraries for multiple platforms
* Android (arm64, armeabi-v7a, armeabi-v7a-neon, x86, x64)
* iOS     (armv7, arm64, arm64e)
* Windows (x86, x64)
* Windows (x86, x64)
* Linux   (x86, x64)

# Usage:

## static linking:
Compile your program with a static link to 
`libuv-{os_name}-{architecture_name}.a`        (Android, iOS, Linux, MacOS)/
`libuv-{os_name}-{architecture_name}.lib`                                (Windows)

## dynamic linking:
Compile your program with a static link to 
`libuv-{os_name}-{architecture_name}.so`                (Android, Linux) /
`libuv-{os_name}-{architecture_name}.dll (files in folder)`              (Windows) /
`libuv-{os_name}-{architecture_name}.dylib`                        (MacOS) 



