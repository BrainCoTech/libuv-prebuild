#!/bin/bash
set -e
root=$(pwd)

# clean
rm -rf build libuv-win*

function build() {
    cmake --build "build/${ARCH}" --config "Release"

    # static library
    mv build/${ARCH}/Release/uv_a.lib   libuv-win-${ARCH}.lib

    # shared library (DLL)
    DLL_DIR="libuv-win-${ARCH}-dll"
    mv build/${ARCH}/Release/   ${DLL_DIR}

    # pack DLL folder (choco install zip)
    zip -r ${DLL_DIR}.zip       ${DLL_DIR}
}

# 1. cmake build x86
ARCH="x86"
cmake -H../libuv -B"build/${ARCH}"
build

# 2. cmake build x64
ARCH="x64"
cmake -H../libuv -B"build/${ARCH}" -A"x64"
build

# remove build folder
rm -rf build
