#!/bin/bash
W="/Users/luyang_dev/ns_emulator/games/[超级马里奥 惊奇].Super Mario Bros. Wonder/010015100B514000_build"
REPO="/Users/luyang_dev/workspace/code/third-party/nxnative"

export DM_WINDOW=1
export DM_AUDIO=1
export DM_LANG=zh-Hans
export DM_SHOW_FPS=1

export DM_ROOT="$W"
export DM_ROMFS="$W/extract/v262144/RomFS"
export DM_SAVE="$W/run/save"
export DM_TEMP="$W/run/temp"
export DM_MSL_DIR="$W/shader/cache"
export DM_FONT_DIR="$W/font"
if [ -f "$W/profile/010015100B514000/shader_map.tsv" ]; then
    export DM_NVN_SHMAP="$W/profile/010015100B514000/shader_map.tsv"
else
    export DM_NVN_SHMAP="$REPO/dm/games/010015100B514000/shader_map.tsv"
fi

mkdir -p "$DM_SAVE" "$DM_TEMP"
cd "$W/run"

if [ -f "$W/tools/dmhost" ]; then
    exec "$W/tools/dmhost" "$W/patched_v262144"
else
    exec "$REPO/dm/host/dmhost" "$W/patched_v262144"
fi
