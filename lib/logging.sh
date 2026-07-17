#!/usr/bin/env bash

log_error() {
    printf "%b %s\n" "${RED}❌${NC}" "$1" >&2
}

log_success() {
    printf "%b %s\n" "${GREEN}✅${NC}" "$1"
}

log_info() {
    printf "%b %s\n" "${BLUE}ℹ️${NC}" "$1"
}

log_warn() {
    printf "%b %s\n" "${YELLOW}⚠️${NC}" "$1"
}

error_exit() {
    local code=$1
    shift
    log_error "$@"
    exit "$code"
}