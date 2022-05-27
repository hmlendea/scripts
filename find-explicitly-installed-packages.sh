#!/bin/bash

for PACKAGE in $(paru -Q | awk '{print $1}'); do
    #if paru -Qi "${PACKAGE}" | grep -q "Optional For\s*:\s*None$" \
    #&& paru -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$"; then
    if paru -Qi "${PACKAGE}" | grep -q "Required By\s*:\s*None$"; then
        echo "${PACKAGE}"
    fi
done
