#!/usr/bin/env bash

init_config() {
    if ! mkdir -p "$CONFIG_DIR" 2>/dev/null; then
        error_exit 1 "Cannot create config directory: $CONFIG_DIR"
    fi

    if is_file "$CONFIG_FILE"; then
        return 0
    fi

    log_warn "First Run Detected!"
    echo "Enter the full path to your Games folder (where subfolders contain start.sh):"
    read -r -p "> " input_dir

    input_dir="${input_dir/#\~/$HOME}"
    input_dir="${input_dir/#\~/$USER_HOME}"

    if ! is_dir "$input_dir"; then
        error_exit 1 "Directory not found: $input_dir"
    fi

    {
        echo "GAME_DIR=\"$input_dir\""
        echo "USE_MANGOHUD=true"
        echo "USE_GAMEMODE=true"
    } > "$CONFIG_FILE" || error_exit 1 "Failed to write config file"

    log_success "Setup Complete. Config saved to $CONFIG_FILE"
    sleep 1
}

load_config() {
    if ! is_file "$CONFIG_FILE"; then
        error_exit 1 "Config file not found: $CONFIG_FILE"
    fi

    # shellcheck source=/dev/null
    if ! source "$CONFIG_FILE" 2>/dev/null; then
        error_exit 1 "Failed to load config file"
    fi

    if [ -z "$GAME_DIR" ]; then
        error_exit 1 "GAME_DIR not set in config file"
    fi

    if ! is_dir "$GAME_DIR"; then
        error_exit 1 "GAME_DIR is not a valid directory: $GAME_DIR"
    fi
}