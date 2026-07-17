#!/usr/bin/env bash

android_mirror_usb() {
    check_required_cmd scrcpy || return 1

    if ! scrcpy --max-size 1024 --window-title "Android USB"; then
        log_error "Scrcpy failed"
        return 1
    fi
}

android_connect_wireless() {
    check_required_cmd adb "android-tools (adb)" || return 1
    check_required_cmd scrcpy || return 1

    echo "Enter Phone IP (found in Settings > About Status):"
    read -r -p "> " ip

    if [ -z "$ip" ]; then
        log_error "No IP provided"
        return 1
    fi

    if ! adb tcpip 5555; then
        log_error "Failed to enable TCP/IP on device"
        return 1
    fi

    if ! adb connect "$ip:5555"; then
        log_error "Failed to connect to device at $ip:5555"
        return 1
    fi

    if ! scrcpy --tcpip="$ip:5555"; then
        log_error "Scrcpy failed"
        return 1
    fi
}

android_record_screen() {
    check_required_cmd scrcpy || return 1

    local video_dir="${USER_HOME}/Videos/Captures"
    if ! mkdir -p "$video_dir" 2>/dev/null; then
        log_error "Cannot create video directory: $video_dir"
        return 1
    fi

    local video_path="${video_dir}/android_$(date +%s).mp4"
    if ! scrcpy --record "$video_path"; then
        log_error "Recording failed"
        rm -f "$video_path"
        return 1
    fi
}

android_low_resolution() {
    check_required_cmd scrcpy || return 1

    if ! scrcpy --max-size 800 --bit-rate 2M --max-fps 60; then
        log_error "Scrcpy failed"
        return 1
    fi
}