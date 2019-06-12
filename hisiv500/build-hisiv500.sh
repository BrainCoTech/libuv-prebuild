#!/bin/bash
set -e
root=$(pwd)
UV_ROOT=$(pwd)/../libuv

# check platfrom
if [ "$(uname)" != "Linux" ] || [ "$(uname -i)" != "i686" ]; then
    echo "[hisi] the cross-compile toolchain only works on Linux 32-bit"
    exit 1
fi

# clean
rm -rf build dist
mkdir build dist

# overwrite libuv unix/thread.c due to the incompatibility with 'uclibc'
cp libuv-thread.c ${UV_ROOT}/src/unix/thread.c

# cmake build
cd build
cmake ${UV_ROOT} -DCMAKE_TOOLCHAIN_FILE=${root}/toolchain.cmake
cmake --build . --config "Release"

# copy libraries to dist and remove build folder
cd ${root}
cp build/libuv_a.a dist/libuv-arm-hisiv500-linux.a
cp build/libuv.so  dist/libuv-arm-hisiv500-linux.so
rm -rf build

# recover the thread.c in libuv
cd ${UV_ROOT}
git checkout -- src/unix/thread.c
