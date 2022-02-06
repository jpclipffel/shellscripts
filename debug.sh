__DEBUG_BASENAME=$(basename $0)


function __debug_echo() {
    echo "[${__DEBUG_BASENAME}] ${@}"
}


# macOS (Darwin) tests
function __debug_darwin()
{
    # [Check] Is xcrun installed ?
    # This is required to run 'brew'.
    xcrun --version &> /dev/null || __debug_echo "Command 'xcrun' failed: try (re)installing Xcode toolkit: xcode-select --install"

    # [Check] Is brew installed ?
    # The script 'brew.sh' overwrite the command 'brew' and use Brew's path through the variable ${__BREW}.
    # First condition check if the variable ${__BREW} is set; Otherwise fallback to standard command existence check.
    if [[ -n "${__BREW+1}" ]]; then
        [[ -f "${__BREW}" ]] || echo "Brew not found in '${__BREW}': set \${__BREW} and/or install Brew from https://brew.sh"
    else
        type brew &> /dev/null || __debug_echo "brew is not installed: install it from https://brew.sh/"
    fi

    # [Debug] Remove signature control for VSCode render to avoid shell lagging
    # See https://github.com/microsoft/vscode/issues/105446
    # if [ -e "/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Renderer).app" ]; then
    #    codesign --remove-signature "/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Renderer).app" &> /dev/null
    # fi
}


# Linux tests
function __debug_linux() {}


# Run implicit functions
case  $(uname -s) in
    Darwin*) __debug_darwin;;
    Linux) __debug_linux;;
esac
