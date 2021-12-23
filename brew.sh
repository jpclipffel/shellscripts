BREW_OUTDATED_REPORT="${HOME}/.brew_outdated_report"


# Echoes the number of outdated items
function __brew_outdated() {
    [[ -f "${BREW_OUTDATED_REPORT}" ]] && wc -l "${BREW_OUTDATED_REPORT}" | awk '{print $1}' || echo "0"
}


# Echoes Brew status information
function brew_ps1() {
    local outdated=$(__brew_outdated)
    [[ ${outdated} -gt 0 ]] && echo "[brew:\e[0;31m${outdated}\e[m]"
}
