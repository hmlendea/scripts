#!/bin/bash

function scan_package() {
    local PACKAGE_NAME="${1}"
    local PACKAGE_INFO=$(pacman -Qi "${PACKAGE_NAME}")

    if grep -q "^Required By\s*:\s*None$" <<< "${PACKAGE_INFO}" \
    && grep -q "^Optional For\s*:\s*None$" <<< "${PACKAGE_INFO}" \
    && grep -q "^Install Reason\s*:\s*.*as a dependency.*" <<< "${PACKAGE_INFO}"; then
        echo "${PACKAGE_NAME}"
    fi
}

for PACKAGE_NAME in $(pacman -Q | awk '{print $1}'); do
    scan_package "${PACKAGE_NAME}"
done
