#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)

# clean
rm -rf build x86 x64

function build() {
    cmake --build "build/${ARCH}" --config "Release"

    # static library
    dist=${SCRIPT_DIR}/${ARCH}/static
    mkdir -p ${dist}
    mv build/${ARCH}/Release/uv_a.lib  ${dist}/uv.lib

    # shared library
    mv build/${ARCH}/Release/  ${SCRIPT_DIR}/${ARCH}/shared
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
