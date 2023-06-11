#!/bin/bash
PLAYLIST_DIR="${1}"

find "$PLAYLIST_DIR" -maxdepth 1 -type f -name "*.mp3" | while read -r MUSIC_FILE; do
    RANDOM_NUMBER=$(printf "%04d" $((RANDOM % 10000)))
    MUSIC_FILE_NAME_ORIGINAL=$(basename "${MUSIC_FILE}" | sed 's/^\[[0-9][0-9]*\]\s*//g')
    MUSIC_FILE_NAME_NEW="[${RANDOM_NUMBER}] $MUSIC_FILE_NAME_ORIGINAL"

    echo "Randomising '${MUSIC_FILE_NAME_ORIGINAL}' as '${MUSIC_FILE_NAME_NEW}'..."
    mv "${MUSIC_FILE}" "${PLAYLIST_DIR}/${MUSIC_FILE_NAME_NEW}"
done
