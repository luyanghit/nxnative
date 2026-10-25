#!/bin/bash
W="/Users/luyang_dev/ns_emulator/games/节奏天国 奇迹之星 Rhythm Heaven Groove(1)/0100D9F01D474000_build"
REPO="/Users/luyang_dev/workspace/code/third-party/nxnative"

export DM_WINDOW=1
export DM_AUDIO=1
export DM_LANG=zh-Hans
export DM_SHOW_FPS=1

export DM_ROOT="$W"
export DM_ROMFS="$W/extract/v0/RomFS"
export DM_SAVE="$W/run/save"
export DM_TEMP="$W/run/temp"
export DM_MSL_DIR="$W/shader/cache"
export DM_FONT_DIR="$W/font"
export DM_NVN_SHMAP="$REPO/dm/games/0100D9F01D474000/shader_map.tsv"

mkdir -p "$DM_SAVE" "$DM_TEMP"

echo "=========================================="
echo " 正在启动《节奏天国：奇迹之星》(Mac 原生版) ..."
echo " 语言: 简体中文 (zh-Hans)"
echo " 控制: 支持已连接手柄，或使用键盘"
echo "=========================================="

exec "$W/tools/dmhost" "$W/patched_v0"
