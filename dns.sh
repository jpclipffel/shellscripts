#!/bin/bash


function __dns_flush_darwin() {
    sudo killall -HUP mDNSResponder
    sudo killall mDNSResponderHelper
    sudo dscacheutil -flushcache
}


# Flush DNS cache
function dns_flush() {
    case  $(uname -s) in
        Darwin*) __dns_flush_darwin;;
        *) echo "$(basename $0): Not implemented for $(uname -s) OS" >&2; exit 1;;
    esac
}
