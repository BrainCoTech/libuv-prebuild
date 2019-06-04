#!/bin/bash
set -e

# clean
rm -rf build *.a *.dylib

# check platform
platform=$(uname)
if [ "$platform" != "Darwin" ]; then
    echo "[mac] Your platform ($platform) is not 'Darwin'"
    exit 1
fi

# cmake build
cmake -S ../libuv -B "build" -G "Xcode"
cmake --build "build" --config "Release"

# static (Debug: 839KB / Release: 238KB)
# shared (Debug: 288KB / Release: 156KB)
cp build/Release/libuv_a.a    libuv-mac.a
cp build/Release/libuv.dylib  libuv-mac.dylib
