import Foundation
import SwiftUI
import AppKit

// MARK: - Game Metadata Database
public struct GameMeta {
    public let cnName: String
    public let enName: String
}

public let knownGames: [String: GameMeta] = [
    "0100000000010000": GameMeta(cnName: "超级马里奥：奥德赛", enName: "Super Mario Odyssey"),
    "010005501E68C000": GameMeta(cnName: "逆转裁判：御剑怜侍合集", enName: "Ace Attorney Investigations Collection"),
    "010013C00E930000": GameMeta(cnName: "空洞骑士：丝之歌", enName: "Hollow Knight: Silksong"),
    "010014E00DB56000": GameMeta(cnName: "数码宝贝物语：网路侦探 完整版", enName: "Digimon Story Cyber Sleuth: Complete Edition"),
    "010015100B514000": GameMeta(cnName: "超级马里奥兄弟：惊奇", enName: "Super Mario Bros. Wonder"),
    "0100152000022000": GameMeta(cnName: "马里奥赛车 8 豪华版", enName: "Mario Kart 8 Deluxe"),
    "010020400E1C2000": GameMeta(cnName: "人狼村之谜", enName: "Raging Loop"),
    "010020D01AD24000": GameMeta(cnName: "动物井", enName: "ANIMAL WELL"),
    "010028600EBDA000": GameMeta(cnName: "超级马里奥 3D 世界 + 狂怒世界", enName: "Super Mario 3D World + Bowser's Fury"),
    "010029B018432000": GameMeta(cnName: "幽灵诡计：幻影侦探", enName: "Ghost Trick: Phantom Detective"),
    "01002B00111A2000": GameMeta(cnName: "塞尔达无双：灾厄启示录", enName: "Hyrule Warriors: Age of Calamity"),
    "01002B30028F6000": GameMeta(cnName: "蔚蓝", enName: "Celeste"),
    "010036E00FB20000": GameMeta(cnName: "大逆转裁判编年史", enName: "The Great Ace Attorney Chronicles"),
    "010038B015560000": GameMeta(cnName: "最终幻想战略版：伊瓦利斯纪事", enName: "FINAL FANTASY TACTICS - The Ivalice Chronicles"),
    "01003FC01670C000": GameMeta(cnName: "十三机兵防卫圈", enName: "13 Sentinels: Aegis Rim"),
    "01004AB00A260000": GameMeta(cnName: "黑暗之魂：重制版", enName: "DARK SOULS: REMASTERED"),
    "0100505021440000": GameMeta(cnName: "勇者斗恶龙 VII 重制版", enName: "DRAGON QUEST VII Reimagined"),
    "010051701FB46000": GameMeta(cnName: "怪物火车 2", enName: "Monster Train 2"),
    "01005270232F2000": GameMeta(cnName: "八方旅人 0", enName: "OCTOPATH TRAVELER 0"),
    "0100535012974000": GameMeta(cnName: "黑帝斯", enName: "Hades"),
    "010055D009F78000": GameMeta(cnName: "火焰纹章：风花雪月", enName: "Fire Emblem: Three Houses"),
    "0100606026F12000": GameMeta(cnName: "最终幻想：共鸣", enName: "FINAL FANTASY RESONANCE"),
    "0100620012D6E000": GameMeta(cnName: "灵活脑学校：一起伸展大脑", enName: "Big Brain Academy: Brain vs. Brain"),
    "010069401ADB8000": GameMeta(cnName: "圣兽之王", enName: "Unicorn Overlord"),
    "01006BB00C6F0000": GameMeta(cnName: "塞尔达传说：织梦岛", enName: "The Legend of Zelda: Link's Awakening"),
    "01006C300E9F0000": GameMeta(cnName: "勇者斗恶龙 XI S：寻觅逝去的时光", enName: "DRAGON QUEST XI S"),
    "01006F8002326000": GameMeta(cnName: "集合啦！动物森友会", enName: "Animal Crossing: New Horizons"),
    "0100713016CCC000": GameMeta(cnName: "AI: 梦境档案 涅槃肇始", enName: "AI: THE SOMNIUM FILES - nirvanA Initiative"),
    "01007EF00011E000": GameMeta(cnName: "塞尔达传说：旷野之息", enName: "The Legend of Zelda: Breath of the Wild"),
    "010089B00D09C000": GameMeta(cnName: "AI: 梦境档案", enName: "AI: THE SOMNIUM FILES"),
    "01008BC024FDE000": GameMeta(cnName: "命运石之门：重构", enName: "STEINS;GATE RE:BOOT"),
    "01008CF01BAAC000": GameMeta(cnName: "塞尔达传说：智慧的再现", enName: "The Legend of Zelda: Echoes of Wisdom"),
    "010093801237C000": GameMeta(cnName: "密特罗德：生存恐惧", enName: "Metroid Dread"),
    "010099C022B96000": GameMeta(cnName: "超级马里奥：银河", enName: "Super Mario Galaxy"),
    "01009BF0072D4000": GameMeta(cnName: "前进！奇诺比奥队长", enName: "Captain Toad: Treasure Tracker"),
    "0100A00019DE0000": GameMeta(cnName: "黑帝斯 2", enName: "Hades II"),
    "0100A3501946E000": GameMeta(cnName: "八方旅人 II", enName: "OCTOPATH TRAVELER II"),
    "0100A5C00D162000": GameMeta(cnName: "茶杯头", enName: "Cuphead"),
    "0100A6301214E000": GameMeta(cnName: "火焰纹章：结合", enName: "Fire Emblem Engage"),
    "0100A83022A22000": GameMeta(cnName: "Absolum", enName: "Absolum"),
    "0100A9D01C446000": GameMeta(cnName: "勇者斗恶龙 VII 重制版", enName: "DRAGON QUEST VII Reimagined"),
    "0100B04011742000": GameMeta(cnName: "怪物猎人：崛起", enName: "Monster Hunter Rise"),
    "0100BF00112C0000": GameMeta(cnName: "凯瑟琳：玉体横陈", enName: "Catherine: Full Body"),
    "0100C2A01A730000": GameMeta(cnName: "三国志 8 重制版", enName: "ROMANCE OF THE THREE KINGDOMS 8 REMAKE"),
    "0100C8F00C870000": GameMeta(cnName: "异界锁链", enName: "ASTRAL CHAIN"),
    "0100CD801CE5E000": GameMeta(cnName: "小丑牌", enName: "Balatro"),
    "0100D9F01D474000": GameMeta(cnName: "节奏天国：奇迹之星", enName: "Rhythm Heaven Groove"),
    "0100DCA0064A6000": GameMeta(cnName: "路易吉洋馆 3", enName: "Luigi's Mansion 3"),
    "0100E44016C22000": GameMeta(cnName: "帕特里克的箱子", enName: "Patrick's Parabox"),
    "0100ECD018EBE000": GameMeta(cnName: "纸片马里奥：千年之门", enName: "Paper Mario: The Thousand-Year Door"),
    "0100F2C0115B6000": GameMeta(cnName: "塞尔达传说：王国之泪", enName: "The Legend of Zelda: Tears of the Kingdom"),
    "0100F43008C44000": GameMeta(cnName: "宝可梦传说：Z-A", enName: "Pokémon Legends: Z-A"),
    "0100F5D01DA3A000": GameMeta(cnName: "脑力记忆学院", enName: "Brain Memory Training Academy"),
    "0100FD8022DAA000": GameMeta(cnName: "超级马里奥：银河 2", enName: "Super Mario Galaxy 2")
]

// MARK: - Game Item Model
public class GameItem: Identifiable, ObservableObject {
    public let id: String // Title ID
    public let title: String
    public let englishTitle: String
    public let version: String
    public let parentFolder: String
    
    // Paths
    @Published public var appURL: URL?       // <GameName>.app bundle
    @Published public var buildURL: URL?     // <id>_build directory if present
    public let iconURL: URL?
    
    // Status
    public var isAppReady: Bool {
        guard let app = appURL else { return false }
        let exe = app.appendingPathComponent("Contents/MacOS/nxnative")
        let host = app.appendingPathComponent("Contents/MacOS/dmhost")
        let fm = FileManager.default
        return fm.isExecutableFile(atPath: exe.path) && fm.isExecutableFile(atPath: host.path)
    }
    
    public var isPackable: Bool {
        guard appURL == nil, let b = buildURL else { return false }
        let fm = FileManager.default
        let host = b.appendingPathComponent("tools/dmhost")
        return fm.isExecutableFile(atPath: host.path)
    }
    
    @Published public var isRunning: Bool = false
    @Published public var processPID: Int32? = nil
    @Published public var logs: [String] = []
    @Published public var lastStatus: String = "未运行"
    @Published public var isPacking: Bool = false
    @Published public var packProgress: String = ""
    
    public var runningApp: NSRunningApplication? = nil
    
    // Official standard directories
    public var officialSaveURL: URL {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return home.appendingPathComponent("Library/Application Support/nxnative/\(id)/save")
    }
    
    public var officialTempURL: URL {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return home.appendingPathComponent("Library/Application Support/nxnative/\(id)/temp")
    }
    
    public var officialLogURL: URL {
        let home = FileManager.default.homeDirectoryForCurrentUser
        return home.appendingPathComponent("Library/Logs/nxnative/\(id).log")
    }
    
    public var legacySaveURL: URL? {
        guard let b = buildURL else { return nil }
        let legacy = b.appendingPathComponent("run/save")
        if FileManager.default.fileExists(atPath: legacy.path) {
            return legacy
        }
        return nil
    }
    
    public init(
        id: String,
        title: String,
        englishTitle: String,
        version: String,
        parentFolder: String,
        appURL: URL?,
        buildURL: URL?,
        iconURL: URL?
    ) {
        self.id = id
        self.title = title
        self.englishTitle = englishTitle
        self.version = version
        self.parentFolder = parentFolder
        self.appURL = appURL
        self.buildURL = buildURL
        self.iconURL = iconURL
    }
    
    public func appendLog(_ text: String) {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        logs.append(contentsOf: lines)
        if logs.count > 1500 {
            logs.removeFirst(logs.count - 1500)
        }
    }
    
    public func reloadLogsFromDisk() {
        let path = officialLogURL.path
        guard let content = try? String(contentsOfFile: path, encoding: .utf8) else { return }
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        DispatchQueue.main.async {
            self.logs = lines
        }
    }
    
    public func clearLogs() {
        logs.removeAll()
        try? "".write(to: officialLogURL, atomically: true, encoding: .utf8)
    }
    
    public func migrateLegacySaveIfNeeded() {
        guard let legacy = legacySaveURL else { return }
        let official = officialSaveURL
        let fm = FileManager.default
        try? fm.createDirectory(at: official, withIntermediateDirectories: true)
        
        guard let items = try? fm.contentsOfDirectory(at: legacy, includingPropertiesForKeys: nil) else { return }
        for item in items {
            let target = official.appendingPathComponent(item.lastPathComponent)
            if !fm.fileExists(atPath: target.path) {
                try? fm.copyItem(at: item, to: target)
            }
        }
    }
}

// MARK: - App Settings
public class AppSettings: ObservableObject {
    @Published public var gamesDirectory: String {
        didSet { UserDefaults.standard.set(gamesDirectory, forKey: "gamesDirectory") }
    }
    @Published public var repoDirectory: String {
        didSet { UserDefaults.standard.set(repoDirectory, forKey: "repoDirectory") }
    }
    @Published public var language: String {
        didSet { UserDefaults.standard.set(language, forKey: "language") }
    }
    @Published public var windowedMode: Bool {
        didSet { UserDefaults.standard.set(windowedMode, forKey: "windowedMode") }
    }
    @Published public var enableAudio: Bool {
        didSet { UserDefaults.standard.set(enableAudio, forKey: "enableAudio") }
    }
    @Published public var showFPS: Bool {
        didSet { UserDefaults.standard.set(showFPS, forKey: "showFPS") }
    }
    
    public init() {
        let defaultGames = "/Users/luyang_dev/ns_emulator/games"
        let defaultRepo = "/Users/luyang_dev/workspace/code/third-party/nxnative"
        
        self.gamesDirectory = UserDefaults.standard.string(forKey: "gamesDirectory") ?? defaultGames
        self.repoDirectory = UserDefaults.standard.string(forKey: "repoDirectory") ?? defaultRepo
        self.language = UserDefaults.standard.string(forKey: "language") ?? "zh-Hans"
        self.windowedMode = UserDefaults.standard.object(forKey: "windowedMode") as? Bool ?? true
        self.enableAudio = UserDefaults.standard.object(forKey: "enableAudio") as? Bool ?? true
        self.showFPS = UserDefaults.standard.object(forKey: "showFPS") as? Bool ?? true
    }
    
    /// Syncs user settings to standard ~/Library/Application Support/nxnative/<TitleID>/env.txt
    public func syncEnvFile(titleId: String) {
        let home = FileManager.default.homeDirectoryForCurrentUser
        let sup = home.appendingPathComponent("Library/Application Support/nxnative/\(titleId)")
        let envFile = sup.appendingPathComponent("env.txt")
        let fm = FileManager.default
        try? fm.createDirectory(at: sup, withIntermediateDirectories: true)
        
        var lines: [String] = []
        lines.append("# nxnative launcher user settings")
        lines.append("DM_LANG=\(language)")
        lines.append("DM_WINDOW=\(windowedMode ? "1" : "0")")
        lines.append("DM_AUDIO=\(enableAudio ? "1" : "0")")
        lines.append("DM_SHOW_FPS=\(showFPS ? "1" : "0")")
        
        let content = lines.joined(separator: "\n") + "\n"
        try? content.write(to: envFile, atomically: true, encoding: .utf8)
    }
}

// MARK: - Game Scanner
public class GameScanner: ObservableObject {
    @Published public var games: [GameItem] = []
    @Published public var isScanning: Bool = false
    
    public init() {}
    
    public func scan(gamesPath: String, repoPath: String) {
        isScanning = true
        DispatchQueue.global(qos: .userInitiated).async {
            let root = URL(fileURLWithPath: gamesPath)
            let fm = FileManager.default
            
            var discovered: [String: GameItem] = [:] // Keyed by Title ID
            
            // 1. First scan for .app bundles in games root and immediate subfolders
            var appURLs: [URL] = []
            if let topEntries = try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
                for item in topEntries {
                    if item.pathExtension.lowercased() == "app" {
                        appURLs.append(item)
                    } else if (try? item.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true {
                        // Subdirectory: look for .app inside
                        if let subEntries = try? fm.contentsOfDirectory(at: item, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) {
                            for sub in subEntries where sub.pathExtension.lowercased() == "app" {
                                appURLs.append(sub)
                            }
                        }
                    }
                }
            }
            
            // Check /Applications as well for standalone packed games
            let appsDir = URL(fileURLWithPath: "/Applications")
            if let sysApps = try? fm.contentsOfDirectory(at: appsDir, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) {
                for sa in sysApps where sa.pathExtension.lowercased() == "app" {
                    let infoPlist = sa.appendingPathComponent("Contents/Info.plist")
                    if let dict = NSDictionary(contentsOf: infoPlist), dict["DMTitleID"] != nil {
                        appURLs.append(sa)
                    }
                }
            }
            
            for app in appURLs {
                let infoPlist = app.appendingPathComponent("Contents/Info.plist")
                guard let dict = NSDictionary(contentsOf: infoPlist) else { continue }
                guard let rawTitleId = dict["DMTitleID"] as? String, !rawTitleId.isEmpty else { continue }
                let titleId = rawTitleId.uppercased()
                
                let appName = (dict["CFBundleDisplayName"] as? String) ?? (dict["CFBundleName"] as? String) ?? app.deletingPathExtension().lastPathComponent
                let version = (dict["CFBundleShortVersionString"] as? String) ?? "1.0"
                
                var cnTitle = appName
                var enTitle = appName
                if let meta = knownGames[titleId] {
                    cnTitle = meta.cnName
                    enTitle = meta.enName
                }
                
                let iconCandidate = app.appendingPathComponent("Contents/Resources/AppIcon.icns")
                let iconURL = fm.fileExists(atPath: iconCandidate.path) ? iconCandidate : nil
                
                let parentFolder = app.deletingLastPathComponent().lastPathComponent
                
                let item = GameItem(
                    id: titleId,
                    title: cnTitle,
                    englishTitle: enTitle,
                    version: version,
                    parentFolder: parentFolder,
                    appURL: app,
                    buildURL: nil,
                    iconURL: iconURL
                )
                discovered[titleId] = item
            }
            
            // 2. Scan for _build folders in gamesDirectory
            if let topEntries = try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
                for folder in topEntries {
                    guard (try? folder.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true else { continue }
                    
                    var buildDirs: [URL] = []
                    if folder.lastPathComponent.hasSuffix("_build") {
                        buildDirs.append(folder)
                    } else if let inner = try? fm.contentsOfDirectory(at: folder, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
                        for sub in inner where sub.lastPathComponent.hasSuffix("_build") {
                            buildDirs.append(sub)
                        }
                    }
                    
                    for bURL in buildDirs {
                        let folderName = bURL.lastPathComponent
                        let titleId = folderName.replacingOccurrences(of: "_build", with: "").uppercased()
                        let parentName = bURL.deletingLastPathComponent().lastPathComponent
                        
                        // If already discovered as .app, just associate the buildURL
                        if let existing = discovered[titleId] {
                            existing.buildURL = bURL
                            continue
                        }
                        
                        var cnTitle = parentName
                        var enTitle = titleId
                        if let meta = knownGames[titleId] {
                            cnTitle = meta.cnName
                            enTitle = meta.enName
                        }
                        
                        // Extract version from patched_*
                        var versionStr = "1.0"
                        if let entries = try? fm.contentsOfDirectory(at: bURL, includingPropertiesForKeys: nil) {
                            for e in entries where e.lastPathComponent.hasPrefix("patched_") && !e.lastPathComponent.hasSuffix(".key") {
                                versionStr = e.lastPathComponent.replacingOccurrences(of: "patched_", with: "")
                                break
                            }
                        }
                        
                        // Extract icon from extract/<version>/icon.jpg
                        var iconURL: URL? = nil
                        let extractURL = bURL.appendingPathComponent("extract")
                        if let extractDirs = try? fm.contentsOfDirectory(at: extractURL, includingPropertiesForKeys: nil) {
                            for ed in extractDirs {
                                let possibleIcon = ed.appendingPathComponent("icon.jpg")
                                if fm.fileExists(atPath: possibleIcon.path) {
                                    iconURL = possibleIcon
                                    break
                                }
                            }
                        }
                        
                        let item = GameItem(
                            id: titleId,
                            title: cnTitle,
                            englishTitle: enTitle,
                            version: versionStr,
                            parentFolder: parentName,
                            appURL: nil,
                            buildURL: bURL,
                            iconURL: iconURL
                        )
                        discovered[titleId] = item
                    }
                }
            }
            
            var sorted = Array(discovered.values)
            sorted.sort {
                if $0.isAppReady != $1.isAppReady {
                    return $0.isAppReady && !$1.isAppReady
                }
                return $0.title < $1.title
            }
            
            DispatchQueue.main.async {
                self.games = sorted
                self.isScanning = false
            }
        }
    }
}

// MARK: - Game Launcher Runner
public class GameLauncher: ObservableObject {
    public static let shared = GameLauncher()
    
    public func launch(game: GameItem, settings: AppSettings) {
        guard !game.isRunning else { return }
        
        // 1. Sync user preferences to ~/Library/Application Support/nxnative/<id>/env.txt
        settings.syncEnvFile(titleId: game.id)
        
        // 2. Ensure directories exist
        let fm = FileManager.default
        try? fm.createDirectory(at: game.officialSaveURL, withIntermediateDirectories: true)
        try? fm.createDirectory(at: game.officialTempURL, withIntermediateDirectories: true)
        
        // 3. Migrate legacy save if exists
        game.migrateLegacySaveIfNeeded()
        
        // 4. Launch official Mac App
        guard let appURL = game.appURL else {
            game.lastStatus = "尚未打包为 Mac App，请先点击打包"
            return
        }
        
        let config = NSWorkspace.OpenConfiguration()
        config.activates = true
        config.environment = [
            "DM_LANG": settings.language,
            "DM_WINDOW": settings.windowedMode ? "1" : "0",
            "DM_AUDIO": settings.enableAudio ? "1" : "0",
            "DM_SHOW_FPS": settings.showFPS ? "1" : "0"
        ]
        
        game.appendLog("==========================================")
        game.appendLog(" 正在直接拉起游戏应用《\(game.title)》...")
        game.appendLog(" App 路径: \(appURL.path)")
        game.appendLog(" 存档路径: \(game.officialSaveURL.path)")
        game.appendLog(" 日志路径: \(game.officialLogURL.path)")
        game.appendLog(" 语言: \(settings.language) | 帧率显示: \(settings.showFPS ? "开" : "关")")
        game.appendLog("==========================================\n")
        
        NSWorkspace.shared.openApplication(at: appURL, configuration: config) { [weak game] (app, error) in
            DispatchQueue.main.async {
                if let error = error {
                    game?.lastStatus = "启动失败: \(error.localizedDescription)"
                    game?.appendLog("[系统错误] 无法拉起 App: \(error.localizedDescription)\n")
                    return
                }
                
                guard let app = app else { return }
                game?.runningApp = app
                game?.isRunning = true
                game?.processPID = app.processIdentifier
                game?.lastStatus = "运行中 (PID: \(app.processIdentifier))"
                game?.appendLog("[系统] 游戏进程已建立，PID: \(app.processIdentifier)\n")
                
                // Monitor app termination
                NotificationCenter.default.addObserver(
                    forName: NSWorkspace.didTerminateApplicationNotification,
                    object: app,
                    queue: .main
                ) { _ in
                    game?.isRunning = false
                    game?.processPID = nil
                    game?.runningApp = nil
                    game?.lastStatus = "已退出"
                    game?.appendLog("[系统] 游戏应用已退出。\n")
                    game?.reloadLogsFromDisk()
                }
            }
        }
    }
    
    public func stop(game: GameItem) {
        guard game.isRunning, let app = game.runningApp else { return }
        game.appendLog("\n[系统] 发送终止信号 (SIGTERM) 给游戏应用...\n")
        app.terminate()
        
        // Timeout check for force termination
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak game] in
            if game?.isRunning == true {
                game?.appendLog("[系统] 游戏未响应，正在强制结束进程...\n")
                game?.runningApp?.forceTerminate()
            }
        }
    }
}

// MARK: - Game Packager (Pack _build into official .app)
public class GamePacker: ObservableObject {
    public static let shared = GamePacker()
    
    public func pack(game: GameItem, settings: AppSettings, completion: @escaping (Bool) -> Void) {
        guard let bURL = game.buildURL else {
            completion(false)
            return
        }
        
        let fm = FileManager.default
        let parentDir = bURL.deletingLastPathComponent()
        let appName = (game.englishTitle.isEmpty ? game.title : game.englishTitle)
            .replacingOccurrences(of: ":", with: " - ")
            .replacingOccurrences(of: "/", with: " - ")
        let outAppURL = parentDir.appendingPathComponent("\(appName).app")
        
        let hostURL = bURL.appendingPathComponent("tools/dmhost")
        guard fm.fileExists(atPath: hostURL.path) else {
            game.packProgress = "错误：找不到宿主程序 \(hostURL.path)"
            completion(false)
            return
        }
        
        // Find patched_*
        var patchedURL: URL? = nil
        var versionStr = "1.0"
        if let entries = try? fm.contentsOfDirectory(at: bURL, includingPropertiesForKeys: nil) {
            for e in entries where e.lastPathComponent.hasPrefix("patched_") && !e.lastPathComponent.hasSuffix(".key") {
                patchedURL = e
                versionStr = e.lastPathComponent.replacingOccurrences(of: "patched_", with: "")
                break
            }
        }
        guard let patched = patchedURL else {
            game.packProgress = "错误：找不到 patched 目录"
            completion(false)
            return
        }
        
        // Find RomFS
        var romfsURL: URL? = nil
        var iconURL: URL? = nil
        let extractURL = bURL.appendingPathComponent("extract")
        if let extractDirs = try? fm.contentsOfDirectory(at: extractURL, includingPropertiesForKeys: nil) {
            for ed in extractDirs {
                let possibleRomFS = ed.appendingPathComponent("RomFS")
                if fm.fileExists(atPath: possibleRomFS.path) { romfsURL = possibleRomFS }
                let possibleIcon = ed.appendingPathComponent("icon.jpg")
                if fm.fileExists(atPath: possibleIcon.path) { iconURL = possibleIcon }
            }
        }
        guard let romfs = romfsURL else {
            game.packProgress = "错误：找不到 RomFS 目录"
            completion(false)
            return
        }
        
        // Find MSL shader cache
        var mslURL: URL? = nil
        let cacheURL = bURL.appendingPathComponent("shader/cache")
        if let entries = try? fm.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil) {
            for e in entries where e.lastPathComponent.hasPrefix("b-") {
                mslURL = e
                break
            }
        }
        if mslURL == nil {
            let vkURL = bURL.appendingPathComponent("shader/vk")
            if fm.fileExists(atPath: vkURL.path) { mslURL = vkURL }
        }
        guard let msl = mslURL else {
            game.packProgress = "错误：找不到编译好的着色器库 (shader/cache/b-*)"
            completion(false)
            return
        }
        
        // Tables
        let repoTables = URL(fileURLWithPath: settings.repoDirectory).appendingPathComponent("dm/games/\(game.id)")
        let localTables = bURL.appendingPathComponent("profile/\(game.id)")
        let tablesURL = fm.fileExists(atPath: repoTables.path) ? repoTables : localTables
        
        // Font
        let fontURL = bURL.appendingPathComponent("font")
        
        // Pack app script
        let packScript = URL(fileURLWithPath: settings.repoDirectory).appendingPathComponent("dm/mac/pack_app.py")
        guard fm.fileExists(atPath: packScript.path) else {
            game.packProgress = "错误：找不到 pack_app.py 脚本"
            completion(false)
            return
        }
        
        game.isPacking = true
        game.packProgress = "正在打包为独立 Mac App..."
        
        DispatchQueue.global(qos: .userInitiated).async {
            var args = [
                packScript.path,
                outAppURL.path,
                "--host", hostURL.path,
                "--patched", patched.path,
                "--romfs", romfs.path,
                "--msl", msl.path,
                "--tables", tablesURL.path,
                "--font", fontURL.path,
                "--title-id", game.id,
                "--name", game.englishTitle.isEmpty ? game.title : game.englishTitle,
                "--version", versionStr
            ]
            
            if let icon = iconURL {
                args += ["--icon", icon.path]
            }
            
            let proc = Process()
            proc.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
            proc.arguments = args
            
            let pipe = Pipe()
            proc.standardOutput = pipe
            proc.standardError = pipe
            
            let handle = pipe.fileHandleForReading
            handle.readabilityHandler = { fh in
                let d = fh.availableData
                guard d.count > 0, let str = String(data: d, encoding: .utf8) else { return }
                DispatchQueue.main.async {
                    let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty {
                        game.packProgress = trimmed
                        game.appendLog("[打包] \(trimmed)\n")
                    }
                }
            }
            
            do {
                try proc.run()
                proc.waitUntilExit()
                
                DispatchQueue.main.async {
                    game.isPacking = false
                    if proc.terminationStatus == 0 && fm.fileExists(atPath: outAppURL.path) {
                        game.appURL = outAppURL
                        game.packProgress = "打包成功！"
                        game.appendLog("✅ 打包成功: \(outAppURL.path)\n")
                        completion(true)
                    } else {
                        game.packProgress = "打包失败 (代码: \(proc.terminationStatus))"
                        game.appendLog("❌ 打包失败，退出代码: \(proc.terminationStatus)\n")
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    game.isPacking = false
                    game.packProgress = "打包出错: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
