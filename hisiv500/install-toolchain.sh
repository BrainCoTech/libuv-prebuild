#!/bin/bash
set -e

# toolchain file
echo "[hisi] install arm-hisiv500-linux toolchain on Linux (32bit)"
FILE="arm-hisiv500-linux.tgz"

# check platfrom
if [ "$(uname)" != "Linux" ] || [ "$(uname -i)" != "i686" ]; then
    echo "[hisi] This toolchain only works on Linux 32-bit"
    exit 1
fi

# check file
if [ ! -f "$FILE" ]; then
    echo "[hisi] $FILE is not exist. Please download it to this directory."
    exit 1
fi

# unzip file
tar -zxf $FILE

# install toolchain
echo "[hisi] need 'sudo' to install x86 toolchain to /opt/hisi-linux/x86-arm/arm-hisiv500-linux"
cd arm-hisiv500-linux
sudo ./arm-hisiv500-linux.install
