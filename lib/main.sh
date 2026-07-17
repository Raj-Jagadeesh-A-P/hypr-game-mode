#!/usr/bin/env bash

main() {
    trap 'log_warn "Interrupted"; exit 130' INT TERM

    refuse_root
    init_config
    load_config

    main_menu
}