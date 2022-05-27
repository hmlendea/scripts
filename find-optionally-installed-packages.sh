#!/bin/bash

for PACKAGE in $(paru -Q | awk '{print $1}'); do
    if paru -Qi "${PACKAGE}" | grep -q "Optional For\s*:\s*[^N]" \
    && paru -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$" \
    && paru -Qi "${PACKAGE}" | grep -q "Installed as a dependency for another package"; then
        echo "${PACKAGE}"
    fi
done
