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
| `debug`         | Implicit  | -                    | Run debugs/controls/checks      |
| `python.sh`     | Both      | `pip_`               | Aliases Python and Python tools |
| `ssh.sh`        | Functions | `ssh_`               | SSH client snippets             |
| `dns.sh`        | Functions | `dns_`               | Local DNS snippets              |
| `nmap.sh`       | Functions | `nmap_`              | NMap snippets                   |
| `java.sh`       | Functions | `java`               | Properly bind `java` command    |
| `airport.sh`    | Functions | `airport`            | Properly bind `airport` command |
| `kubernetes.sh` | Functions | `k8s_`               | Some K8S helpers                |
