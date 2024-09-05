# Ansible :: ARA :: Container
# - Non-standard variables
export ARA_CONTAINER_NAME="ansible-ara"
export ARA_CONTAINER_LOCAL_PORT=8000

# Ansible :: ARA
# - Standard variables
export ARA_API_CLIENT="http"
export ARA_API_SERVER="http://127.0.0.1:${ARA_CONTAINER_LOCAL_PORT}"


# Install Ansible
# NB: Do not use 'read -p "prompt"' or 'read "foo?prompt"' to keep
# compatibility between Bash and ZSH
function ansible-install() {
    [[ -z "${VIRTUAL_ENV}" ]] && echo "Not in a venv / virtualenv" >&2 && return 1
    echo "Ansible comes in two flavours:"
    echo "ansible-core : Minimal installation"
    echo "ansible      : Full-featured installation"
    echo
    echo "Please select Ansible flavour ('ansible' or 'ansible-core'): "
    read "flavour"
    case "${flavour}" in
        ansible) pip install ansible ansible-lint ansible-vault ara;;
        ansible-core) pip install ansible-core ansible-lint ansible-vault;;
    esac
}


# Update Ansible
function ansible-update() {
    [[ -z "${VIRTUAL_ENV}" ]] && echo "Not in a venv / virtualenv" && return 1
    type ansible &> /dev/null || (echo "Ansible is not installed (hint: run 'ansible_install')" && return 1)
    local packages=("ansible-core" "ansible-lint")
    pip list --format "freeze" | grep "ansible" && packages+=("ansible")
    # Update
    pip install --upgrade "${packages[@]}"
}


# Run ARA
function ansible-ara() {
    case "${1}" in
        start)
            docker run --name ${ARA_CONTAINER_NAME} \
            --detach \
            --tty \
            --volume ${HOME}/.ara/server:/opt/ara \
            -p ${ARA_CONTAINER_LOCAL_PORT}:8000 \
            docker.io/recordsansible/ara-api:latest
            ;;
        status)
            docker ps | grep ${ARA_CONTAINER_NAME}
            ;;
        open)
            open "${ARA_API_SERVER}"
            ;;
        *)
            echo "Usage: ${0} <start|status|open|stop>"
            return 1
            ;;
    esac
}


# Invoke ansible-playbook with ARA as callback plugin
function ap-ara() {
    ANSIBLE_CALLBACK_PLUGINS="$(python3 -m ara.setup.callback_plugins)" \
    ANSIBLE_ACTION_PLUGINS="$(python3 -m ara.setup.action_plugins)" \
    ANSIBLE_LOOKUP_PLUGINS="$(python3 -m ara.setup.lookup_plugins)" \
    ansible-playbook "${@}"
}


# Invoke ansible-playbook with support for multiple configuration file
function ap() {
    if [[ -f "ansible-local.cfg" ]]; then
        echo "IMPORTANT - Runing ansible with ANSIBLE_CONFIG='ansible-local.cfg'"
        ANSIBLE_CONFIG="ansible-local.cfg" ansible-playbook "${@}"
    else
        ansible-playbook "${@}"
    fi
}

# Invoke ansible-navigator
function an() {
    if [[ -f "ansible-local.cfg" ]]; then
        echo "IMPORTANT - Runing ansible with ANSIBLE_CONFIG='ansible-local.cfg'"
        ANSIBLE_CONFIG="ansible-local.cfg" ansible-navigator "${@}"
    else
        ansible-navigator "${@}"
    fi
}


# Patch for Darwin
function __patch_ansible_objc_fork {
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
}


# Run implicit functions
case  $(uname -s) in
    Darwin*) __patch_ansible_objc_fork;;
esac
