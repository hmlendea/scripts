#!/bin/bash

for PACKAGE in $(pacman -Q | awk '{print $1}'); do
    if pacman -Qi "${PACKAGE}" | grep -q "Optional For\s*:\s*[^N]" \
    && pacman -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$" \
    && pacman -Qi "${PACKAGE}" | grep -q "Installed as a dependency for another package"; then
        echo "${PACKAGE}"
    fi
done
