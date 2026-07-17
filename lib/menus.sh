#!/usr/bin/env bash

menu_select() {
    local prompt="$1"
    shift
    local options=("$@")

    if ! command_exists gum; then
        log_error "gum is required for menu selection"
        return 1
    fi

    gum choose --header="$prompt" "${options[@]}" 2>/dev/null || return 1
}

menu_android() {
    check_required_cmd gum || return 1

    local choice
    choice=$(menu_select "📱 Android" \
        "🔌 Mirror (USB)" \
        "📡 Connect Wireless (TCP/IP)" \
        "🎥 Record Screen" \
        "📉 Low Resolution (Smooth)" \
        "🔙 Back") || return 0

    case "$choice" in
        "🔌 Mirror (USB)")
            android_mirror_usb
            ;;
        "📡 Connect Wireless (TCP/IP)")
            android_connect_wireless
            ;;
        "🎥 Record Screen")
            android_record_screen
            ;;
        "📉 Low Resolution (Smooth)")
            android_low_resolution
            ;;
        "🔙 Back")
            return 0
            ;;
    esac
}

menu_games() {
    check_required_cmd gum || return 1

    local games
    games=$(find_games) || {
        log_error "No games found in $GAME_DIR"
        command_exists notify-send && notify-send "❌ No Games Found" "Check $GAME_DIR for folders with start.sh" || true
        return 1
    }

    if [ -z "$games" ]; then
        log_error "No games found in $GAME_DIR"
        return 1
    fi

    local selected_game
    selected_game=$(echo "$games" | gum choose --header="🎮 Launch a game" 2>/dev/null) || return 0

    if [ -z "$selected_game" ]; then
        return 0
    fi

    local use_hud
    use_hud=$(gum choose --header="Enable MangoHud (FPS)?" "Yes" "No" 2>/dev/null) || use_hud="No"

    if [ "$use_hud" = "Yes" ]; then
        export USE_MANGOHUD="true"
    else
        export USE_MANGOHUD="false"
    fi

    launch_game "$selected_game"
}

main_menu() {
    while true; do
        local choice
        choice=$(menu_select "Hypr-Game-Mode" \
            "📱 Android/Scrcpy Tools" \
            "🎮 Game Launcher" \
            "🚀 Toggle Performance Mode" \
            "⚙️ Settings" \
            "🚪 Exit") || exit 0

        case "$choice" in
            "📱 Android/Scrcpy Tools")
                menu_android
                ;;
            "🎮 Game Launcher")
                menu_games
                ;;
            "🚀 Toggle Performance Mode")
                toggle_game_mode
                ;;
            "⚙️ Settings")
                menu_settings
                ;;
            "🚪 Exit")
                log_success "Goodbye!"
                exit 0
                ;;
            *)
                exit 0
                ;;
        esac
    done
}

menu_settings() {
    local current_gamemode="${USE_GAMEMODE:-true}"
    local new_gamemode

    if [ "$current_gamemode" = "true" ]; then
        new_gamemode="false"
    else
        new_gamemode="true"
    fi

    local choice
    choice=$(gum choose --header="Enable gamemoded (CPU optimization)? [current: $current_gamemode]" "Yes" "No" 2>/dev/null) || return 0

    if [ "$choice" = "Yes" ]; then
        new_gamemode="true"
    elif [ "$choice" = "No" ]; then
        new_gamemode="false"
    else
        return 0
    fi

    USE_GAMEMODE="$new_gamemode"

    if [ -f "$CONFIG_FILE" ]; then
        sed -i "s/^USE_GAMEMODE=.*/USE_GAMEMODE=$new_gamemode/" "$CONFIG_FILE"
        log_success "gamemoded set to $new_gamemode (saved to config)"
    fi
}
