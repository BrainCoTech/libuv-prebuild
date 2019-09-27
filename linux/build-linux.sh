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
cmake -H../libuv -B"build" \
    -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE
    # https://github.com/BrainCoTech/libuv-prebuild/issues/1
    # https://mropert.github.io/2018/02/02/pic_pie_sanitizers/
    # https://gitlab.kitware.com/cmake/cmake/issues/14983#note_363197

cmake --build "build" --config "Release"

# copy static and shared libraries
cp build/libuv_a.a  libuv-linux-$(uname -i).a
cp build/libuv.so   libuv-linux-$(uname -i).so
