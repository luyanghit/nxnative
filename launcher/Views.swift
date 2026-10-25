import SwiftUI
import AppKit

// MARK: - Game Card View
public struct GameCardView: View {
    @ObservedObject public var game: GameItem
    @ObservedObject public var settings: AppSettings
    public var onOpenLogs: () -> Void
    
    @State private var isHovered = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Game Cover Art Container
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
                .shadow(color: Color.black.opacity(isHovered ? 0.3 : 0.15), radius: isHovered ? 12 : 6, x: 0, y: isHovered ? 6 : 2)
                
                // Status Badge in Top Right
                HStack(spacing: 5) {
                    Circle()
                        .fill(game.isRunning ? Color.green : (game.isReady ? Color.blue : Color.orange))
                        .frame(width: 8, height: 8)
                    Text(game.isRunning ? "运行中" : (game.isReady ? "就绪" : "待构建"))
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
                } else {
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
                    .disabled(!game.isReady)
                }
                
                // Context / More Menu
                Menu {
                    Button(action: {
                        onOpenLogs()
                    }) {
                        Label("实时运行日志", systemImage: "terminal")
                    }
                    
                    Divider()
                    
                    Button(action: {
                        let saveDir = game.buildURL.appendingPathComponent("run/save")
                        try? FileManager.default.createDirectory(at: saveDir, withIntermediateDirectories: true)
                        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: saveDir.path)
                    }) {
                        Label("打开存档目录", systemImage: "folder")
                    }
                    
                    Button(action: {
                        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: game.buildURL.path)
                    }) {
                        Label("在访达中显示", systemImage: "macwindow")
                    }
                    
                    Divider()
                    
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
}

// MARK: - Log Viewer Sheet
public struct LogViewerSheet: View {
    @ObservedObject public var game: GameItem
    @Environment(\.dismiss) private var dismiss
    @State private var autoScroll = true
    
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
                    Text("Title ID: \(game.id) | 宿主: \(game.dmhostURL?.lastPathComponent ?? "未配置")")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Toggle("自动滚动", isOn: $autoScroll)
                        .toggleStyle(.checkbox)
                        .font(.caption)
                    
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
                        ForEach(Array(game.logs.enumerated()), id: \.offset) { idx, line in
                            Text(line)
                                .font(.system(size: 11, design: .monospaced))
                                .foregroundColor(colorForLine(line))
                                .textSelection(.enabled)
                                .id(idx)
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
        .frame(minWidth: 700, minHeight: 460)
    }
    
    private func colorForLine(_ line: String) -> Color {
        if line.contains("[RED]") || line.contains("CRASH") || line.contains("sig=") || line.contains("错误") {
            return Color(red: 1.0, green: 0.4, blue: 0.4)
        } else if line.contains("[nvn-mtl]") || line.contains("[nvn]") {
            return Color(red: 0.4, green: 0.8, blue: 1.0)
        } else if line.contains("audren:") || line.contains("audio") {
            return Color(red: 1.0, green: 0.85, blue: 0.4)
        } else if line.contains("===") || line.contains("[系统]") {
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
                    Text("启动器会自动扫描该目录及子文件夹下的所有已编译游戏 (以 _build 结尾)。")
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
                    Text("用于查找着色器映射表 (shader_map.tsv) 以及全局宿主构建文件。")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            
            Section("启动默认设置") {
                Picker("游戏显示语言:", selection: $settings.language) {
                    Text("简体中文 (zh-Hans)").tag("zh-Hans")
                    Text("繁体中文 (zh-Hant)").tag("zh-Hant")
                    Text("英语 (en-US)").tag("en-US")
                    Text("日语 (ja)").tag("ja")
                }
                .pickerStyle(.menu)
                
                Toggle("启用窗口化运行 (DM_WINDOW=1)", isOn: $settings.windowedMode)
                Toggle("启用游戏音频输出 (DM_AUDIO=1)", isOn: $settings.enableAudio)
                Toggle("在窗口标题栏显示实时 FPS 帧率 (DM_SHOW_FPS=1)", isOn: $settings.showFPS)
            }
            
            Section("手柄与控制") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("• 支持蓝牙连接的 Xbox / PS4 / PS5 DualSense / Switch Pro 手柄直连。")
                    Text("• 若未连接手柄，默认支持键盘方向键与按键控制。")
                    Text("• 游戏在 Mac 上为原生 Metal + ARM64 执行，支持全 60 帧无插帧渲染。")
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
        } else if selectedTab == "incomplete" {
            list = list.filter { !$0.isReady }
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
                    
                    NavigationLink(value: "incomplete") {
                        HStack {
                            Label("构建未就绪", systemImage: "clock")
                            Spacer()
                            let incCount = scanner.games.filter { !$0.isReady }.count
                            if incCount > 0 {
                                Text("\(incCount)")
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
                        ProgressView("正在扫描已编译游戏...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if filteredGames.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "square.stack.3d.slash")
                                .font(.system(size: 52))
                                .foregroundColor(.secondary)
                            
                            Text(searchText.isEmpty ? "未找到已编译完成的游戏" : "没有匹配的游戏搜索结果")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            
                            Text("请确认游戏目录中包含 `*_build` 构建文件夹，或点击右上角刷新。")
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
        case "incomplete": return "未就绪游戏"
        case "settings": return "设置与路径"
        default: return "NXNative 游戏库"
        }
    }
}
