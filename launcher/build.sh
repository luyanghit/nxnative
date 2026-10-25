#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

echo "===> 1. 准备构建目录..."
BUILD_DIR="$DIR/build"
APP_NAME="NXNative Launcher.app"
APP_DIR="$BUILD_DIR/$APP_NAME"
CONTENTS="$APP_DIR/Contents"
MACOS="$CONTENTS/MacOS"
RESOURCES="$CONTENTS/Resources"

rm -rf "$BUILD_DIR"
mkdir -p "$MACOS" "$RESOURCES"
touch "$BUILD_DIR/.metadata_never_index"

echo "===> 2. 生成高清应用图标..."
if [ ! -f "$DIR/AppIcon.icns" ]; then
    cat << 'EOF' > /tmp/gen_icon.swift
import AppKit

let size = CGSize(width: 1024, height: 1024)
let image = NSImage(size: size)

image.lockFocus()
guard let ctx = NSGraphicsContext.current?.cgContext else { exit(1) }

// Squircle background
let rect = CGRect(origin: .zero, size: size).insetBy(dx: 60, dy: 60)
let path = CGPath(roundedRect: rect, cornerWidth: 220, cornerHeight: 220, transform: nil)

ctx.saveGState()
ctx.setShadow(offset: CGSize(width: 0, height: -20), blur: 40, color: NSColor.black.withAlphaComponent(0.35).cgColor)
ctx.addPath(path)
ctx.setFillColor(NSColor(red: 0.12, green: 0.13, blue: 0.16, alpha: 1.0).cgColor)
ctx.fillPath()
ctx.restoreGState()

ctx.saveGState()
ctx.addPath(path)
ctx.clip()

// Gradient
let colors = [
    NSColor(red: 0.16, green: 0.18, blue: 0.23, alpha: 1.0).cgColor,
    NSColor(red: 0.08, green: 0.09, blue: 0.12, alpha: 1.0).cgColor
] as CFArray
let colorSpace = CGColorSpaceCreateDeviceRGB()
if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: [0.0, 1.0]) {
    ctx.drawLinearGradient(gradient, start: CGPoint(x: 512, y: 964), end: CGPoint(x: 512, y: 60), options: [])
}

// Border
ctx.setLineWidth(5)
ctx.setStrokeColor(NSColor.white.withAlphaComponent(0.18).cgColor)
ctx.addPath(path)
ctx.strokePath()

// Nintendo Switch Console
let switchWidth: CGFloat = 580
let switchHeight: CGFloat = 360
let switchOriginX: CGFloat = (1024 - switchWidth) / 2
let switchOriginY: CGFloat = (1024 - switchHeight) / 2

// Center screen
let screenRect = CGRect(x: switchOriginX + 110, y: switchOriginY, width: switchWidth - 220, height: switchHeight)
let screenPath = CGPath(roundedRect: screenRect, cornerWidth: 20, cornerHeight: 20, transform: nil)
ctx.setFillColor(NSColor(red: 0.05, green: 0.05, blue: 0.07, alpha: 1.0).cgColor)
ctx.addPath(screenPath)
ctx.fillPath()

// Left Joy-Con (Neon Red)
let leftRect = CGRect(x: switchOriginX, y: switchOriginY, width: 110, height: switchHeight)
let leftPath = CGPath(roundedRect: leftRect, cornerWidth: 55, cornerHeight: 55, transform: nil)
ctx.setFillColor(NSColor(red: 1.0, green: 0.24, blue: 0.28, alpha: 1.0).cgColor)
ctx.addPath(leftPath)
ctx.fillPath()

// Right Joy-Con (Neon Blue)
let rightRect = CGRect(x: switchOriginX + switchWidth - 110, y: switchOriginY, width: 110, height: switchHeight)
let rightPath = CGPath(roundedRect: rightRect, cornerWidth: 55, cornerHeight: 55, transform: nil)
ctx.setFillColor(NSColor(red: 0.0, green: 0.72, blue: 1.0, alpha: 1.0).cgColor)
ctx.addPath(rightPath)
ctx.fillPath()

// Joycon sticks
ctx.setFillColor(NSColor(red: 0.2, green: 0.22, blue: 0.26, alpha: 1.0).cgColor)
ctx.fillEllipse(in: CGRect(x: switchOriginX + 25, y: switchOriginY + switchHeight - 120, width: 60, height: 60))
ctx.fillEllipse(in: CGRect(x: switchOriginX + switchWidth - 85, y: switchOriginY + 60, width: 60, height: 60))

// Text NX
let font = NSFont.systemFont(ofSize: 110, weight: .heavy)
let text = "NX"
let attrs: [NSAttributedString.Key: Any] = [
    .font: font,
    .foregroundColor: NSColor(white: 0.95, alpha: 0.95)
]
let str = NSAttributedString(string: text, attributes: attrs)
let strSize = str.size()
str.draw(at: CGPoint(x: 512 - strSize.width / 2, y: 512 - strSize.height / 2))

ctx.restoreGState()
image.unlockFocus()

if let tiff = image.tiffRepresentation,
   let bitmap = NSBitmapImageRep(data: tiff),
   let png = bitmap.representation(using: .png, properties: [:]) {
    try? png.write(to: URL(fileURLWithPath: "/tmp/icon1024.png"))
}
EOF
    swiftc /tmp/gen_icon.swift -o /tmp/gen_icon && /tmp/gen_icon
    
    mkdir -p /tmp/AppIcon.iconset
    sips -z 16 16     /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_16x16.png > /dev/null
    sips -z 32 32     /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_16x16@2x.png > /dev/null
    sips -z 32 32     /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_32x32.png > /dev/null
    sips -z 64 64     /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_32x32@2x.png > /dev/null
    sips -z 128 128   /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_128x128.png > /dev/null
    sips -z 256 256   /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_128x128@2x.png > /dev/null
    sips -z 256 256   /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_256x256.png > /dev/null
    sips -z 512 512   /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_256x256@2x.png > /dev/null
    sips -z 512 512   /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_512x512.png > /dev/null
    sips -z 1024 1024 /tmp/icon1024.png --out /tmp/AppIcon.iconset/icon_512x512@2x.png > /dev/null
    iconutil -c icns /tmp/AppIcon.iconset -o "$DIR/AppIcon.icns"
    rm -rf /tmp/AppIcon.iconset /tmp/icon1024.png /tmp/gen_icon /tmp/gen_icon.swift
fi

cp "$DIR/AppIcon.icns" "$RESOURCES/AppIcon.icns"
cp "$DIR/Info.plist" "$CONTENTS/Info.plist"

echo "===> 3. 编译 Swift 原生应用..."
swiftc -O -parse-as-library \
    -target arm64-apple-macos13.0 \
    "$DIR/Models.swift" \
    "$DIR/Views.swift" \
    "$DIR/App.swift" \
    -o "$MACOS/NXNative Launcher"

echo "===> 4. 安装到系统应用程序目录 (/Applications/)..."
rm -rf "/Applications/$APP_NAME"
# 清理可能残留的用户应用目录副本，避免 Spotlight 重复索引
rm -rf "$HOME/Applications/$APP_NAME"
cp -R "$APP_DIR" "/Applications/$APP_NAME"

echo "===> 5. 清理临时构建产物..."
rm -rf "$BUILD_DIR"

echo "===> 6. 刷新 macOS 图标与启动台缓存..."
touch "/Applications/$APP_NAME"

echo "================================================="
echo "✅ 构建并安装成功！"
echo "应用名称: NXNative 启动器 (NXNative Launcher.app)"
echo "安装路径: /Applications/$APP_NAME"
echo "您可以在「启动台 (Launchpad)」或通过快捷键 Spotlight (Cmd + 空格) 直接搜索打开！"
echo "================================================="
