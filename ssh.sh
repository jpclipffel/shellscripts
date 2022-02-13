#__SSH="${__SSH:=/usr/bin/ssh}"


# List SSH hosts
function ssh_hosts() {
    cat ${HOME}/.ssh/config | grep '^Host' | cut -d ' ' -f 2
}


## Replace SSH with XXH is XXH is installed
#function ssh() {
#    type xxh &>/dev/null && xxh "${@}" || (echo "xxh not installed, fallback to ssh" && "${__SSH}" "${@}")
#}


#function _ssh() {
#    "${__SSH}" "${@}"
#}
