#!/usr/bin/env bash
# Description: Automated zero-dependency test runner for toolbox
set -eo pipefail

TESTS_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
TOOLBOX_ROOT="$(dirname "$TESTS_DIR")"
# shellcheck source=tools/lib/common.sh
source "${TOOLBOX_ROOT}/tools/lib/common.sh"

log_header "Toolbox Automated Test Suite"

PASSED=0
FAILED=0

run_test() {
    local test_name="$1"
    local command="$2"
    local expected_pattern="$3"

    printf "  Running: %-45s " "$test_name"
    local output=""
    if output=$(eval "$command" 2>&1); then
        if [[ -z "$expected_pattern" ]] || echo "$output" | grep -F "$expected_pattern" >/dev/null; then
            printf "${GREEN}✔ PASS${RESET}\n"
            PASSED=$((PASSED + 1))
            return 0
        fi
    fi
    printf "${RED}✖ FAIL${RESET}\n"
    printf "${RED}Output:${RESET}\n%s\n\n" "$output"
    FAILED=$((FAILED + 1))
}

# Test 1: CLI Dispatcher Top-Level Help
run_test "Dispatcher Top-Level Help" \
    "${TOOLBOX_ROOT}/toolbox --help" \
    "Available Categories & Tools"

# Test 2: Category Discovery
run_test "Category Discovery (setup, colab, skills, audit)" \
    "${TOOLBOX_ROOT}/toolbox --help" \
    "setup"

# Test 3: Environment Setup Status Inspection
run_test "Setup Status Inspection" \
    "${TOOLBOX_ROOT}/toolbox setup status" \
    "Environment & Credentials Status Check"

# Test 4: Runtime Persistence Help
run_test "Colab Persistence Help" \
    "${TOOLBOX_ROOT}/toolbox colab --help" \
    "Usage:"

# Test 5: Skills List Command
run_test "Skills List Output" \
    "${TOOLBOX_ROOT}/toolbox skills list" \
    "Available Agent Skills"

# Test 6: Skills Machine-Readable JSON Mode
run_test "Skills JSON Validation" \
    "${TOOLBOX_ROOT}/toolbox skills list --json" \
    "\"name\": \"advanced-programmer\""

# Test 7: Skills Show Documentation
run_test "Skills Show Command" \
    "${TOOLBOX_ROOT}/toolbox skills show readme-architect --raw" \
    "Readme Architect Skill"

# Test 8: Multi-Repo Static Audit (Internal)
run_test "Static Audit Self-Check" \
    "${TOOLBOX_ROOT}/toolbox audit check" \
    "Audit PASSED"

# Test 9: Multi-Repo Static Audit (Explicit Path Argument)
run_test "Multi-Repo Target Path Audit" \
    "${TOOLBOX_ROOT}/toolbox audit check '${TOOLBOX_ROOT}'" \
    "Audit PASSED"

# Test 10: Audit Command Help Display
run_test "Audit Check Help Option" \
    "${TOOLBOX_ROOT}/toolbox audit check --help" \
    "Usage: ./toolbox audit check [path]"

# Test 11: Setup GitHub Help Option
run_test "Setup GitHub Help Option" \
    "${TOOLBOX_ROOT}/toolbox setup gh --help" \
    "Usage:"

# Test 12: Setup GitHub Status Inspection
run_test "Setup GitHub Status Inspection" \
    "${TOOLBOX_ROOT}/toolbox setup gh status" \
    "GitHub CLI & Token Status"

# Test 13: Setup Drive Help Option
run_test "Setup Drive Help Option" \
    "${TOOLBOX_ROOT}/toolbox setup drive --help" \
    "Usage:"

# Test 14: Setup Drive Status Inspection
run_test "Setup Drive Status Inspection" \
    "${TOOLBOX_ROOT}/toolbox setup drive status" \
    "Google Drive Mount Status"

printf "\n${BOLD}Test Summary:${RESET}\n"
printf "  Total Tests: %d\n" $((PASSED + FAILED))
printf "  Passed:      ${GREEN}%d${RESET}\n" "$PASSED"
if [[ $FAILED -gt 0 ]]; then
    printf "  Failed:      ${RED}%d${RESET}\n" "$FAILED"
    exit 1
else
    printf "  Failed:      %d\n" "$FAILED"
    log_success "All test suites passed cleanly."
    exit 0
fi
