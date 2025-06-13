#!/bin/bash

# Install the kernel module.
cd /local/skyloft/kmod
UINTR=1 make
make insmod
