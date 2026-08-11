#!/bin/bash

toggle_mute() {
    local APP_NAME="${@}"

    while read -r LINE; do
        local ID=$(echo "${LINE}" | awk '{print $1}')
        local DESC=$(pactl list sink-inputs | awk -v id="${ID}" '
            BEGIN { RS = ""; FS = "\n" }
            $0 ~ "Sink Input #" id {
            print $0
        }')

        ! grep -q "${APP_NAME}" <<< "${DESC}" && continue
        
        if grep -q "Mute: yes" <<< "${DESC}"; then
            pactl set-sink-input-mute "${ID}" 0
            echo "Unmuted ${APP_NAME} (ID ${ID})"
        else
            pactl set-sink-input-mute "${ID}" 1
            echo "Muted ${APP_NAME} (ID ${ID})"
        fi
    done < <(pactl list sink-inputs short)
}

for APP_NAME in  \
    'java' 'Java(TM) Platform SE 8' \
    'stellaris' 'Warhamme 40,000: Space Marine (tm)' 'Waterdeep.exe'; do
    toggle_mute "${APP_NAME}"
done
