__S3CMD_CONF_DIR="${HOME}/.s3cmd"
__S3CMD_CONF_CUR="${HOME}/.s3cfg"


# List existing s3cmd configuration
function s3cmdgc() {
    ls "${__S3CMD_CONF_DIR}"
}


# Enable an s3cmd configuration
# $1: s3cmd configuration name
function s3cmduc() {
    local src="${__S3CMD_CONF_DIR}/${1}"
    if [ -f "${src}" ]; then
        if [ -L "${__S3CMD_CONF_CUR}" ]; then rm "${__S3CMD_CONF_CUR}"; fi
        ln -s "${src}" "${__S3CMD_CONF_CUR}"
    else
        echo "ERROR: Configuration file ${src} not found"
    fi
}


# S3cmd context name PS1
function s3cmd_ps1() {
    # [[ "${S3CMD_PS1_ENABLED}" == "on" ]] && echo "[${red}s3cmd:${purple}$(basename $(readlink ~/.s3cfg))${reset_color}] " || return
    if [[ "${S3CMD_PS1_ENABLED}" == "on" ]]; then
        echo "[${red}s3cmd:${purple}$(basename $(readlink ~/.s3cfg))${reset_color}] "
    else
        return
    fi
}


# Enable S3cmd PS1
function s3cmd_ps1_on() {
    export S3CMD_PS1_ENABLED="on"
}


# Disable S3cmd PS1
function s3cmd_ps1_off() {
    export S3CMD_PS1_ENABLED="off"
}
