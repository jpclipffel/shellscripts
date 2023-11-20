# OMZ :: kube_ps1 :: Settings
KUBE_PS1_SYMBOL_USE_IMG=false
KUBE_PS1_SYMBOL_DEFAULT="k8s:"
KUBE_PS1_DIVIDER=" in "
KUBE_PS1_SEPARATOR=""
KUBE_PS1_PREFIX="["
KUBE_PS1_SUFFIX="] "


# OMZ :: kube_ps1 :: Aliases
alias kon="kubeon"
alias koff="kubeoff"


# OMZ :: kube_ps1 :: Initial status
kubeoff


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