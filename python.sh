function __python_alias_darwin() {
    export DYLD_LIBRARY_PATH=$(brew --prefix)/opt/openssl/lib:$DYLD_LIBRARY_PATH
    alias python="python3"
    alias pip="pip3"
}


function __python_alias() {
    case $(uname -s) in
        Darwin) __python_alias_darwin;;
        *) echo "$(basename $0): Not implemented for $(uname -s) OS" >&2;;
    esac
}


# Entry point
__python_alias
