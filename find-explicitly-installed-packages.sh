#!/bin/bash

for PACKAGE in $(pacman -Q | awk '{print $1}'); do
    #if pacman -Qi "${PACKAGE}" | grep -q "Optional For\s*:\s*None$" \
    #&& pacman -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$"; then
    if pacman -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$"; then
        echo "${PACKAGE}"
    fi
done
