#!/bin/bash

set -x

if [ -f /local/startup_service_done/ ]; then
    apt-get update
    apt-get install -y cmake pkg-config libdpdk-dev

    git clone https:///github.com/yhtzd/skyloft /local/skyloft
    cd /local/skyloft

    make kmod
    make insmod
else
    sed -i "s/GRUB_CMDLINE_LINUX=\"/GRUB_CMDLINE_LINUX=\"isolcpus=0,1,2 /" /etc/default/grub
    update-grub

    echo "this works" > /local/test
    > /local/startup_service_done
    reboot
fi
