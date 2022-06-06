# Shell scripts - Various Shell scripts

## Installation

Add the following snippet to thr Shell configuration file (`.zshrc`, `.bashrc`, etc.):

```bash
# Replace <shellscripts> by the local repository path:
for script in shellscripts/*.sh; do
    source ${script}
done
```
