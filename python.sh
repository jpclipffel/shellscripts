#!/bin/bash


PYTHON_VERSION_MAJOR="3"
PYTHON_VERSION_MINOR="8"
PYTHON_VERSION_PATCH="1"


function __python_alias_darwin() {
    export PATH="$(brew --prefix)/Cellar/python@${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.${PYTHON_VERSION_PATCH}/bin:$PATH"
    export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH
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
