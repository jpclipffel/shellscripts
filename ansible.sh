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
        ansible) pip install ansible ansible-lint;;
        ansible-core) pip install ansible-core ansible-lint;;
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


# Patch for Darwin
function __patch_ansible_objc_fork {
    export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
}


# Run implicit functions
case  $(uname -s) in
    Darwin*) __patch_ansible_objc_fork;;
esac
