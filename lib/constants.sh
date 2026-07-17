#!/usr/bin/env bash

# --- COLORS & FORMATTING ---
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# --- PATHS & CONSTANTS ---
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_VERSION="1.0.0"

get_home() {
    if [ "${EUID:-$(id -u)}" -eq 0 ] && [ -n "${SUDO_USER}" ]; then
        getent passwd "$SUDO_USER" | cut -d: -f6
    else
        echo "$HOME"
    fi
}

readonly USER_HOME="$(get_home)"
readonly CONFIG_DIR="${USER_HOME}/.config/hypr-game-mode"
readonly CONFIG_FILE="${CONFIG_DIR}/config"
readonly STATE_FILE="${CONFIG_DIR}/game_mode.state"