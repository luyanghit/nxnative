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
    "010093801237C000": GameMeta(cnName: "密特罗德：生存恐惧", enName: "Metroid Dread"),
    "010099C022B96000": GameMeta(cnName: "超级马里奥：银河", enName: "Super Mario Galaxy"),
    "01009BF0072D4000": GameMeta(cnName: "前进！奇诺比奥队长", enName: "Captain Toad: Treasure Tracker"),
    "0100A00019DE0000": GameMeta(cnName: "黑帝斯 2", enName: "Hades II"),
    "0100A5C00D162000": GameMeta(cnName: "茶杯头", enName: "Cuphead"),
    "0100A6301214E000": GameMeta(cnName: "火焰纹章：结合", enName: "Fire Emblem Engage"),
    "0100A83022A22000": GameMeta(cnName: "Absolum", enName: "Absolum"),
    "0100A9D01C446000": GameMeta(cnName: "勇者斗恶龙 VII 重制版", enName: "DRAGON QUEST VII Reimagined"),
    "0100B04011742000": GameMeta(cnName: "怪物猎人：崛起", enName: "Monster Hunter Rise"),
    "0100BF00112C0000": GameMeta(cnName: "凯瑟琳：玉体横陈", enName: "Catherine: Full Body"),
    "0100C2A01A730000": GameMeta(cnName: "三国志 8 重制版", enName: "ROMANCE OF THE THREE KINGDOMS 8 REMAKE"),
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
    public let buildURL: URL
    public let parentFolder: String
    public let patchedURL: URL?
    public let romfsURL: URL?
    public let iconURL: URL?
    public let dmhostURL: URL?
    public let aocURL: URL?
    public let fontURL: URL?
    public let shaderCacheURL: URL?
    public let shaderMapURL: URL?
    public let isReady: Bool
    
    @Published public var isRunning: Bool = false
    @Published public var processPID: Int32? = nil
    @Published public var logs: [String] = []
    @Published public var lastStatus: String = "未运行"
    
    public var runningProcess: Process? = nil
    
    public init(
        id: String,
        title: String,
        englishTitle: String,
        version: String,
        buildURL: URL,
        parentFolder: String,
        patchedURL: URL?,
        romfsURL: URL?,
        iconURL: URL?,
        dmhostURL: URL?,
        aocURL: URL?,
        fontURL: URL?,
        shaderCacheURL: URL?,
        shaderMapURL: URL?,
        isReady: Bool
    ) {
        self.id = id
        self.title = title
        self.englishTitle = englishTitle
        self.version = version
        self.buildURL = buildURL
        self.parentFolder = parentFolder
        self.patchedURL = patchedURL
        self.romfsURL = romfsURL
        self.iconURL = iconURL
        self.dmhostURL = dmhostURL
        self.aocURL = aocURL
        self.fontURL = fontURL
        self.shaderCacheURL = shaderCacheURL
        self.shaderMapURL = shaderMapURL
        self.isReady = isReady
    }
    
    public func appendLog(_ text: String) {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        logs.append(contentsOf: lines)
        if logs.count > 1000 {
            logs.removeFirst(logs.count - 1000)
        }
    }
    
    public func clearLogs() {
        logs.removeAll()
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
            let repoURL = URL(fileURLWithPath: repoPath)
            let fm = FileManager.default
            
            var discovered: [GameItem] = []
            
            guard let subdirs = try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) else {
                DispatchQueue.main.async {
                    self.games = []
                    self.isScanning = false
                }
                return
            }
            
            for folder in subdirs {
                var isDir: ObjCBool = false
                guard fm.fileExists(atPath: folder.path, isDirectory: &isDir), isDir.boolValue else { continue }
                
                // Check if folder itself is a _build directory, or contains a _build subdirectory
                var buildDirs: [URL] = []
                if folder.lastPathComponent.hasSuffix("_build") {
                    buildDirs.append(folder)
                } else if let inner = try? fm.contentsOfDirectory(at: folder, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
                    for sub in inner {
                        if sub.lastPathComponent.hasSuffix("_build") {
                            buildDirs.append(sub)
                        }
                    }
                }
                
                for bURL in buildDirs {
                    let folderName = bURL.lastPathComponent
                    let titleId = folderName.replacingOccurrences(of: "_build", with: "").uppercased()
                    let parentName = bURL.deletingLastPathComponent().lastPathComponent
                    
                    // Determine Titles
                    var cnTitle = ""
                    var enTitle = ""
                    if let meta = knownGames[titleId] {
                        cnTitle = meta.cnName
                        enTitle = meta.enName
                    } else {
                        // Extract from parent directory name
                        cnTitle = parentName
                        enTitle = titleId
                    }
                    
                    // Find Patched Directory
                    var patchedURL: URL? = nil
                    var versionStr = "v0"
                    if let entries = try? fm.contentsOfDirectory(at: bURL, includingPropertiesForKeys: nil) {
                        for e in entries {
                            if e.lastPathComponent.hasPrefix("patched_") && !e.lastPathComponent.hasSuffix(".key") {
                                patchedURL = e
                                versionStr = e.lastPathComponent.replacingOccurrences(of: "patched_", with: "")
                                break
                            }
                        }
                    }
                    
                    // Find RomFS & Icon in extract/<version>/
                    var romfsURL: URL? = nil
                    var iconURL: URL? = nil
                    let extractURL = bURL.appendingPathComponent("extract")
                    if let extractDirs = try? fm.contentsOfDirectory(at: extractURL, includingPropertiesForKeys: nil) {
                        for ed in extractDirs {
                            let possibleRomFS = ed.appendingPathComponent("RomFS")
                            if fm.fileExists(atPath: possibleRomFS.path) {
                                romfsURL = possibleRomFS
                            }
                            let possibleIcon = ed.appendingPathComponent("icon.jpg")
                            if fm.fileExists(atPath: possibleIcon.path) {
                                iconURL = possibleIcon
                            }
                        }
                    }
                    
                    // Fallback icon search
                    if iconURL == nil {
                        if let subFiles = fm.enumerator(at: bURL, includingPropertiesForKeys: nil) {
                            for case let f as URL in subFiles {
                                if f.pathExtension.lowercased() == "jpg" || f.lastPathComponent.contains("AppIcon60x60@2x.png") {
                                    iconURL = f
                                    break
                                }
                            }
                        }
                    }
                    
                    // Find dmhost: Prefer $W/tools/dmhost, fallback to repo
                    var dmhostURL: URL? = nil
                    let toolsDmHost = bURL.appendingPathComponent("tools/dmhost")
                    let repoDmHost = repoURL.appendingPathComponent("dm/host/dmhost")
                    if fm.fileExists(atPath: toolsDmHost.path) && fm.isExecutableFile(atPath: toolsDmHost.path) {
                        dmhostURL = toolsDmHost
                    } else if fm.fileExists(atPath: repoDmHost.path) && fm.isExecutableFile(atPath: repoDmHost.path) {
                        dmhostURL = repoDmHost
                    }
                    
                    // AOC
                    var aocURL: URL? = nil
                    let aocCandidate = bURL.appendingPathComponent("aoc")
                    if fm.fileExists(atPath: aocCandidate.path) {
                        aocURL = aocCandidate
                    }
                    
                    // Font & Shader Cache
                    let fontCandidate = bURL.appendingPathComponent("font")
                    let fontURL = fm.fileExists(atPath: fontCandidate.path) ? fontCandidate : nil
                    
                    let shaderCandidate = bURL.appendingPathComponent("shader/cache")
                    let shaderCacheURL = fm.fileExists(atPath: shaderCandidate.path) ? shaderCandidate : nil
                    
                    // Shader Map
                    var shaderMapURL: URL? = nil
                    let localShMap = bURL.appendingPathComponent("profile/\(titleId)/shader_map.tsv")
                    let repoShMap = repoURL.appendingPathComponent("dm/games/\(titleId)/shader_map.tsv")
                    if fm.fileExists(atPath: localShMap.path) {
                        shaderMapURL = localShMap
                    } else if fm.fileExists(atPath: repoShMap.path) {
                        shaderMapURL = repoShMap
                    }
                    
                    let isReady = (patchedURL != nil && romfsURL != nil && dmhostURL != nil)
                    
                    let item = GameItem(
                        id: titleId,
                        title: cnTitle,
                        englishTitle: enTitle,
                        version: versionStr,
                        buildURL: bURL,
                        parentFolder: parentName,
                        patchedURL: patchedURL,
                        romfsURL: romfsURL,
                        iconURL: iconURL,
                        dmhostURL: dmhostURL,
                        aocURL: aocURL,
                        fontURL: fontURL,
                        shaderCacheURL: shaderCacheURL,
                        shaderMapURL: shaderMapURL,
                        isReady: isReady
                    )
                    
                    discovered.append(item)
                }
            }
            
            discovered.sort { $0.title < $1.title }
            
            DispatchQueue.main.async {
                self.games = discovered
                self.isScanning = false
            }
        }
    }
}

// MARK: - Game Launcher Runner
public class GameLauncher: ObservableObject {
    public static let shared = GameLauncher()
    
    public func launch(game: GameItem, settings: AppSettings) {
        guard game.isReady, !game.isRunning else { return }
        guard let host = game.dmhostURL, let patched = game.patchedURL else {
            game.lastStatus = "错误：缺少可执行文件或补丁模块"
            return
        }
        
        let runDir = game.buildURL.appendingPathComponent("run")
        let saveDir = runDir.appendingPathComponent("save")
        let tempDir = runDir.appendingPathComponent("temp")
        
        try? FileManager.default.createDirectory(at: saveDir, withIntermediateDirectories: true)
        try? FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
        
        let proc = Process()
        proc.executableURL = host
        proc.arguments = [patched.path]
        proc.currentDirectoryURL = runDir
        
        var env = ProcessInfo.processInfo.environment
        env["DM_WINDOW"] = settings.windowedMode ? "1" : "0"
        env["DM_AUDIO"] = settings.enableAudio ? "1" : "0"
        env["DM_LANG"] = settings.language
        env["DM_SHOW_FPS"] = settings.showFPS ? "1" : "0"
        env["DM_ROOT"] = game.buildURL.path
        if let romfs = game.romfsURL { env["DM_ROMFS"] = romfs.path }
        env["DM_SAVE"] = saveDir.path
        env["DM_TEMP"] = tempDir.path
        if let sc = game.shaderCacheURL { env["DM_MSL_DIR"] = sc.path }
        if let f = game.fontURL { env["DM_FONT_DIR"] = f.path }
        if let sm = game.shaderMapURL { env["DM_NVN_SHMAP"] = sm.path }
        if let aoc = game.aocURL { env["DM_AOC_DIR"] = aoc.path }
        proc.environment = env
        
        let pipe = Pipe()
        proc.standardOutput = pipe
        proc.standardError = pipe
        
        game.clearLogs()
        game.appendLog("==========================================")
        game.appendLog(" 正在启动《\(game.title)》...")
        game.appendLog(" 宿主程序: \(host.path)")
        game.appendLog(" 目标模块: \(patched.path)")
        game.appendLog(" 语言: \(settings.language)")
        game.appendLog("==========================================\n")
        
        let handle = pipe.fileHandleForReading
        handle.readabilityHandler = { [weak game] fh in
            let data = fh.availableData
            guard data.count > 0, let str = String(data: data, encoding: .utf8) else { return }
            DispatchQueue.main.async {
                game?.appendLog(str)
            }
        }
        
        proc.terminationHandler = { [weak game] p in
            DispatchQueue.main.async {
                game?.isRunning = false
                game?.processPID = nil
                game?.runningProcess = nil
                let code = p.terminationStatus
                if code == 0 {
                    game?.lastStatus = "已正常退出"
                    game?.appendLog("\n[系统] 游戏进程已正常退出 (0)\n")
                } else {
                    game?.lastStatus = "已异常退出 (代码: \(code))"
                    game?.appendLog("\n[系统] 游戏异常退出，退出代码: \(code)\n")
                }
            }
        }
        
        do {
            try proc.run()
            game.runningProcess = proc
            game.isRunning = true
            game.processPID = proc.processIdentifier
            game.lastStatus = "运行中 (PID: \(proc.processIdentifier))"
        } catch {
            game.lastStatus = "启动失败: \(error.localizedDescription)"
            game.appendLog("[系统错误] 启动进程失败: \(error.localizedDescription)\n")
        }
    }
    
    public func stop(game: GameItem) {
        guard game.isRunning, let proc = game.runningProcess else { return }
        game.appendLog("\n[系统] 用户请求终止游戏进程 (PID: \(proc.processIdentifier))...\n")
        proc.terminate()
    }
}
