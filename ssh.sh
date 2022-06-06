# Lists SSH hosts
function ssh-hosts() {
    grep '^Host' .ssh/config .ssh/config.d/* \
    | sed 's/\(.*\):Host \(.*\)/\2 : \1/' \
    | column -t -s ':'
}
