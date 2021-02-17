function __python_alias_darwin() {
    export DYLD_LIBRARY_PATH=$(brew --prefix)/opt/openssl/lib:$DYLD_LIBRARY_PATH
    alias python="python3"
    alias pip="pip3"
}


function pip_upgrade_all() {
    local frozen=$(mktemp)
    pip list --outdated --format=freeze | cut -d '=' -f 1 > ${frozen}
    pip install --upgrade -r ${frozen}
    rm ${frozen}
}


# Run implicits functions
case $(uname -s) in
    Darwin) __python_alias_darwin;;
esac

