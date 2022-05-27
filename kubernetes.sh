# Merge Kubeconfigs
function k8s_merge_configs() {
    # Reset KUBECONFIG
    export KUBECONFIG=""
    # Fetch all configuration expect the standard '~/.kube/config'
    for kc in $(find ${HOME}/.kube -maxdepth 1 -type f ! -name "config"); do
        export KUBECONFIG="${KUBECONFIG}:${kc}"
    done
    # Merge
    kubectl config view --flatten
}

# Install MicroK8s
function k8s_microk8s_install() {
    if [[ $(uname -s) == "Linux" ]]; then
        sudo snap install microk8s --classic --channel=latest/stable
        sudo usermod -a -G microk8s "${USER}"
        newgrp microk8s
    else
        echo "[$(basename $0)] MicroK8s installable only on Linux"
    fi
}

# MicroK8s aliases
alias microk8s_install=k8s_microk8s_install

