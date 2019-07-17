#!/bin/bash
set -e

# create new build folder
rm -rf build
mkdir build
cd build

# cmake build
cmake .. -A"x64"
cmake --build .

# run test
cd Debug
./win_static.exe
./win_shared.exe
