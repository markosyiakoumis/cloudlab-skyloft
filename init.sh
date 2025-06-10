#!/bin/bash

set -x

if [ -f /local/startup_service_done ]; then
    apt-get update
    apt-get install -y cmake pkg-config libdpdk-dev

    git clone https://github.com/markosyiakoumis/skyloft /local/skyloft
    cd /local/skyloft

    make kmod
    make insmod
else
    sed -i "s/GRUB_CMDLINE_LINUX=\"/GRUB_CMDLINE_LINUX=\"isolcpus=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21 /" /etc/default/grub
    update-grub

    touch /local/startup_service_done
    reboot
fi
