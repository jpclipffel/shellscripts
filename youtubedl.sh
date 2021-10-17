export ydl_cfg_filename="youtube-dl.conf"
export ydl_urls_filename="youtube-dl-urls.txt"
export ydl_archive_filename="youtube-dl-archive.txt"


# Updates a youtube-dl repository
# ${1}: Repository directory
function ydl_update() {
    # Assertions
    [[ -z "${1}" ]] && echo "Usage: $(basename ${0}) <directory>" && return $(false);
    [[ ! -d "${1}" ]] && echo "Error: '${1}' does not exists or is not a directory" && return $(false);
    [[ ! -f "${1}/${ydl_cfg_filename}" ]] && echo "Error: configuration file '${1}/${ydl_cfg_filename}' does not exists or is not a file" && return $(false);
    [[ ! -f "${1}/${ydl_urls_filename}" ]] && echo "Error: URLs file '${1}/${ydl_urls_filename}' does not exists or is not a file" && return $(false);
    # Update
    cd "${1}"
    youtube-dl --config-location "${ydl_cfg_filename}"
}

# (re)Configures a youtube-dl repository
# ${1}: Repository directory
function ydl_configure() {
    # Assertions
    [[ -z "${1}" ]] && echo "Usage: $(basename ${0}) <directory>" && return $(false);
    [[ ! -d "${1}" ]] && echo "Error: '${1}' does not exists or is not a directory" && return $(false);
    # Save current configuration
    if [ -f "${1}/${ydl_cfg_filename}" ]; then
        echo "Saving current youtube-dl configuration file as ${1}/${ydl_cfg_filename}.bak"
        cp "${1}/${ydl_cfg_filename}" "${1}/${ydl_cfg_filename}.bak"
    fi
    # Write new configuration
    echo "Writing youtube-dl configuration file at ${ydl_cfg_filename}"
    cat > "${1}/${ydl_cfg_filename}" << EOF
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

# Clones (intialize) a youtube-dl repository
# ${1}: Repository URL
# ${2}: Repository directory
function ydl_clone() {
    # Assertions
    [[ -z ${1} ]] || [[ -z ${2} ]] && echo "Usage: $(basename ${0}) <url> <directory>" && return 1;
    # Create & init repository
    mkdir -p "${2}"
    echo "Creating youtube-dl urls file at ${ydl_cfg_filename}"
    echo "${1}" > "${2}/${ydl_urls_filename}"
    # Configure repository
    ydl_configure "$2"
    echo "Updating repository"
    ydl_update "${2}"
}


# Echoes '[ydl]' in red when cwd is a youtube-dl repository
function ydl_ps1() {
    [[ -f "${ydl_cfg_filename}" ]] && echo "[\e[0;31mydl\e[m]"
}


# Shortcuts / aliases function to ydl_ functions
function ydl() {
    case "${1}" in
        clone) shift && ydl_clone "${@}";;
        update) shift && ydl_update "${@}";;
        reconfigure) shift && ydl_configure "${@}";;
        *) echo "Usage: $(basename ${0}) {clone|update|reconfigure}";;
    esac
}
