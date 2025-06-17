#!/bin/bash

# Check wether the initial startup service has already been executed.
if [ -f /local/startup_service_done ]; then
    exit 0
fi

# Install dependencies.
apt-get update
apt-get install -y git cmake pkg-config flex bison meson libelf-dev libssl-dev libnuma-dev python3 python3-numpy python3-matplotlib python3-pyelftools

# Execute other necessary initialization scripts.
/local/repository/server/installers/kernel.sh
/local/repository/server/installers/dpdk.sh
/local/repository/server/installers/skyloft.sh
/local/repository/server/scripts/setup-hosts.sh
/local/repository/server/installers/kmod.sh

# Mark that the startup service has finished.
touch /local/startup_service_done
