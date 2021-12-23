# Shell scripts - Various Shell scripts

## Installation

Add the following snippet to your Shell configuration file (`.zshrc`, `.bashrc`, etc.):

```bash
# Replace <shellscripts> by the local repository path:
for script in shellscripts/*.sh; do
    source ${script}
done
```

## Usage

Two types of scripts are available:

* **Implicit**: run once at Shell startup
* **Functions**: exposes functions with a common naming pattern, e.g. `dns_`

| Script          | Type      | Functions pattern(s) | Description                     |
|-----------------|-----------|----------------------|---------------------------------|
| `debug.sh`      | Implicit  | -                    | Run debugs/controls/checks      |
| `python.sh`     | Both      | `pip_`, `*env*       | Aliases Python and Python tools |
| `ssh.sh`        | Functions | `ssh_`               | SSH client snippets             |
| `dns.sh`        | Functions | `dns_`               | Local DNS snippets              |
| `nmap.sh`       | Functions | `nmap_`              | NMap snippets                   |
| `java.sh`       | Functions | `java`               | Properly bind `java` command    |
| `airport.sh`    | Functions | `airport`            | Properly bind `airport` command |
| `kubernetes.sh` | Functions | `k8s_`               | Some K8S helpers                |
| `youtubedl.sh`  | Functions | `ydl`, `ydl_`        | Youtube-DL helpers              |
| `ansible.sh`    | Functions | `ansible_`           | Ansible helpers                 |
| `brew.sh`       | Functions | `brew_`              | Brew helpers                    |

## Scripts

### `debug.sh`

Run checks at Shell startup.

### `python.sh`

* `__python_select_darwin`: Setup the proper Python environement on macOS
* `pip_upgrade_all`: Upgrade all Python packages at once
* `venvs`: List virtual envs
* `aenv`: Activate a virtual env

### `ssh.sh`

* `ssh_hosts`: Lists SSH hosts

### `dns.sh`

* `dns_flush`: Flushes chached hosts

### `nmap.sh`

* `nmap_discover`: Runs a full NMap scan
* `nmap_discover_fast`: Runs a fast NMap scan

### `java.sh`

* `java`: Runs Java

### `airport.sh`

* `airport`: Runs Airport CLI

### `kubernetes.sh`

* `k8s_merge_configs`: Merges local Kubeconfigs into a single one

### `youtubedl.sh`

* `ydl_clone`: Adds Youtube-dl configuration files to a directory and download videos
* `ydl_update`: Downloads new videos
* `ydl_configure`: Updates Youtube-dl configuration files
* `ydl_ps1`: Echoes `[ydl]` in a Youtube-dl repository
* `ydl`: Wrapper around other `ydl_*` command

### `ansible.sh`

* `ansible_install`: Install Ansible
* `ansible_update`: Update Ansible

### `brew.sh`

* `brew_ps1`: Echoes Brew status information as `[brew:{outdated count}]`
