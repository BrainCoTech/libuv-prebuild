#!/bin/bash
set -e
root=$(pwd)

# clean
rm -rf build *.lib *.dll

# cmake build
cmake -H../libuv -B"build"
cmake --build "build" --config "Release"

# copy static and shared libraries
cp build/Release/uv_a.lib  libuv-win.lib
cp build/Release/uv.dll    libuv-win.dll
