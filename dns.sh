function __dns_flush_darwin() {
    echo "Flusing cache..."
    sudo dscacheutil -flushcache
    echo "HUP mDNSResponder..."
    sudo killall -HUP mDNSResponder
}


function __dns_flush_linux() {
    sudo systemd-resolve --flush-caches
}


# Flush DNS cache
function dns-flush() {
    case  $(uname -s) in
        Darwin*) __dns_flush_darwin;;
        Linux) __dns_flush_linux;;
        *) echo "$(basename $0): Not implemented for $(uname -s) OS" >&2; exit 1;;
    esac
}
