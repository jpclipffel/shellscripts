function __vimc_cutpaste() {
    cat << EOF
yy      yank (copy) a line
2yy     yank (copy) 2 lines
:n,Ny   yank lines n through N
yw      yank (copy) word
y$      yank (copy) to end of line
p       put (paste) the clipboard after cursor
P       put (paste) before cursor
dd      delete (cut) a line
2dd     delete (cut) 2 lines
:n,Nd   delete lines n through N
dw      delete (cut) word
D       delete (cut) to the end of the line
d$      delete (cut) to the end of the line
x       delete (cut) character
EOF
}


function __vimc_cursor() {
    cat << EOF
h   move cursor left
j   move cursor down
k   move cursor up
l   move cursor right
w   jump forwards to the start of a word
W   jump forwards to the start of a word (words can contain punctuation)
e   jump forwards to the end of a word
E   jump forwards to the end of a word (words can contain punctuation)
b   jump backwards to the start of a word
B   jump backwards to the start of a word (words can contain punctuation)
0   jump to the start of the line
^   jump to the first non-blank character of the line
$   jump to the end of the line
G   go to the last line of the document
nG  go to line number n
:n  go to line number n
}   jump to next paragraph
{   jump to previous paragraph
H   jump to home (top) of screen
L   jump to last line of screen
M   jump to middle of screen
EOF
}


function __vimc_topics() {
    cat << EOF
cp, cut, paste          Cut and paste
cur, cursor, move, mv   Cursor movement
EOF
}



function vimc() {
    case "${1}" in
        cut|paste|cp) __vimc_cutpaste;;
        cur|cursor|move|mv) __vimc_cursor;;
        *) __vimc_topics;;
    esac
}
