# hypr-game-mode

hypr-game-mode is a TUI command center for Hyprland that unifies Android screen control, game launching, and performance tuning in a single fzf-driven menu.

## How it works

On first run, it asks for your games directory and stores it in ~/.config/hypr-game-mode/config. After that, it presents a main menu with three options.

## Project structure

- `hypr-game-mode`: Entry point that loads modules and starts the app.
- `lib/constants.sh`: Shared constants and config paths.
- `lib/logging.sh`: Colored logging helpers.
- `lib/utils.sh`: Utility and precondition checks.
- `lib/config.sh`: First-run setup and config loading.
- `lib/game_mode.sh`: Performance mode on/off logic.
- `lib/launcher.sh`: Game discovery and launch flow.
- `lib/android.sh`: scrcpy/adb Android helpers.
- `lib/menus.sh`: fzf-powered menus.
- `lib/main.sh`: Top-level app startup flow.

## Menu options

### 1) Android / Scrcpy Tools

Provides quick actions for scrcpy and adb:

- Mirror (USB): Starts scrcpy with a capped resolution for smooth mirroring.
- Connect Wireless (TCP/IP): Switches the phone to TCP/IP mode, connects via IP, then launches scrcpy.
- Record Screen: Records the device screen to ~/Videos/Captures.
- Low Resolution (Smooth): Uses a lower bitrate and resolution for weaker Wi‑Fi or older devices.

### 2) Game Launcher

Scans your games directory for subfolders that contain start.sh, lists them in fzf, and launches the selected game. It can optionally start MangoHud for FPS/CPU/GPU overlay. Game mode is toggled on before launch and restored after the game exits.

### 3) Toggle Performance Mode

Toggles Hyprland visuals and GameMode:

- Disables animations, blur, shadows, and rounding for better FPS.
- Starts/stops gamemoded if available.
- Restores Hyprland visuals when toggled off.
