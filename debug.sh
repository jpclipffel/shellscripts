__DEBUG_BASENAME=$(basename $0)


function __debug_echo() {
    echo "[${__DEBUG_BASENAME}] ${@}"
}


# macOS (Darwin) tests
function __debug_darwin() {
    # [Check] Is xcrun installed ?
    xcrun --version &> /dev/null || __debug_echo "Command 'xcrun' failed: try (re)installing Xcode toolkit: xcode-select --install"
    # [Check] Is brew installed ?
    type brew &> /dev/null || __debug_echo "brew is not installed: install it from https://brew.sh/"
    # [Debug] Remove signature control for VSCode render to avoid shell lagging
    # See https://github.com/microsoft/vscode/issues/105446
    if [ -e "/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Renderer).app" ]; then
        codesign --remove-signature "/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Renderer).app"
    fi
}


# Linux tests
function __debug_linux() {}


# Run implicit functions
case  $(uname -s) in
    Darwin*) __debug_darwin;;
    Linux) __debug_linux;;
esac

