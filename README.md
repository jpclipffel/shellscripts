# Shell scripts

## Installation

Add the following in the Shell configuration file (`.zshrc`, `.bashrc`, etc.):

```bash
# Custom :: Scripts
SCRIPTS_HOME="${HOME}/Projects/jpclipffel/shellscripts"
SCRIPTS_LIST=(
    "shell"
    "macos"
    "brew"
    # ...
    # Add and remove script name (without extension) as needed
)
for script in ${SCRIPTS_LIST[@]}; do
    source "${SCRIPTS_HOME}/${script}.sh"
done
```
