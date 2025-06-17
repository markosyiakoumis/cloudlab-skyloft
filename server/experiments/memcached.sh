#!/bin/bash

cd /local/skyloft/scripts
./build.sh memcached
./run.sh memcached -p 11211 -t 4 -u root
