#!/bin/bash
set -e

# armeabi, mips, and mips64 are no longer supported
ABIS="armeabi-v7a arm64-v8a x86 x86_64 armeabi-v7a-neon"

# clean
rm -rf build *.a *.so

# check SDK
if [ -z "$ANDROID_HOME" ]; then
    echo "[android] environment variable 'ANDROID_HOME' need to be setup"
    exit 1
fi

# check NDK
if [ -z "$ANDROID_NDK_ROOT" ]; then
    echo "[android] environment variable 'ANDROID_NDK_ROOT' need to be setup"
    exit 1
fi

# use cmake and ninja from Android SDK
root=$(pwd)
cd ${ANDROID_HOME}/cmake/3.10.*/bin/
CMAKE=$(pwd)/cmake
NINJA=$(pwd)/ninja

# build static and shared libraries
cd $root
for ABI in $ABIS
do
    # set ANDROID_ABI
    if [ "$ABI" == "armeabi-v7a-neon" ]; then
        # Same as armeabi-v7a, but enables NEON floating point instructions.
        ANDROID_ABI="armeabi-v7a with NEON"
    else
        ANDROID_ABI=$ABI
    fi

    # cmake generate ninja project
    ${CMAKE} -H"../libuv" -B"build/${ABI}" -G"Ninja" \
        -DANDROID_ABI="${ANDROID_ABI}" \
        -DANDROID_NDK=${ANDROID_NDK_ROOT} \
        -DCMAKE_LIBRARY_OUTPUT_DIRECTORY="out" \
        -DCMAKE_BUILD_TYPE="Release" \
        -DCMAKE_MAKE_PROGRAM=${NINJA} \
        -DCMAKE_TOOLCHAIN_FILE="${ANDROID_NDK_ROOT}/build/cmake/android.toolchain.cmake" \
        -DANDROID_NATIVE_API_LEVEL="21" \
        -DANDROID_TOOLCHAIN="clang"

    # cmake build
    ${CMAKE} --build "build/${ABI}"

    # copy static and shared libraries
    cp build/${ABI}/libuv_a.a     libuv-android-${ABI}.a
    cp build/${ABI}/out/libuv.so  libuv-android-${ABI}.so
done
