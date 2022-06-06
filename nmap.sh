function nmap-discover() {
    test -z "${1}" && echo "Usage: $(basename ${0}) <ip/range>" && return 1;
    nmap -sn ${1}
}


function nmap-discover-fast() {
    test -z "${1}" && echo "Usage: $(basename ${0}) <ip/range>" && return 1;
    nmap -sn -PA21,22,25,3389 ${1}
}
