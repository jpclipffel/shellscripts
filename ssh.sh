# Lists SSH hosts
function ssh-hosts() {
<<<<<<< HEAD
    grep '^\(Match \)\?Host' .ssh/config .ssh/config.d/* \
    | sed 's/Match //' \
=======
    grep '^Host' ~/.ssh/config ~/.ssh/config.d/* \
>>>>>>> 0981151d7c73be3f7b721e0e91dcb17a4d0dcb03
    | sed 's/\(.*\):Host \(.*\)/\2 : \1/' \
    | column -t -s ':'
}
