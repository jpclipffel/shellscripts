# Echoes the current pointer location
function mouse_loc() {
    echo xdotool getmouselocation \
    | sed 's/x:\([0-9]\+\) y:\([0-9]\+\).*/\1 \2/'
}


# Shake mouse pointer
function mouse_shake() {
    # read -r x y $(pointer_loc)
    while [[ 1 ]]; do
        xdotool mousemove_relative -- -1 1
        xdotool mousemove_relative -- 1 -1
    done
}
