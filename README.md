# 🎮 Hypr-Game-Mode

**The Ultimate TUI Command Center for Arch Linux Gamers & Android Users.**

hypr-game-mode is not just a script; it's a dashboard. It bridges the gap between your mobile device and your high-performance gaming setup, all from a clean, "Omakase" style terminal interface.

*(You can add a screenshot here later)*

## ✨ Features

### 1. 📱 Advanced Android Hub (Scrcpy Wrapper)

Stop remembering complex adb and scrcpy flags.

* **One-Click Mirroring:** Instant USB connection.
* **Wireless Mode:** Guided TCP/IP connection wizard (no command line needed).
* **Performance Options:** Toggle low-bitrate modes for lag-free mirroring on weaker Wi-Fi.
* **Screen Recording:** Capture mobile gameplay directly to your PC video folder.

### 2. 🎮 Smart Game Launcher

Organize your Linux gaming library automatically.

* **Auto-Discovery:** Point it to your ~/Games folder. It scans for any subfolder containing a start.sh script.
* **Instant Launch:** Select your game from a fuzzy-searchable list (fzf).
* **MangoHud Integration:** Asks if you want FPS/CPU/GPU stats overlaid on the game before launching.

### 3. 🚀 Hardware Optimization (The "Game Mode")

Maximizes FPS on laptops and APUs (AMD/Intel).

* **Hyprland Tuning:** Instantly disables Animations, Blur, Shadows, and Rounding to free up GPU resources.
* **CPU Priority:** Automatically triggers Feral Interactive's gamemode daemon.
* **Auto-Restore:** When you close the game, your beautiful desktop themes and animations return automatically.

## 📦 Installation

### Prerequisites

Make sure you have an AUR helper (like yay or paru).

### Install from AUR

```bash
yay -S hypr-game-mode
```

## ⚙️ Configuration

On the first run, the TUI will ask for your **Games Directory**.
Example: /home/user/Games

**Folder Structure Requirement:**
Your games should be organized like this:

```text
~/Games/
├── Cyberpunk2077/
│   └── start.sh   <-- The script detects this!
├── Minecraft/
│   └── start.sh
└── StardewValley/
    └── start.sh
```

## ⌨️ Usage

Bind it to a key in your hyprland.conf:

```ini
bind = SUPER, G, exec, kitty --class floating -e hypr-game-mode
```

*Tip: Use a floating terminal window for the best dashboard experience.*

---

### Phase 4: How to Deploy

1. **Code:** Put the script in a folder.
2. **Git:** Push to GitHub with tag v2.0.0.
3. **AUR:** Copy PKGBUILD to your AUR repo, run updpkgsums, makepkg --printsrcinfo > .SRCINFO, commit, and push.
