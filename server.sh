#!/bin/bash

set -x

# Install Dependencies
apt-get update
apt-get install -y git cmake pkg-config flex bison meson libelf-dev libssl-dev python3 python3-pip
pip3 install numpy matplotlib pyelftools

# Clone the AE Repository
git clone https://github.com/yhtzd/skyloft-sosp24-ae.git /local/skyloft-sosp24-ae

# Build and Install the Kernel
git clone -b skyloft --depth 1 https://github.com/yhtzd/uintr-linux-kernel.git /local/uintr-linux-kernel
cd /local/uintr-linux-kernel
./build.sh

# Configure Kernel Commandline Parameters
sudo sed -i 's|^GRUB_CMDLINE_LINUX=.*|GRUB_CMDLINE_LINUX="isolcpus=0-23 nohz_full=0-23 intel_iommu=off nopat watchdog_thresh=0"|' /etc/default/grub
update-grub2
reboot

# Install DPDK
git clone https://github.com/yhtzd/dpdk.git /local/dpdk
cd /local/dpdk
meson build
cd build
ninja
meson install

# Download Skyloft
git clone https://github.com/yhtzd/skyloft.git /local/skyloft
cd /local/skyloft
git submodule update --init --recursive

# Setup Hosts
cd scripts
./install_deps.sh
./disable_cpufreq_scaling.sh -c 0-23
./setup_host.sh

# Install Skyloft kernel module
cd ../kmod
UINTR=1 make
make insmod
