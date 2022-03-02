OS_CLOUDS_YAML="${HOME}/.config/openstack/clouds.yaml"


alias os=openstack
alias osc=openstack
alias ost=openstack


# OpenStack cloud name PS1
function openstack_ps1() {
    [[ -n "${OS_CLOUD}" ]] && echo "[os:${OS_CLOUD}] " || return
}


# Get OpenStack clouds
function osgc() {
    if [[ -e "${OS_CLOUDS_YAML}" ]]; then
        cat "${OS_CLOUDS_YAML}" | egrep '^\s{2}[a-zA-Z0-9_-]+:' | sed -e 's/ //g' -e 's/://g'
     else
         echo "No OpenStack clouds file at ${OS_CLOUDS_YAML}"
     fi
}


# Set OpenStack cloud
function osuc() {
    export OS_CLOUD="${1}"
}

