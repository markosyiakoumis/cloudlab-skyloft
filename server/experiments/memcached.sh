#!/bin/bash

cd /local/repository/skyloft/scripts
./build.sh memcached
./run.sh memcached -p 11211 -t 4 -u root
