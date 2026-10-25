import SwiftUI
import AppKit
import Combine

// MARK: - Game Card View
public struct GameCardView: View {
    @ObservedObject public var game: GameItem
    @ObservedObject public var settings: AppSettings
    public var onOpenLogs: () -> Void
    
    @State private var isHovered = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Cover Art Container
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color(NSColor.controlBackgroundColor))
                    
                    if let iconURL = game.iconURL, let img = NSImage(contentsOf: iconURL) {
                        Image(nsImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "gamecontroller.fill")
                                .font(.system(size: 44))
                                .foregroundColor(.secondary)
                            Text("无封面")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .aspectRatio(1.0, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: Color.black.opacity(isHovered ? 0.35 : 0.15), radius: isHovered ? 12 : 6, x: 0, y: isHovered ? 6 : 2)
                
                // Status Badge in Top Right
                HStack(spacing: 5) {
                    Circle()
                        .fill(badgeColor)
                        .frame(width: 8, height: 8)
                    Text(badgeText)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.75))
                .clipShape(Capsule())
                .padding(8)
            }
            
            // Title & Info
            VStack(alignment: .leading, spacing: 4) {
                Text(game.title)
                    .font(.system(size: 15, weight: .bold))
                    .lineLimit(1)
                    .help(game.title)
                
                Text(game.englishTitle)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                HStack(spacing: 6) {
                    Text(game.version)
                        .font(.system(size: 10, weight: .medium, design: .monospaced))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.secondary.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Text(String(game.id.prefix(8)) + "...")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.secondary)
                        .help(game.id)
                }
            }
            
            Spacer(minLength: 0)
            
            // Action Buttons
            HStack(spacing: 8) {
                if game.isRunning {
                    Button(action: {
                        GameLauncher.shared.stop(game: game)
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "stop.fill")
                            Text("停止运行")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .controlSize(.regular)
                } else if game.isPacking {
                    HStack(spacing: 6) {
                        ProgressView()
                            .scaleEffect(0.65)
                        Text(game.packProgress.isEmpty ? "打包中..." : game.packProgress)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(Color.secondary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                } else if game.isAppReady {
                    Button(action: {
                        GameLauncher.shared.launch(game: game, settings: settings)
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "play.fill")
                            Text("启动游戏")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .controlSize(.regular)
                } else if game.isPackable {
                    Button(action: {
                        GamePacker.shared.pack(game: game, settings: settings) { _ in }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "shippingbox.fill")
                            Text("打包为 App")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    .controlSize(.regular)
                } else {
                    Button(action: {}) {
                        Text("未就绪")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .disabled(true)
                }
                
                // Context Menu
                Menu {
                    Button(action: {
                        onOpenLogs()
                    }) {
                        Label("实时运行日志", systemImage: "terminal")
                    }
                    
                    Divider()
                    
                    Button(action: {
                        let saveDir = game.officialSaveURL
                        try? FileManager.default.createDirectory(at: saveDir, withIntermediateDirectories: true)
                        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: saveDir.path)
                    }) {
                        Label("打开官方存档目录", systemImage: "folder")
                    }
                    
                    if game.legacySaveURL != nil {
                        Button(action: {
                            game.migrateLegacySaveIfNeeded()
                        }) {
                            Label("迁移旧构建存档至官方目录", systemImage: "arrow.triangle.2.circlepath")
                        }
                    }
                    
                    if let app = game.appURL {
                        Button(action: {
                            NSWorkspace.shared.selectFile(app.path, inFileViewerRootedAtPath: app.deletingLastPathComponent().path)
                        }) {
                            Label("在访达中显示 .app", systemImage: "macwindow")
                        }
                    }
                    
                    Button(action: {
                        let logURL = game.officialLogURL
                        let logDir = logURL.deletingLastPathComponent()
                        try? FileManager.default.createDirectory(at: logDir, withIntermediateDirectories: true)
                        if !FileManager.default.fileExists(atPath: logURL.path) {
                            try? "".write(to: logURL, atomically: true, encoding: .utf8)
                        }
                        NSWorkspace.shared.selectFile(logURL.path, inFileViewerRootedAtPath: logDir.path)
                    }) {
                        Label("在访达中显示日志文件", systemImage: "doc.text")
                    }
                    
                    Divider()
                    
                    if game.buildURL != nil {
                        Button(action: {
                            GamePacker.shared.pack(game: game, settings: settings) { _ in }
                        }) {
                            Label("重新打包为独立 Mac App", systemImage: "shippingbox")
                        }
                    }
                    
                    Button(action: {
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(game.id, forType: .string)
                    }) {
                        Label("复制 Title ID", systemImage: "doc.on.doc")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 13, weight: .bold))
                }
                .menuStyle(.borderlessButton)
                .frame(width: 28, height: 28)
                .background(Color.secondary.opacity(0.12))
                .clipShape(Circle())
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(NSColor.windowBackgroundColor).opacity(isHovered ? 0.95 : 0.65))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(isHovered ? Color.accentColor.opacity(0.5) : Color.primary.opacity(0.08), lineWidth: 1.5)
        )
        .scaleEffect(isHovered ? 1.015 : 1.0)
        .animation(.easeOut(duration: 0.16), value: isHovered)
        .onHover { hover in
            isHovered = hover
        }
    }
    
    private var badgeColor: Color {
        if game.isRunning { return .green }
        if game.isAppReady { return .blue }
        if game.isPackable { return .orange }
        return .gray
    }
    
    private var badgeText: String {
        if game.isRunning { return "运行中" }
        if game.isAppReady { return "Mac App" }
        if game.isPackable { return "待打包" }
        return "未就绪"
    }
}

// MARK: - Log Viewer Sheet
public struct LogViewerSheet: View {
    @ObservedObject public var game: GameItem
    @Environment(\.dismiss) private var dismiss
    @State private var autoScroll = true
    
    // Live disk reload timer
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 8) {
                        Text("运行日志 - 《\(game.title)》")
                            .font(.headline)
                        
                        Circle()
                            .fill(game.isRunning ? Color.green : Color.secondary)
                            .frame(width: 8, height: 8)
                        
                        Text(game.isRunning ? "正在运行 (PID: \(game.processPID ?? 0))" : game.lastStatus)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Text("Title ID: \(game.id) | 日志: \(game.officialLogURL.path)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Toggle("自动滚动", isOn: $autoScroll)
                        .toggleStyle(.checkbox)
                        .font(.caption)
                    
                    Button("访达定位") {
                        let logURL = game.officialLogURL
                        NSWorkspace.shared.selectFile(logURL.path, inFileViewerRootedAtPath: logURL.deletingLastPathComponent().path)
                    }
                    .controlSize(.small)
                    
                    Button("清空日志") {
                        game.clearLogs()
                    }
                    .controlSize(.small)
                    
                    Button("复制全部") {
                        let text = game.logs.joined(separator: "\n")
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(text, forType: .string)
                    }
                    .controlSize(.small)
                    
                    Button("关闭") {
                        dismiss()
                    }
                    .keyboardShortcut(.cancelAction)
                }
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            Divider()
            
            // Console text area
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 2) {
                        if game.logs.isEmpty {
                            Text("暂无日志输出，启动游戏后输出将显示在此处。")
                                .font(.system(size: 12, design: .monospaced))
                                .foregroundColor(.secondary)
                                .padding(12)
                        } else {
                            ForEach(Array(game.logs.enumerated()), id: \.offset) { idx, line in
                                Text(line)
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(colorForLine(line))
                                    .textSelection(.enabled)
                                    .id(idx)
                            }
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color(red: 0.1, green: 0.11, blue: 0.13))
                .onChange(of: game.logs.count) { _ in
                    if autoScroll && !game.logs.isEmpty {
                        proxy.scrollTo(game.logs.count - 1, anchor: .bottom)
                    }
                }
            }
        }
        .frame(minWidth: 720, minHeight: 480)
        .onAppear {
            game.reloadLogsFromDisk()
        }
        .onReceive(timer) { _ in
            if game.isRunning {
                game.reloadLogsFromDisk()
            }
        }
    }
    
    private func colorForLine(_ line: String) -> Color {
        if line.contains("[RED]") || line.contains("CRASH") || line.contains("sig=") || line.contains("错误") || line.contains("failed") {
            return Color(red: 1.0, green: 0.4, blue: 0.4)
        } else if line.contains("[nvn-mtl]") || line.contains("[nvn]") {
            return Color(red: 0.4, green: 0.8, blue: 1.0)
        } else if line.contains("audren:") || line.contains("audio") {
            return Color(red: 1.0, green: 0.85, blue: 0.4)
        } else if line.contains("===") || line.contains("[系统]") || line.contains("launcher:") {
            return Color.white
        } else {
            return Color(red: 0.82, green: 0.85, blue: 0.9)
        }
    }
}

// MARK: - Settings View
public struct SettingsView: View {
    @ObservedObject public var settings: AppSettings
    public var onRefresh: () -> Void
    
    public var body: some View {
        Form {
            Section("目录配置") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("游戏扫描根目录:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack {
                        TextField("游戏目录", text: $settings.gamesDirectory)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("选择...") {
                            chooseDirectory { path in
                                settings.gamesDirectory = path
                                onRefresh()
                            }
                        }
                        
                        Button("打开") {
                            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: settings.gamesDirectory)
                        }
                    }
                    Text("启动器会自动扫描该目录及子文件夹下的所有官方独立游戏 App (.app) 以及可打包的构建目录 (_build)。")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("nxnative 仓库路径:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack {
                        TextField("源码路径", text: $settings.repoDirectory)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("选择...") {
                            chooseDirectory { path in
                                settings.repoDirectory = path
                                onRefresh()
                            }
                        }
                    }
                    Text("用于调用官方 pack_app.py 脚本生成独立 Mac App，并读取着色器映射表。")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            Section("游戏启动配置") {
                Picker("游戏显示语言 (DM_LANG):", selection: $settings.language) {
                    Text("简体中文 (zh-Hans)").tag("zh-Hans")
                    Text("繁体中文 (zh-Hant)").tag("zh-Hant")
                    Text("英语 (en-US)").tag("en-US")
                    Text("日语 (ja)").tag("ja")
                }
                .pickerStyle(.menu)
                
                Toggle("启用窗口化运行 (DM_WINDOW=1)", isOn: $settings.windowedMode)
                Toggle("启用游戏音频输出 (DM_AUDIO=1)", isOn: $settings.enableAudio)
                Toggle("在窗口标题栏显示实时 FPS 帧率 (DM_SHOW_FPS=1)", isOn: $settings.showFPS)
                
                Text("启动器会将上述配置自动同步至 `~/Library/Application Support/nxnative/<TitleID>/env.txt`，双击游戏 App 或在此启动均会自动生效。")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Section("数据与快捷入口") {
                HStack(spacing: 12) {
                    Button(action: {
                        let home = FileManager.default.homeDirectoryForCurrentUser
                        let sup = home.appendingPathComponent("Library/Application Support/nxnative")
                        try? FileManager.default.createDirectory(at: sup, withIntermediateDirectories: true)
                        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: sup.path)
                    }) {
                        Label("打开官方存档总目录", systemImage: "folder")
                    }
                    
                    Button(action: {
                        let home = FileManager.default.homeDirectoryForCurrentUser
                        let logs = home.appendingPathComponent("Library/Logs/nxnative")
                        try? FileManager.default.createDirectory(at: logs, withIntermediateDirectories: true)
                        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: logs.path)
                    }) {
                        Label("打开官方日志总目录", systemImage: "doc.text")
                    }
                }
                .padding(.vertical, 4)
            }
            
            Section("控制器与特性说明") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("• 支持蓝牙连接的 Xbox / PS4 / PS5 DualSense / Switch Pro 手柄原生直连。")
                    Text("• 官方 .app 采用原生 Metal 驱动，并利用 APFS clonefile 零冗余存储 RomFS 与着色器。")
                    Text("• 游戏进程作为独立 App 运行，享受原生 TCC 授权与独立 Dock 切换体验。")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
    
    private func chooseDirectory(completion: @escaping (String) -> Void) {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        if panel.runModal() == .OK, let url = panel.url {
            completion(url.path)
        }
    }
}

// MARK: - Main View
public struct MainView: View {
    @StateObject private var settings = AppSettings()
    @StateObject private var scanner = GameScanner()
    
    @State private var selectedTab: String = "all"
    @State private var searchText: String = ""
    @State private var selectedGameForLogs: GameItem? = nil
    
    private var filteredGames: [GameItem] {
        var list = scanner.games
        if selectedTab == "running" {
            list = list.filter { $0.isRunning }
        } else if selectedTab == "ready" {
            list = list.filter { $0.isAppReady }
        } else if selectedTab == "packable" {
            list = list.filter { !$0.isAppReady && $0.isPackable }
        }
        
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.englishTitle.localizedCaseInsensitiveContains(searchText) ||
                $0.id.localizedCaseInsensitiveContains(searchText) ||
                $0.parentFolder.localizedCaseInsensitiveContains(searchText)
            }
        }
        return list
    }
    
    public var body: some View {
        NavigationSplitView {
            // Sidebar
            List(selection: $selectedTab) {
                Section("游戏库") {
                    NavigationLink(value: "all") {
                        HStack {
                            Label("全部游戏", systemImage: "gamecontroller")
                            Spacer()
                            Text("\(scanner.games.count)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    NavigationLink(value: "running") {
                        HStack {
                            Label("正在运行", systemImage: "bolt.fill")
                            Spacer()
                            let runningCount = scanner.games.filter { $0.isRunning }.count
                            if runningCount > 0 {
                                Text("\(runningCount)")
                                    .font(.caption2)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    
                    NavigationLink(value: "ready") {
                        HStack {
                            Label("Mac App 就绪", systemImage: "macwindow")
                            Spacer()
                            let readyCount = scanner.games.filter { $0.isAppReady }.count
                            if readyCount > 0 {
                                Text("\(readyCount)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    NavigationLink(value: "packable") {
                        HStack {
                            Label("待打包游戏", systemImage: "shippingbox")
                            Spacer()
                            let packCount = scanner.games.filter { !$0.isAppReady && $0.isPackable }.count
                            if packCount > 0 {
                                Text("\(packCount)")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section("系统") {
                    NavigationLink(value: "settings") {
                        Label("设置与目录", systemImage: "gearshape")
                    }
                }
            }
            .listStyle(.sidebar)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200, max: 240)
        } detail: {
            if selectedTab == "settings" {
                SettingsView(settings: settings) {
                    scanner.scan(gamesPath: settings.gamesDirectory, repoPath: settings.repoDirectory)
                }
            } else {
                VStack(spacing: 0) {
                    if scanner.isScanning {
                        ProgressView("正在扫描 Mac 游戏应用...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if filteredGames.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "square.stack.3d.slash")
                                .font(.system(size: 52))
                                .foregroundColor(.secondary)
                            
                            Text(searchText.isEmpty ? "未找到游戏" : "没有匹配的游戏搜索结果")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            Text("请确认游戏目录中包含已打包的 `<游戏名>.app` 或 `*_build` 构建文件夹。")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Button("刷新扫描") {
                                scanner.scan(gamesPath: settings.gamesDirectory, repoPath: settings.repoDirectory)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVGrid(
                                columns: [GridItem(.adaptive(minimum: 220, maximum: 280), spacing: 20)],
                                spacing: 20
                            ) {
                                ForEach(filteredGames) { game in
                                    GameCardView(game: game, settings: settings) {
                                        selectedGameForLogs = game
                                    }
                                }
                            }
                            .padding(22)
                        }
                    }
                }
                .navigationTitle(navigationTitle)
                .searchable(text: $searchText, prompt: "搜索游戏名称或 Title ID...")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button(action: {
                            scanner.scan(gamesPath: settings.gamesDirectory, repoPath: settings.repoDirectory)
                        }) {
                            Label("刷新", systemImage: "arrow.clockwise")
                        }
                        .help("重新扫描游戏目录")
                        
                        Button(action: {
                            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: settings.gamesDirectory)
                        }) {
                            Label("打开游戏目录", systemImage: "folder")
                        }
                        .help("在访达中打开游戏存放目录")
                    }
                }
            }
        }
        .onAppear {
            scanner.scan(gamesPath: settings.gamesDirectory, repoPath: settings.repoDirectory)
        }
        .sheet(item: $selectedGameForLogs) { game in
            LogViewerSheet(game: game)
        }
    }
    
    private var navigationTitle: String {
        switch selectedTab {
        case "running": return "正在运行的游戏"
        case "ready": return "已就绪 Mac App"
        case "packable": return "待打包游戏"
        case "settings": return "设置与路径"
        default: return "NXNative 游戏库"
        }
    }
}
