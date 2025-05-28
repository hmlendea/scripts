#!/bin/bash
PLAYLIST_DIR="${1}"

find "${PLAYLIST_DIR}" -maxdepth 1 -type f -name "*.mp*" | while read -r MUSIC_FILE; do
    RANDOM_NUMBER=$(printf '%04d' $((RANDOM % 10000)))
    MUSIC_FILE_NAME_ORIGINAL=$(basename "${MUSIC_FILE}" | sed \
        -e 's/^\[[0-9][0-9]*\]\s*//g' \
        -e 's/[Oo][Ff][Ff][Ii][Cc][Ii][Aa][Ll] \(4K\|[Aa][Nn][Ii][Mm][Aa][Tt][Ee][Dd]\|[Aa][Uu][Dd][Ii][Oo]\)//g' \
        -e 's/\([Oo][Ff][Ff][Ii][Cc][Ii][Aa][Ll] \)*\(HD \)*\(\([Ll][Yy][Rr][Ii][Cc]\|[Mm][Uu][Ss][Ii][Cc]\) \)*[Vv][Ii][Dd][Ee][Oo]//g' \
        -e 's/\(4K\|HD\) \(Remaster\|Upgrade\|Version\)//g' \
        -e 's/\([Aa][Ll][Tt]\.\|[Bb][Ll][Aa][Cc][Kk] [Aa][Nn][Dd] [Ww][Hh][Ii][Tt][Ee]\|Short\) \(Version\)//g' \
        -e 's/\(Remaster\(ed\)*\|Version\)\s\-*\s*[0-9][0-9]*//g' \
        -e 's/\(Remaster\)*ed\s*[0-9][0-9]*//g' \
        -e 's/\(Remaster\)*ed [Vv]ersion//g' \
        -e 's/[0-9][0-9]*\s*\-*\s*\(Remaster\|Version\)//g' \
        -e 's/([12][0-9][0-9][0-9])//g' \
        -e 's/Remaster//g' \
        -e 's/\s*-\s*\././g' \
        -e 's/(\(HQ\))//g' \
        -e 's/([Aa][Uu][Dd][Ii][Oo])//g' \
        -e 's/(\(ed\|[Ee][Dd][Ii][Tt]\|[Dd][Ee][Mm][Oo]\|[Ll][Yy][Rr][Ii][Cc][Ss]\))//g' \
        -e 's/(feat[^)]*)//g' \
        -e 's/(Live [Aa]t[^)]*)//g' \
        -e 's/\s*\([)"]\)/\1/g' \
        -e 's/\([("]\)\s*/\1/g' \
        -e 's/()//g' \
        -e 's/\s*\././g' \
        -e 's/\s\s\s*/ /g' \
        -e 's/\.mp.*/.mp3/g')
    MUSIC_FILE_NAME_NEW="[${RANDOM_NUMBER}] ${MUSIC_FILE_NAME_ORIGINAL}"

    [ "${MUSIC_FILE_NAME_ORIGINAL}" == "${MUSIC_FILE_NAME_NEW}" ] && continue

    echo "Randomising '${MUSIC_FILE_NAME_ORIGINAL}' as '${MUSIC_FILE_NAME_NEW}'..."
    mv "${MUSIC_FILE}" "${PLAYLIST_DIR}/${MUSIC_FILE_NAME_NEW}"
done
