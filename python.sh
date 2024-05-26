# List of common virtual envs paths
__VENVS_PATH=("${HOME}/.venvs" "${HOME}/.virtualenvs")


# Select the proper Python versions on macOS (brew).
function __python_select_darwin() {
    # Bind to proper OpenSSL lib
    export DYLD_LIBRARY_PATH=$(brew --prefix)/opt/openssl/lib:$DYLD_LIBRARY_PATH
    # Locate the latest Python version installed in Brew prefix
    local brew_python_path=$(\
        find $(brew --prefix)/opt -maxdepth 1 -name "python@*" \
        | sort -t "." -k1,1n -k2,2n -k3,3n \
        | tail -n 1)
    if [ -n "${brew_python_path}" ]; then
        # Add latest Python path in PATH
        export PATH="${brew_python_path}/bin:$PATH"
        # Get the Python interpreter path
        local brew_python_bin="${brew_python_path}/bin/$(basename ${brew_python_path/@/})"
        # Ensure python3 -> Brew's Python
        if [ ! -L "${brew_python_path}/bin/python3" ] || [ ! -f "${brew_python_path}/bin/python3" ]; then
            ln -s "${brew_python_bin}" "${brew_python_path}/bin/python3"
        fi
        # Set version-specific aliases
        alias pip3="python3 -m pip"
        # Set version-agnotic aliases
        alias python="python3"
        alias pip="pip3"
        # Set tools aliases
        alias venv="python3 -m venv"
        alias ipython="python3 -m IPython"
    fi
}


# Updagre all Python's PIP packages at once
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


# Activate the default virtual environment
function adp() {
    avenv "default"
}


# Run implicits functions
case $(uname -s) in
    Darwin) __python_select_darwin;;
esac
