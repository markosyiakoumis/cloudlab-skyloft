#!/bin/bash

set -x

# Install Dependencies
apt-get update
apt-get install -y git cmake pkg-config bison libelf-dev libssl-dev python3 python3-pip
pip install numpy matplotlib

# Clone the AE Repository
git clone https://github.com/yhtzd/skyloft-sosp24-ae.git

# Build and Install the Kernel
git clone -b skyloft --depth 1 https://github.com/yhtzd/uintr-linux-kernel.git
cd uintr-linux-kernel
./build.sh

# Configure Kernel Commandline Parameters
update-grub2
reboot

# Install DPDK
git clone https://github.com/yhtzd/dpdk.git
cd dpdk
meson build
cd build
ninja
sudo meson install

# Download Skyloft
git clone https://github.com/yhtzd/skyloft.git
cd skyloft
git submodule update --init --recursive

# Setup Hosts
cd skyloft/scripts
./install_deps.sh
./disable_cpufreq_scaling.sh -c 0-23
sudo ./setup_host.sh

# Install Skyloft kernel module
cd skyloft/kmod
UINTR=1 make
make insmod
