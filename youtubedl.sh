export ydl_cfg_filename="youtube-dl.conf"
export ydl_urls_filename="youtube-dl-urls.txt"
export ydl_archive_filename="youtube-dl-archive.txt"


# Updates a youtube-dl repository
# ${1}: Repository directory
function ydl_update() {
    local dir="${1:-.}"
    # Assertions
    [[ -z "${dir}" ]] && echo "Usage: $(basename ${0}) <directory>" && return $(false);
    [[ ! -d "${dir}" ]] && echo "Error: '${1}' does not exists or is not a directory" && return $(false);
    [[ ! -f "${dir}/${ydl_cfg_filename}" ]] && echo "Error: configuration file '${dir}/${ydl_cfg_filename}' does not exists or is not a file" && return $(false);
    [[ ! -f "${dir}/${ydl_urls_filename}" ]] && echo "Error: URLs file '${dir}/${ydl_urls_filename}' does not exists or is not a file" && return $(false);
    # Update
    cd "${dir}"
    youtube-dl --config-location "${ydl_cfg_filename}"
    cd "${OLDPWD}"
}


# Updates all youtube-dl repositories found in current directory
function ydl_update_all() {
    for repo in ./*; do
        if [[ -d "${repo}" ]] && [[ -f "${repo}/${ydl_cfg_filename}" ]] && [[ -f "${repo}/${ydl_urls_filename}" ]]; then
            ydl_update "${repo}"
        fi
    done
}

# (re)Configures a youtube-dl repository
# ${1}: Repository directory
function ydl_configure() {
    local dir="${1:-.}"
    # Assertions
    [[ -z "${dir}" ]] && echo "Usage: $(basename ${0}) <directory>" && return $(false);
    [[ ! -d "${dir}" ]] && echo "Error: '${dir}' does not exists or is not a directory" && return $(false);
    # Save current configuration
    if [ -f "${dir}/${ydl_cfg_filename}" ]; then
        echo "Saving current youtube-dl configuration file as ${dir}/${ydl_cfg_filename}.bak"
        cp "${dir}/${ydl_cfg_filename}" "${dir}/${ydl_cfg_filename}.bak"
    fi
    # Write new configuration
    echo "Writing youtube-dl configuration file at ${ydl_cfg_filename}"
    cat > "${dir}/${ydl_cfg_filename}" << EOF
# General Options
--ignore-errors

# Video Selection
--download-archive "${ydl_archive_filename}"

# Filesystem options
--batch-file "${ydl_urls_filename}"
--restrict-filenames
--no-overwrites
--continue

# Video Format Options
--format "best"

EOF
}


# Initializes a youtube-dl repository
# ${1}: Repository URL
# ${2}: Repository directory
function ydl_init() {
    # Assertions
    [[ -z ${1} ]] || [[ -z ${2} ]] && echo "Usage: $(basename ${0}) <url> <directory>" && return 1;
    # Create & init directory
    mkdir -p "${2}"
    echo "Creating youtube-dl urls file at ${ydl_cfg_filename}"
    echo "${1}" > "${2}/${ydl_urls_filename}"
    # Configure repository
    ydl_configure "${2}"
}


# Clones (initialize) a youtube-dl repository
# ${1}: Repository URL
# ${2}: Repository directory
function ydl_clone() {
    # Assertions
    [[ -z ${1} ]] || [[ -z ${2} ]] && echo "Usage: $(basename ${0}) <url> <directory>" && return 1;
    # Clone repository
    ydl_init "${1}" "${2}"
    echo "Updating repository"
    ydl_update "${2}"
}


# Echoes '[ydl]' in red when cwd is a youtube-dl repository
function ydl_ps1() {
    [[ -f "${ydl_cfg_filename}" ]] && echo "[ydl]" || return
}


# The ydl verb-noun interface
function ydl() {
    case "${1}" in
        init) shift && ydl_init "${@}";;
        clone) shift && ydl_clone "${@}";;
        update) shift && ydl_update "${@}";;
        update-all) shift && ydl_update_all "${@}";;
        reconfigure) shift && ydl_configure "${@}";;
        *) echo "Usage: $(basename ${0}) {init|clone|update|update-all|reconfigure}";;
    esac
}
