#!/bin/bash

# Setup hosts.
cd /local/skyloft/scripts
./install_deps.sh
./disable_cpufreq_scaling.sh -c 0-23
./setup_host.sh

# Show the NIC's status.
dpdk-devbind.py -s
# Bind the NIC to the UIO driver.
dpdk-devbind.py --bind=uio_pci_generic 17:00.0 --force
