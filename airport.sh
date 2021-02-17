# Airport CLI
function airport {
    case $(uname -s) in
        Darwin) /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport $@;;
        *) echo "$(basename $0): Not implemented for $(uname -s)" >&2;;
    esac
}
