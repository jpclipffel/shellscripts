# OMZ :: Plugins :: kube-ps1 :: Aliases
alias kon="kubeon"
alias koff="kubeoff"


# OMZ :: Plugins :: kube-ps1 :: KUBE_PS1_CLUSTER_FUNCTION :: Hide AWS/EKS artifacts
function _kube_ps1_cluster__eks() {
    echo "${1}" | rev | cut -d '/' -f 1 | rev
}


# Merge Kubeconfigs
function k8s-merge-configs() {
    # Reset KUBECONFIG
    export KUBECONFIG=""
    # Fetch all configuration expect the standard '~/.kube/config'
    for kc in $(find ${HOME}/.kube -maxdepth 1 -type f ! -name "config"); do
        export KUBECONFIG="${KUBECONFIG}:${kc}"
    done
    # Merge
    kubectl config view --flatten
}