[[ -e /opt/homebrew/bin/brew ]] && __BREW="${__BREW:=/opt/homebrew/bin/brew}"
[[ -e /usr/local/bin/brew ]] && __BREW="${__BREW:=/usr/local/bin/brew}"
[[ -e /home/linuxbrew/.linuxbrew/bin/brew ]] && __BREW="${__BREW:=/home/linuxbrew/.linuxbrew/bin/brew}"


__BREW_OUTDATED_REPORT="${HOME}/.brew_outdated_report"


# Linux helpers for Brew
function __brew_linux_helpers() {
    [[ -e "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}


# Echoes the number of outdated items
function __brew_outdated() {
    [[ -f "${__BREW_OUTDATED_REPORT}" ]] && wc -l "${__BREW_OUTDATED_REPORT}" | awk '{print $1}' || echo "0"
}


# Echoes Brew status information
function brew_ps1() {
    local outdated=$(__brew_outdated)
    [[ ${outdated} -gt 0 ]] && echo "[brew:${outdated}]" || return
}


# Wraps Brew invocation
# 'upgrade': Run Brew then update custom outdated report
# '*': Run Brew
function brew() {
    [[ ! -f "${__BREW}" ]] && return 1
    case "${1}" in
        upgrade)
            "${__BREW}" "${@}"
            "${__BREW}" outdated > "${__BREW_OUTDATED_REPORT}"
            ;;
        *) "${__BREW}" "${@}"
            ;;
    esac
}


# Run implicit functions
case  $(uname -s) in
    Linux*) __brew_linux_helpers;;
esac
