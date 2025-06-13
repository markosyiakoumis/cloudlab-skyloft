#!/bin/bash

# Check whether the custom kernel has already been loaded.
if ! uname -r | grep generic > /dev/null; then
    exit 0
fi

# Build and install the kernel.
git clone -b skyloft --depth 1 https://github.com/yhtzd/uintr-linux-kernel.git /local/uintr-linux-kernel
cd /local/uintr-linux-kernel
./build.sh

# Configure the kernel's commandline parameters.
sed -i 's|^GRUB_CMDLINE_LINUX=.*|GRUB_CMDLINE_LINUX="isolcpus=0-23 nohz_full=0-23 intel_iommu=off nopat watchdog_thresh=0"|' /etc/default/grub

update-grub2
sleep 1m
reboot
