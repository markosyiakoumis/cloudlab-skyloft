#!/bin/bash

whoami
id

# Install dependencies.
apt-get update
apt-get install -y git cmake pkg-config flex bison meson libelf-dev libssl-dev libnuma-dev python3 python3-numpy pyton3-matplotlib python3-pyelftools

# Execute other necessary initialization scripts.
bash -x /local/repository/scripts/server/kernel.sh
bash -x /local/repository/scripts/server/dpdk.sh
bash -x /local/repository/scripts/server/skyloft.sh
bash -x /local/repository/scripts/server/setup-hosts.sh
bash -x /local/repository/scripts/server/kmod.sh
