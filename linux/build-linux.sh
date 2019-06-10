#!/bin/bash
set -e
root=$(pwd)

# clean
rm -rf build *.a *.so

# check platform
platform=$(uname)
if [ "$platform" != "Linux" ]; then
    echo "[linux] Your platform ($platform) is not 'Linux'"
    exit 1
fi

# cmake build
cmake -H../libuv -B"build"
cmake --build "build" --config "Release"

# copy static and shared libraries
cp build/libuv_a.a  libuv-linux-$(uname -i).a
cp build/libuv.so   libuv-linux-$(uname -i).so
