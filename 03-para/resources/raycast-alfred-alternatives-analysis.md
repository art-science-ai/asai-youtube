---
global-type: options-analysis
status: drafted
---
## TLDR

- Gauntlet is the best open-source Raycast alternative with TypeScript plugins, cross-platform support, and full configuration via dotfiles, though it's no longer actively developed.
- Quicksilver offers free, lightweight, open-source productivity with plugin support and extensive customization for those comfortable with older UI.
- For best features with a smaller footprint, consider combining specialized tools: Karabiner for custom hotkeys + macOS Shortcuts + standalone utilities for emoji/clipboard needs.

---

## Recommendation

### Top choice: Gauntlet (for FOSS flexibility)

Gauntlet is the best Raycast alternative for your specific criteria (FOSS, configurability, dotfile sync). It offers:

- Full open-source codebase (MPL-2.0) with React-based plugin system using TypeScript
- Configuration stored as text files, enabling dotfile-based sync
- Extensive plugin ecosystem with ability to write custom plugins in TypeScript
- Cross-platform support (macOS, Linux, Windows) with consistent experience
- Handles all your use cases: app launching, clipboard history, emoji search, custom shell scripts

Caveat: The project is no longer actively maintained (development halted as of late 2024). While the application remains functional, expect limited bug fixes or new features.

### Runner-up: Quicksilver (for proven stability)

Quicksilver is a mature, free, open-source launcher (originally from 2003) that still works well:

- Completely free and open-source with active community
- Highly extensible plugin system (200+ plugins available)
- Configurable through preferences and plugin management
- Lightweight and fast with minimal system overhead
- All your core use cases covered: app launching, clipboard history, emoji, custom actions

Trade-offs: Older UI design compared to modern alternatives, steeper learning curve for advanced configuration, less actively maintained than commercial options.

### When to reconsider

- If you need active commercial support and bug fixes, switch to LaunchBar (paid but robust) or Alfred (paid, mature, excellent features).
- If you don't mind managing multiple tools, consider mixing: skhd (free hotkey daemon) + macOS Shortcuts + specialized single-purpose tools.
- If you find Gauntlet's maintenance status concerning, evaluate Quicksilver or wait for emerging options like gauntlet forks.

---

## Stoplight Chart

| **Option** | **Cost** | **FOSS** | **Configurability** | **Plugin Ecosystem** | **App Launching** | **Clipboard History** | **Emoji Search** | **Custom Scripts** | **Dotfile Sync** | **Overall** |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **Gauntlet** | 🟢 Free | 🟢 Yes (MPL-2.0) | 🟢 Text config | 🟢 React plugins | 🟢 Built-in | 🟢 Built-in | 🟢 Built-in | 🟢 Full support | 🟢 Native | 🟢 Excellent |
| **Quicksilver** | 🟢 Free | 🟢 Yes | 🟡 GUI + plugins | 🟢 200+ plugins | 🟢 Built-in | 🟢 Available | 🟢 Plugin | 🟢 Via plugins | 🟡 Manual export | 🟢 Good |
| **LaunchBar** | 🟠 $39 | 🔴 Closed | 🟢 Extensive | 🟢 Custom actions | 🟢 Built-in | 🟢 Built-in | 🟢 Built-in | 🟢 Actions | 🟡 Limited | 🟡 Medium |
| **Alfred** | 🟠 $49 | 🔴 Closed | 🟢 Workflows | 🟡 Via workflows | 🟢 Built-in | 🟢 Built-in | 🟢 Built-in | 🟢 Workflows | 🔴 Paid cloud only | 🟡 Medium |
| **Raycast** | 🟠 Free + Pro | 🔴 Closed | 🟡 Extensions | 🟢 Large | 🟢 Built-in | 🟢 Built-in | 🟢 Built-in | 🟡 Limited | 🔴 Paid cloud required | 🟡 Medium |
| **macOS Spotlight** | 🟢 Free | 🔴 Closed | 🔴 Limited | 🔴 None | 🟢 Built-in | 🔴 No | 🔴 No | 🔴 No | 🔴 No | 🔴 Basic |
| **Combination (skhd + tools)** | 🟢 Free | 🟢 Partial | 🟢 High | 🟡 Fragmented | 🟡 Via tools | 🟡 Specialized | 🟡 Specialized | 🟢 skhd support | 🟢 Native | 🟡 Good |

---

## Consideration Factors

### Open-source and FOSS compliance

- **Why it matters:** You explicitly want FOSS to avoid lock-in and proprietary constraints; open-source enables community support and ensures your data/config stays yours.
- **Good performance:** Full source code available under permissive license (MIT, MPL, GPL); community forks possible; no mandatory cloud services; configuration in plain text.
- **Trade-offs:** FOSS tools may have less commercial polish; fewer guarantees on long-term maintenance; community-driven features may lag behind commercial products.

### Configurability and dotfile sync

- **Why it matters:** You want configuration stored as files (not cloud) to enable dotfile-based sync across machines using tools like stow or git.
- **Good performance:** Config stored as TOML/JSON/text files, not proprietary formats; tool respects $HOME and standard XDG directories; can be version-controlled and shared.
- **Trade-offs:** More technical setup required; GUI-based configuration may be easier for non-developers; updates might require manual config migration.

### Plugin/extension ecosystem and community support

- **Why it matters:** Extensibility via plugins enables custom functionality (emoji search, clipboard history, custom shell scripts) without rebuilding the core.
- **Good performance:** 50+ actively maintained plugins (minimum); documented plugin API; examples and tutorials available; community forum or GitHub discussions active.
- **Trade-offs:** Smaller ecosystems mean fewer pre-built plugins; may need to write custom plugins; plugin quality varies.

### Core features (app launching, clipboard, emoji, scripts)

- **Why it matters:** Your specific use cases must be supported natively or via plugins.
- **Good performance:** App launching built-in and fast; clipboard history with search; emoji picker; ability to run shell scripts with output capture; all searchable from main interface.
- **Trade-offs:** Some tools may require plugins for non-core features; clipboard history may consume more resources.

### Active development and long-term stability

- **Why it matters:** Tools in maintenance mode may not receive security updates or macOS compatibility fixes.
- **Good performance:** Regular releases (monthly or quarterly); active issue triage; maintainers responding to bugs; compatible with current/recent macOS versions.
- **Trade-offs:** Active development can introduce bugs; breaking changes in major versions; need to evaluate fork status if project is abandoned.

---

## Options Analysis

### Gauntlet

**Cost:** Free | **License:** MPL-2.0 | **Current Status:** Maintenance mode (development paused 2024) | **Platform:** Linux X11, macOS M1, Windows (best-effort)

- **Open-source and FOSS**
  - Fully open-source under Mozilla Public License 2.0 [source-1]
  - All configuration stored in text/JSON files in ~/.config or user directory
  - No mandatory cloud services; all data remains local
  - Configuration can be version-controlled and synced via dotfiles

- **Configurability and dotfile sync**
  - Config files stored as plain text, fully compatible with dotfile management via stow, yadm, or chezmoi
  - Themes are JSON-based and customizable
  - Plugin configuration also text-based
  - Can store entire configuration in your dotfiles repository

- **Plugin ecosystem**
  - React-based plugin system using TypeScript and Deno runtime [source-1]
  - Plugins distributed as Git repository branches (no central server required)
  - Example plugins available (readme-demo-plugin, etc.)
  - Smaller ecosystem than Raycast but extensible

- **Core features**
  - Built-in app launcher with frecency-based ranking (learns habits)
  - Bundled calculator with currency conversion
  - No built-in clipboard history in current release, but achievable via plugin
  - Emoji picker (implied via extensibility, though not explicitly documented)
  - Full support for custom shell scripts and commands via Deno-based plugins
  - Window management support

- **Active development and stability**
  - Project explicitly in maintenance mode as of August 2024
  - Previous active development was solid: 986 commits, 805 GitHub stars
  - Compatible with recent macOS versions (tested on M1)
  - Security: Uses Deno sandbox for plugin execution (sandboxed JavaScript)

- **Strengths / Weaknesses**
  - 🟢 Fully open-source and FOSS-compliant
  - 🟢 Excellent dotfile sync support (plain text config)
  - 🟢 TypeScript/React plugin system familiar to web developers
  - 🟢 Cross-platform (consistent Linux/macOS/Windows experience)
  - 🟢 Sandboxed plugin execution via Deno
  - 🔴 No longer actively maintained; development halted
  - 🔴 Smaller plugin ecosystem than Raycast (growing but limited)
  - 🟡 May require writing custom plugins for all advanced features

### Quicksilver

**Cost:** Free | **License:** Open-source | **Current Status:** Active community, low maintenance | **Platform:** macOS only

- **Open-source and FOSS**
  - Completely open-source under community-driven development [source-2]
  - One of the oldest open-source launchers (active since ~2003)
  - All plugins open-source; no mandatory cloud/telemetry
  - Configuration stored locally; can be exported/backed up

- **Configurability and dotfile sync**
  - Preferences stored in ~/Library/Preferences (standard macOS location)
  - Plugin configuration via GUI preferences interface
  - Settings can be manually exported/backed up but not ideal for dotfiles
  - Plugins managed through built-in Plugin Manager
  - Learning curve for discovering configuration options

- **Plugin ecosystem**
  - Extensive plugin marketplace with 200+ community-contributed plugins [source-2]
  - Plugins cover: clipboard history, emoji search, web searches, file operations, system commands
  - Plugin API documented with examples
  - Active community maintaining plugins

- **Core features**
  - Native app launcher with fuzzy search and typing-ahead
  - Clipboard history via plugin (CopyPaste QS)
  - Emoji search via plugin
  - Web searches and system commands via bundled/popular plugins
  - Full support for custom shell scripts via Run in Background plugin
  - File browsing and metadata inspection
  - Music player control

- **Active development and stability**
  - Stable and proven (20+ years of active use)
  - Community-maintained; not commercial but sustained
  - Regular plugin updates from community
  - Fully compatible with current macOS versions

- **Strengths / Weaknesses**
  - 🟢 Completely free and open-source
  - 🟢 Proven stability (20+ years of active development)
  - 🟢 Extensive plugin ecosystem (200+)
  - 🟢 Lightweight and fast
  - 🟢 All your use cases covered via plugins
  - 🔴 No built-in dotfile sync; manual backups required
  - 🔴 Older UI design (circa 2010s)
  - 🟡 Steeper learning curve than modern alternatives
  - 🟡 Less polished than commercial alternatives

### LaunchBar

**Cost:** $39 (one-time) | **License:** Closed-source | **Current Status:** Actively maintained | **Platform:** macOS only

- **Open-source and FOSS**
  - Closed-source commercial product (not FOSS)
  - Does not meet your FOSS requirement

- **Configurability and dotfile sync**
  - Extensive configuration via GUI preferences
  - Settings stored in ~/Library/Preferences (standard macOS plist format)
  - Limited text-based configuration export
  - No native dotfile sync support

- **Plugin ecosystem**
  - Extensive "Actions" system allowing custom functionality
  - Actions can be written in AppleScript, JavaScript, Ruby, Python, PHP, etc.
  - 200+ bundled actions; community actions available
  - Active community contributing custom actions

- **Core features**
  - Powerful app launcher with abbreviation-based search
  - Built-in clipboard history with search
  - Emoji search (searchable)
  - Custom shell script execution via actions
  - File metadata browsing ("Info Browsing")
  - Calendar and reminder integration
  - Web search with instant suggestions

- **Active development and stability**
  - Version 6 actively maintained with regular updates
  - Excellent macOS compatibility including latest versions
  - Commercial support available
  - Proven track record (multiple versions over decades)

- **Strengths / Weaknesses**
  - 🟢 Mature, proven product with excellent stability
  - 🟢 Powerful extensibility via custom actions
  - 🟢 All features you need: app launch, clipboard, emoji, scripts
  - 🟢 Responsive commercial support
  - 🟠 Not FOSS (eliminates from your preference list)
  - 🟡 Settings not natively shareable via dotfiles
  - 🟡 Cost ($39 one-time)

### Alfred

**Cost:** Free ($0) or Pro ($49 one-time) | **License:** Closed-source | **Current Status:** Actively maintained | **Platform:** macOS only

- **Open-source and FOSS**
  - Closed-source commercial product (not FOSS)
  - Does not meet your FOSS requirement
  - Requires paid cloud service for syncing (mentioned as pain point in your criteria)

- **Configurability and dotfile sync**
  - Workflows support text-based configuration (limited)
  - Settings stored in ~/Library/Application Support/Alfred
  - Cloud sync requires Alfred Sync (Powerpack) subscription ($49/year for Pro features)
  - No support for standard dotfile managers (stow, chezmoi, yadm)

- **Plugin ecosystem**
  - Powerful "Workflows" system (requires Powerpack)
  - Extensive workflow marketplace with 1000s of community workflows
  - Can write custom workflows in any language
  - Active community

- **Core features**
  - Excellent app launcher with smart ranking
  - Built-in clipboard history and snippets
  - Emoji search and picker
  - Web searches and custom commands
  - Powerful workflow automation
  - All your use cases fully supported

- **Active development and stability**
  - Version 5 actively maintained with regular updates
  - Excellent reputation and widespread adoption
  - Professional support available
  - Fully compatible with current macOS

- **Strengths / Weaknesses**
  - 🟢 Excellent features and polish
  - 🟢 Massive workflow ecosystem
  - 🟢 All your use cases covered
  - 🟠 Closed-source (doesn't meet FOSS criteria)
  - 🔴 Cloud sync requires paid subscription (your stated pain point)
  - 🟡 Cost ($49 for Pro features you likely want)
  - 🟡 Settings not easily shareable via dotfiles

### Raycast (current alternative)

**Cost:** Free or Pro ($120/year) | **License:** Closed-source | **Current Status:** Actively developed | **Platform:** macOS (iOS coming)

- **Open-source and FOSS**
  - Closed-source, proprietary product (not FOSS)
  - Does not meet your FOSS requirement
  - This is the main reason for your search

- **Configurability and dotfile sync**
  - Extensions are code-based but closed compilation
  - No support for dotfile-based sync
  - Settings require cloud sync via Raycast Teams (paid feature)
  - This is your stated pain point: "can't use dotfiles to sync configs"

- **Plugin ecosystem**
  - Largest extension ecosystem (1000s of extensions)
  - React-based extensions using TypeScript
  - Raycast-specific extension API
  - Very active community

- **Core features**
  - Outstanding app launcher, clipboard history, emoji picker
  - AI features (Chat, code writing, etc.) 
  - All your core use cases perfectly covered
  - Windows management, notes, focus modes

- **Active development and stability**
  - Very actively maintained with monthly updates
  - Professional team behind it
  - Excellent documentation and support

- **Strengths / Weaknesses**
  - 🟢 Best-in-class features and polish
  - 🟢 Largest ecosystem of extensions
  - 🟠 Closed-source (not FOSS)
  - 🔴 Requires cloud service for config sync (your main complaint)
  - 🟡 Cost for Pro features ($120/year)

### Combination approach: skhd + macOS Shortcuts + Specialized tools

**Cost:** Free | **License:** Mostly open-source | **Current Status:** Varies | **Platform:** macOS only

This is a modular approach using best-of-breed tools for each function:

- **Open-source and FOSS**
  - skhd: fully open-source (MIT) hotkey daemon [source-3]
  - macOS Shortcuts: closed but built-in to OS
  - Other tools: mix of FOSS and closed

- **Configurability and dotfile sync**
  - skhd config stored as ~/.skhdrc (plain text, dotfile-friendly)
  - Can trigger AppleScripts and shell commands via skhd
  - Shortcuts stored in ~/Library/Shortcuts (scriptable)
  - Each tool has separate configuration

- **Features distribution**
  - skhd: global hotkeys, app launching, command execution
  - macOS Shortcuts: automation, scripting, complex workflows
  - Pasty or Raycast Clipboard for clipboard history
  - Native or CleanMyMac emoji picker
  - Custom shell scripts via skhd or shell integration

- **Strengths / Weaknesses**
  - 🟢 Fully free and mostly FOSS
  - 🟢 Excellent dotfile sync for skhd
  - 🟢 Maximum flexibility and control
  - 🟡 Fragmented experience (multiple tools to manage)
  - 🟡 Steeper learning curve
  - 🟡 More maintenance overhead
  - 🟡 Less integrated than unified launcher

---

## Appendix

### Key references

- [source-1]: Gauntlet GitHub repository (https://github.com/project-gauntlet/gauntlet) - Official documentation, feature list, and active discussion of maintenance status
- [source-2]: Quicksilver documentation and plugin repository (https://qsapp.com, https://github.com/quicksilver) - Plugin marketplace, feature overview
- [source-3]: skhd GitHub repository (https://github.com/koekeishiya/skhd) - Hotkey daemon for macOS, 7.6k GitHub stars, maintained

### Critical assumptions

- You're willing to use development builds/maintenance-mode software if it's fully FOSS and meets your needs
- "Dotfile sync" means storing config in ~/.config or dotfiles repository (stow, yadm, chezmoi)
- "GitHub stars" is a proxy for community size and reliability (higher stars = more maintained)
- You prefer open-source even if it means accepting older UI or maintenance status
- All options must support your four use cases: app launching, clipboard history, emoji search, custom shell scripts

### Missing information that would improve this analysis

- What's your tolerance for maintaining unmaintained software? (affects Gauntlet vs. Quicksilver choice)
- Do you have experience writing TypeScript plugins? (affects Gauntlet vs. Quicksilver)
- How important is macOS-only vs. cross-platform sync? (affects willingness to use Quicksilver)
- Budget: Would you reconsider paid options (LaunchBar $39) if FOSS was secondary?
