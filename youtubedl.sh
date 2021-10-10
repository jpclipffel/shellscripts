export ydl_cfg_filename="youtube-dl.conf"
export ydl_urls_filename="youtube-dl-urls.txt"


# Update a youtube-dl repository
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

# Clone (intialize) a youtube-dl repository
function ydl_clone() {
    # Assertions
    [[ -z ${1} ]] || [[ -z ${2} ]] && echo "Usage: $(basename ${0}) <url> <directory>" && return 1;
    # Create & init repository
    mkdir -p "${2}"
    echo "Creating youtube-dl urls file at ${ydl_cfg_filename}"
    echo "${1}" > "${2}/${ydl_urls_filename}"
    echo "Creating youtube-dl configuration file at ${ydl_cfg_filename}"
    cat > "${2}/${ydl_cfg_filename}" << EOF
# Filesystem options
--batch-file "${ydl_urls_filename}"
--restrict-filenames
--no-overwrites
--continue

# Video Format Options
--format "best"

EOF
    echo "Updating repository"
    ydl_update "${2}"
}


# Shortcuts / aliases function to ydl_ functions
function ydl() {
    case "${1}" in
        clone) shift && ydl_clone "${@}";;
        update) shift && ydl_update "${@}";;
        *) echo "Usage: $(basename ${0}) {clone|update}";;
    esac
}
