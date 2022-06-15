#!/bin/bash
set -e

# clean
rm -rf build *.a

# check platform
platform=$(uname)
if [ "$platform" != "Darwin" ]; then
    echo "[ios] Your platform ($platform) is not 'Darwin'"
    exit 1
fi

# cmake build    #armv7;armv7s;
cmake -S ../libuv -B "build" -G "Xcode" \
    -DCMAKE_SYSTEM_NAME="iOS" \
    -DCMAKE_OSX_ARCHITECTURES="arm64;arm64e;x86_64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="12.5"  -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH="NO" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/build" \
    -DCMAKE_IOS_INSTALL_COMBINED="YES"

cmake --build "build" --config "Release" --target "install" \
      -- ALWAYS_SEARCH_USER_PATHS="NO"       \
         BITCODE_GENERATION_MODE="bitcode"   \
         OTHER_CFLAGS="-fembed-bitcode"

# armv7  (Debug: 1.9MB / Release: 692KB)
# armv7s (Debug: 1.9MB / Release: 693KB)
# arm64  (Debug: 2.0MB / Release: 742KB)
# arm64e (Debug: 2.0MB / Release: 769KB)
# i386   (Debug: 794KB / Release: 210KB)
# x86_64 (Debug: 800KB / Release: 223KB)
ARCHS="arm64 arm64e x86_64"   # armv7 armv7s  i386 
for ARCH in ${ARCHS}
do
    lipo -thin ${ARCH} build/lib/libuv_a.a -output "libuv-ios-${ARCH}.a"
done
