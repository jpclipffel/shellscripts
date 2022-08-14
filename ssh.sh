# Lists SSH hosts
function ssh-hosts() {
    grep '^\(Match \)\?Host' .ssh/config .ssh/config.d/* \
    | sed 's/Match //' \
    | sed 's/\(.*\):Host \(.*\)/\2 : \1/' \
    | column -t -s ':'
}
