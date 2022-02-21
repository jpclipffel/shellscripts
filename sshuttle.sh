SSHUTTLE_CONFS="${HOME}/.sshuttle"


# Run sshuttle with a configuration file
# $1: configuration name (should be located in ${SSHUTTLE_CONFS})
# $2: other sshuttle arguments
function shut() {
    [[ -z "${1}" ]] && echo "Usage: $(basename ${0}) <config> [...]" && return 

    local config="${1}"
    shift

    if [[ -e "${SSHUTTLE_CONFS}/${config}" ]]; then
        sshuttle "@${SSHUTTLE_CONFS}/${config}" "${@}"
    else
        echo "Configuration '${config}' not found in '${SSHUTTLE_CONFS}'"
    fi  
}
