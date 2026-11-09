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
