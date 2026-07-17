#!/usr/bin/env bash

is_game_mode_active() {
    is_file "$STATE_FILE"
}

set_game_mode_active() {
    mkdir -p "$CONFIG_DIR" || return 1

    if [ "$1" = "true" ] || [ "$1" -eq 1 ]; then
        touch "$STATE_FILE" || return 1
    else
        rm -f "$STATE_FILE" || return 1
    fi
}

enable_game_mode() {
    check_hyprland || return $?

    if is_game_mode_active; then
        return 0
    fi

    log_info "Enabling Game Mode..."
    command_exists notify-send && notify-send -u low "🚀 Game Mode" "Optimizing Hyprland & CPU..." || true

    if [ "${USE_GAMEMODE:-true}" = "true" ] && command_exists gamemoded; then
        if ! gamemoded 2>/dev/null; then
            log_warn "Failed to start gamemoded (continuing without CPU optimization)"
        fi
    fi

    if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        if ! hyprctl --batch \
            "keyword animations:enabled 0; \
             keyword decoration:drop_shadow 0; \
             keyword decoration:blur:enabled 0; \
             keyword decoration:rounding 0" 2>/dev/null; then
            log_error "Failed to apply Hyprland tweaks"
            return 1
        fi
    fi

    if ! set_game_mode_active true; then
        log_error "Failed to update state file"
        return 1
    fi

    log_success "Game mode enabled"
    return 0
}

disable_game_mode() {
    check_hyprland || return $?

    if ! is_game_mode_active; then
        return 0
    fi

    log_info "Disabling Game Mode..."
    command_exists notify-send && notify-send -u low "🛑 Desktop Mode" "Restoring Visuals..." || true

    if [ "${USE_GAMEMODE:-true}" = "true" ] && command_exists gamemoded; then
        if ! killall gamemoded 2>/dev/null; then
            log_warn "Failed to stop gamemoded (continuing with restore)"
        fi
    fi

    if [ -n "${HYPRLAND_INSTANCE_SIGNATURE}" ]; then
        if ! hyprctl reload 2>/dev/null; then
            log_error "Failed to reload Hyprland"
            return 1
        fi
    fi

    if ! set_game_mode_active false; then
        log_error "Failed to update state file"
        return 1
    fi

    log_success "Game mode disabled"
    return 0
}

toggle_game_mode() {
    if is_game_mode_active; then
        disable_game_mode
    else
        enable_game_mode
    fi
}