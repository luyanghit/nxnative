#!/bin/bash
# 运行《火焰纹章：风花雪月》Mac 原生窗口版

W="/Users/luyang_dev/ns_emulator/games/FireEmblemThreeHouses/010055D009F78000_build"
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
export DM_NVN_SHMAP="$REPO/dm/games/010055D009F78000/shader_map.tsv"

if [ -d "$W/aoc" ]; then
    export DM_AOC_DIR="$W/aoc"
fi

mkdir -p "$DM_SAVE" "$DM_TEMP"
cd "$W/run"

echo "=========================================="
echo " 正在启动《火焰纹章：风花雪月》(Mac 原生版) ..."
echo " 语言: 简体中文 (zh-Hans)"
echo " 帧率: 原生 60 帧"
echo " 控制: 支持已连接手柄，或使用键盘"
echo "=========================================="

if [ -f "$W/tools/dmhost" ]; then
    exec "$W/tools/dmhost" "$W/patched_v327680"
else
    exec "$REPO/dm/host/dmhost" "$W/patched_v327680"
fi
