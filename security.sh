# Start Netskope
function security_netskope_on() {
    sudo systemctl start stagentd
}


# Patch Netskop rules to make it less annoying
# $1: mode ('-A' or '-D')
function security_netskope_patch() {
    sudo iptables -t mangle ${1} OUTPUT -p udp -m udp --dport 53 -j MARK --set-xmark 0x5/0xffffffff
    sudo iptables -t mangle ${1} OUTPUT -p tcp -m multiport --dports 80,443 -j MARK --set-xmark 0x5/0xffffffff
    sudo iptables -t mangle ${1} OUTPUT -p udp -m multiport --dports 80,443 -j MARK --set-xmark 0x5/0xffffffff
}


# Stop Netskope
function security_netskope_off() {
    sudo systemctl stop stagentd
}


# Start MDATP
function security_mdatp_on() {
    sudo systemctl start mdatp
}


function security_status() {
    echo "Services"
    for service in "stagentd" "mdatp"; do
        systemctl status ${service} >/dev/null
        retcode="${?}"
        if [[ "${retcode}" == "0" ]]; then
            message="running (${retcode})"
        else
            message="unknown (${retcode})"
        fi
        echo "[*] ${service}: ${message}"
    done
    echo "Firewall"
    sudo iptables -t mangle -S
}


# Entry point
function security() {
    case $1 in
        on)
            security_netskope_on
            security_netskope_patch "-D"
            security_mdatp_on
            ;;
        onon)
            security_netskope_on
            security_netskope_patch "-A"
            security_mdatp_on
            ;;
        status)
            security_status
            ;;
        *)
            echo "Usage: ${0} {on,onon,off,status}"
            exit 1
            ;;
    esac
}
