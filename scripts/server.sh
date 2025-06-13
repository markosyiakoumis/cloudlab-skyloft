#!/bin/bash

set -x

if ! cat /proc/cmdline | grep isolcpus > /dev/null; then
    # Install Dependencies
    apt-get update
    apt-get install -y git cmake pkg-config flex bison meson libelf-dev libssl-dev libnuma-dev python3 python3-pip
    pip3 install numpy matplotlib pyelftools

    # Build and Install the Kernel
    cd /local/uintr-linux-kernel
    ./build.sh

    # Configure Kernel Commandline Parameters
    sed -i 's|^GRUB_CMDLINE_LINUX=.*|GRUB_CMDLINE_LINUX="isolcpus=0-23 nohz_full=0-23 intel_iommu=off nopat watchdog_thresh=0"|' /etc/default/grub
    update-grub2
    reboot
else
    # Install DPDK
    cd /local/dpdk
    meson build
    cd build
    ninja
    meson install

    # Download Skyloft
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
fi
