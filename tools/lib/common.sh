#!/usr/bin/env bash
# tools/lib/common.sh - Shared utility functions for toolbox scripts

set -eo pipefail

# Text formatting
if [[ -t 1 ]]; then
    BOLD="$(tput bold 2>/dev/null || printf '')"
    DIM="$(tput dim 2>/dev/null || printf '')"
    RESET="$(tput sgr0 2>/dev/null || printf '\033[0m')"
    RED="$(tput setaf 1 2>/dev/null || printf '\033[31m')"
    GREEN="$(tput setaf 2 2>/dev/null || printf '\033[32m')"
    YELLOW="$(tput setaf 3 2>/dev/null || printf '\033[33m')"
    BLUE="$(tput setaf 4 2>/dev/null || printf '\033[34m')"
    MAGENTA="$(tput setaf 5 2>/dev/null || printf '\033[35m')"
    CYAN="$(tput setaf 6 2>/dev/null || printf '\033[36m')"
    WHITE="$(tput setaf 7 2>/dev/null || printf '\033[37m')"
else
    BOLD=""
    DIM=""
    RESET=""
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    CYAN=""
    WHITE=""
fi

# Logging helpers
log_info() {
    printf "${BLUE}ℹ${RESET} %s\n" "$*"
}

log_success() {
    printf "${GREEN}✔${RESET} %s\n" "$*"
}

log_warn() {
    printf "${YELLOW}⚠${RESET} %s\n" "$*"
}

log_error() {
    printf "${RED}✖${RESET} %s\n" "$*" >&2
}

log_header() {
    printf "\n${BOLD}${CYAN}=== %s ===${RESET}\n" "$*"
}

# Resolve toolbox repository root
get_toolbox_root() {
    local source="${BASH_SOURCE[0]}"
    while [ -h "$source" ]; do
        local dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$dir/$source"
    done
    local lib_dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
    dirname "$lib_dir" | xargs dirname
}

# Check if a command is available
has_cmd() {
    command -v "$1" >/dev/null 2>&1
}

# Interactive confirmation prompt
confirm_action() {
    local prompt_msg="$1"
    local default_ans="${2:-y}" # 'y' or 'n'

    if [[ "$default_ans" =~ ^[Yy]$ ]]; then
        local choices="[Y/n]"
    else
        local choices="[y/N]"
    fi

    read -r -p "${YELLOW}?${RESET} ${prompt_msg} ${choices} " answer
    answer="${answer:-$default_ans}"

    [[ "$answer" =~ ^[Yy]$ ]]
}

# Check if Google Drive is currently mounted
is_drive_mounted() {
    local mount_point="${1:-/content/drive}"
    [[ -d "${mount_point}/MyDrive" ]]
}

# Ensure Google Drive is mounted, attempting mount if not already accessible
ensure_drive_mounted() {
    local mount_point="${1:-/content/drive}"
    local force_remount="${2:-false}"

    if [[ "$force_remount" != "true" ]] && is_drive_mounted "$mount_point"; then
        return 0
    fi

    log_info "Google Drive not detected at ${mount_point}. Attempting mount..."

    local mount_err
    if ! mount_err="$(python3 -c "
import sys
try:
    from google.colab import drive
    force = ('${force_remount}' == 'true')
    drive.mount('${mount_point}', force_remount=force)
except Exception as e:
    print(f'{e}', file=sys.stderr)
    sys.exit(1)
" 2>&1)"; then
        log_error "Failed to mount Google Drive at ${mount_point}."
        if [[ -n "$mount_err" ]]; then
            printf "    %s\n" "$mount_err" >&2
        fi
        return 1
    fi

    if is_drive_mounted "$mount_point"; then
        log_success "Google Drive mounted successfully at ${mount_point}."
        return 0
    else
        log_error "Google Drive mount succeeded but ${mount_point}/MyDrive not accessible."
        return 1
    fi
}

