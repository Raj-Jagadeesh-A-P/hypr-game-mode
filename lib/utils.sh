#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

is_file() {
    [ -f "$1" ]
}

is_dir() {
    [ -d "$1" ]
}

refuse_root() {
    if [ "${EUID:-$(id -u)}" -eq 0 ] && [ -z "${SUDO_USER}" ]; then
        error_exit 1 "Do not run this script as root."
    fi
}

check_hyprland() {
    if ! command_exists hyprctl; then
        log_error "hyprctl not found. Are you running Hyprland?"
        return 1
    fi

    if [ -z "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        log_warn "Hyprland is not running. Skipping compositor tweaks."
        return 0
    fi
    return 0
}

check_required_cmd() {
    local cmd="$1"
    local name="${2:-$cmd}"

    if ! command_exists "$cmd"; then
        log_error "Missing dependency: $name ($cmd)"
        return 1
    fi
}