#!/usr/bin/env bash

find_games() {
    if ! is_dir "$GAME_DIR"; then
        log_error "Invalid GAME_DIR: $GAME_DIR"
        return 1
    fi

    find "$GAME_DIR" -maxdepth 2 -name "start.sh" -type f 2>/dev/null | \
        awk -F/ '{print $(NF-1)}' | sort -u
}

launch_game() {
    local game_name="$1"
    local game_script="${GAME_DIR}/${game_name}/start.sh"

    if ! is_file "$game_script"; then
        log_error "Game script not found: $game_script"
        return 1
    fi

    if ! chmod +x "$game_script" 2>/dev/null; then
        log_error "Cannot make script executable: $game_script"
        return 1
    fi

    local was_active=false
    if is_game_mode_active; then
        was_active=true
    fi

    if ! enable_game_mode; then
        log_error "Failed to enable game mode"
        return 1
    fi

    log_success "Launching: $game_name"

    local cmd="bash"
    if [ "${USE_MANGOHUD:-true}" = "true" ] && command_exists mangohud; then
        cmd="mangohud bash"
    fi

    if ! $cmd "$game_script"; then
        log_warn "Game exited with error"
    fi

    if [ "$was_active" = "false" ]; then
        if ! disable_game_mode; then
            log_warn "Failed to disable game mode - manual reset may be needed"
        fi
    fi

    return 0
}