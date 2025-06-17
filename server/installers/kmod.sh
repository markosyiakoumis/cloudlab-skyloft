#!/bin/bash

# Check whether the kernel module has already been installed. 
if lsmod | grep skyloft; then
    exit 0
fi

# Install the kernel module.
cd /local/skyloft/kmod
UINTR=1 make
make insmod
