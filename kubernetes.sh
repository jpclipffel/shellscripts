# Merge Kubeconfigs
function k8s-merge-configs() {
    # Reset KUBECONFIG
    export KUBECONFIG=""
    # Fetch all configuration expect the standard '~/.kube/config'
    for kc in $(find -L ${HOME}/.kube -maxdepth 1 -type f ! -name "config"); do
        export KUBECONFIG="${KUBECONFIG}:${kc}"
    done
    # Merge
    kubectl config view --flatten
}


# Install MicroK8s
function k8s-microk8s-install() {
    if [[ $(uname -s) == "Linux" ]]; then
        echo "Installing MicroK8s"
        sudo snap install microk8s --classic --channel=latest/stable
        echo "Setting groups"
        sudo usermod -a -G microk8s "${USER}"
        echo "Enabling MicroK8s base addons"
        sudo microk8s enable dns hostpath-storage ingress
    else
        echo "[$(basename $0)] MicroK8s installable only on Linux"
    fi
}


# Custom kube-ps1 context function
# $1: Context name
function KUBE_PS1_CLUSTER_FUNCTION() {
    export KUBE_PS1_CLUSTER_FUNCTION="KUBE_PS1_CLUSTER_FUNCTION"
    echo "${1}" | sed \
        -e 's|arn:aws:eks:.*/||' 
}
KUBE_PS1_CLUSTER_FUNCTION

# MicroK8s aliases
alias mk="microk8s kubectl"
