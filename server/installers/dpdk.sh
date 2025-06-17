#!/bin/bash

# Check whether DPDK has already been installed.
if [ -d /local/dpdk ]; then
    exit 0
fi

# Install DPDK.
git clone https://github.com/yhtzd/dpdk.git /local/dpdk
cd /local/dpdk
meson build
cd build
ninja
meson install
