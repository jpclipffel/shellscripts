function __java_darwin() {
    "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java" "${@}"
}


function java() {
    case  $(uname -s) in
        Darwin*) __java_darwin "${@}";;
        *) echo "$(basename $0): Not implemented for $(uname -s) OS" >&2; exit 1;;
    esac
}

