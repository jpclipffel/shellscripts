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
