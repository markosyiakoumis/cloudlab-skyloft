#!/bin/bash

# Check whether Skyloft has already been installed.
if [ -d /local/skyloft ]; then
    exit 0
fi

# Install Skyloft.
git clone https://github.com/yhtzd/skyloft.git /local/skyloft
cd /local/skyloft
git submodule update --init --recursive
