#!/bin/bash

# Install dependencies.
apt-get update
apt-get install -y git cmake pkg-config flex bison meson libelf-dev libssl-dev libnuma-dev python3 python3-numpy pyton3-matplotlib python3-pyelftools

# Execute other necessary initialization scripts.
bash -x kernel.sh
bash -x dpdk.sh
bash -x skyloft.sh
bash -x setup-hosts.sh
bash -x kmod.sh
