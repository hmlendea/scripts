#!/bin/bash

for PACKAGE in $(pacman -Q | awk '{print $1}'); do
    PACKAGE_INFO=$(pacman -Qi "${PACKAGE}")
    if grep -q "Required By\s*:\s*None$" <<< "${PACKAGE_INFO}" && \
       grep -q "Optional For\s*:\s*None$" <<< "${PACKAGE_INFO}"; then
        echo "${PACKAGE}"
    fi
done
