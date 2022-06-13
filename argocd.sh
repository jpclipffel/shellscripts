# ArgoCD context name PS1
function argocd_ps1() {
    [[ "${ARGOCD_PS1_ENABLED}" == "on" ]] && echo "[${orange}acd:${green}$(argocd context | grep '\*' | awk '{print $2}')${reset_color}] " || return
}

# Enable ArgoCD PS1
function argocd_ps1_on() {
    export ARGOCD_PS1_ENABLED="on"
}

# Disable ArgoCD PS1
function argocd_ps1_off() {
    export ARGOCD_PS1_ENABLED="off"
}


alias ac="argocd"
alias acd="argocd"
alias acuc="argocd context"
alias acgc="argocd context"
