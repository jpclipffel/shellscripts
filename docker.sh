# Echoes the Docker PS1
function docker_ps1() {
    [[ "${DOCKER_PS1_ENABLED}" == "on" ]] && echo "[${blue}docker:${purple}$(docker context show)${reset_color}] " || return
}


# Enable Docker PS1
function docker_ps1_on() {
    export DOCKER_PS1_ENABLED="on"
}


# Disable Docker PS1
function docker_ps1_off() {
    export DOCKER_PS1_ENABLED="off"
}


# List docker context
alias dcgc="docker context list"


# Use a docker context
alias dcuc="docker context use"


# Disable Docker PS1 by default
docker_ps1_off
