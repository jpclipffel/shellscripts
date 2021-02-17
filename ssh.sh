# List SSH hosts
function ssh_hosts() {
  cat ${HOME}/.ssh/config | grep '^Host' | cut -d ' ' -f 2
}

