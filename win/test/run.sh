#!/bin/bash
set -e
cd ${0%/*}
SCRIPT_DIR=$(pwd)

ARCH="x64"

# create new build folder
rm -rf build
mkdir build
cd build

# cmake build
cmake .. -A"${ARCH}"
cmake --build .

# run test_static
cd Debug
echo -e "\n[win] test ${ARCH} static library"
./test_static.exe

# run test_shared
echo -e "\n[win] test ${ARCH} shared library"
PATH="${PATH}:${SCRIPT_DIR}/../${ARCH}/shared" ./test_shared.exe
