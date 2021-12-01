# List of common virtual envs paths
__VENVS_PATH=("${HOME}/.venvs" "${HOME}/.virtualenvs")


function __python_alias_darwin() {
    export DYLD_LIBRARY_PATH=$(brew --prefix)/opt/openssl/lib:$DYLD_LIBRARY_PATH
    alias python="python3"
    alias pip="pip3"
    alias venv="python3 -m venv"
}


function pip_upgrade_all() {
    local frozen=$(mktemp)
    pip list --outdated --format=freeze | cut -d '=' -f 1 > ${frozen}
    pip install --upgrade -r ${frozen}
    rm ${frozen}
}


# Activate a virtual environment
# $1: virualenv name
function avenv() {
    [[ -z "${1}" ]] && echo "Usage: $(basename ${0}) <virtual env name>" && return
    # Search & activate
    for p in ${__VENVS_PATH[@]}; do
        if [[ -f "${p}/${1}/bin/activate" ]]; then
            source "${p}/${1}/bin/activate"
            return
        fi
    done
    echo "Virtual environment '${1}' not found in ${__VENVS_PATHS[@]}"
}


# List virtual environments
function venvs() {
    for vrp in ${__VENVS_PATH[@]}; do
        for p in $(find "${vrp}" -type d -maxdepth 1 2&>/dev/null); do
            [[ -f "${p}/bin/activate" ]] && printf "%-10s %s\n" "$(basename ${p})" "${p}"
        done
    done
}


# Run implicits functions
case $(uname -s) in
    Darwin) __python_alias_darwin;;
esac
