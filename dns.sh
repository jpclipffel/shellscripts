function __dns_flush_darwin() {
    sudo killall -HUP mDNSResponder
    sudo killall mDNSResponderHelper
    sudo dscacheutil -flushcache
    # ---
    # Force mDNSResponder restart
    # sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
    # sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist
}


function __dns_flush_linux() {
    sudo systemd-resolve --flush-caches
}


# Flush DNS cache
function dns_flush() {
    case  $(uname -s) in
        Darwin*) __dns_flush_darwin;;
        Linux) __dns_flush_linux;;
        *) echo "$(basename $0): Not implemented for $(uname -s) OS" >&2; exit 1;;
    esac
}
