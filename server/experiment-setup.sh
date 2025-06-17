#!/bin/bash

# Wait until the startup service has finished.
while [ ! -f /local/startup_service_done ]; do
    sleep 10
done

EXPERIMENTS=()
for arg in "$@"; do
    case "$arg" in
        --experiments=*)
            value="${arg#--experiments=}"
            IFS=',' read -ra EXPERIMENTS <<< "$value"
            ;;
        *)
            echo "Unknown option: $arg"
            ;;
    esac
done

# Execute the given experiments scripts.
for experiment in "${EXPERIMENTS[@]}"; do
    /local/repository/server/experiments/$experiment.sh
done
