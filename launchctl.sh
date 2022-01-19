__LAUNCHCTL="/bin/launchctl"


# Wraps and augment macOS's 'launchctl' command.
# 'dump': List all units
# '*': Run launchctl
function launchctl() {
    case "${1}" in
        dump) "${__LAUNCHCTL}" list | awk '{print $3}' | uniq | sort;;
        *) "${__LAUNCHCTL}" "${@}";;
    esac
}