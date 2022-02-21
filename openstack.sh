alias os=openstack
alias osc=openstack
alias ost=openstack


function openstack_ps1() {
    [[ -n "${OS_CLOUD}" ]] && echo "[os:${OS_CLOUD}] " || return
}

