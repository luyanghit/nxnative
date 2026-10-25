#!/bin/bash
W="/Users/luyang_dev/ns_emulator/games/路易吉鬼屋3 路易吉洋馆3 Luigi s Mansion3/0100DCA0064A6000_build"
REPO="/Users/luyang_dev/workspace/code/third-party/nxnative"

export DM_WINDOW=1
export DM_AUDIO=1
export DM_LANG=zh-Hans
export DM_SHOW_FPS=1

export DM_ROOT="$W"
export DM_ROMFS="$W/extract/v327680/RomFS"
export DM_SAVE="$W/run/save"
export DM_TEMP="$W/run/temp"
export DM_MSL_DIR="$W/shader/cache"
export DM_FONT_DIR="$W/font"
export DM_NVN_SHMAP="$REPO/dm/games/0100DCA0064A6000/shader_map.tsv"

if [ -d "$W/aoc" ]; then
    export DM_AOC_DIR="$W/aoc"
fi

mkdir -p "$DM_SAVE" "$DM_TEMP"
cd "$W/run"

if [ -f "$W/tools/dmhost" ]; then
    exec "$W/tools/dmhost" "$W/patched_v327680"
else
    exec "$REPO/dm/host/dmhost" "$W/patched_v327680"
fi
