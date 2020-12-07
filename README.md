# Shell scripts - Various Shell scripts

## Installation

Add the following snippet to your Shell configuration file (`.zshrc`, `.bashrc`, etc.):

```bash
# Replace <shellscripts> by the local repository path:
for script in shellscripts/*.sh; do
    source ${script}
done
```

## Scripts

| File         | Type      | Functions pattern | Description                     |
|--------------|-----------|-------------------|---------------------------------|
| `dns.sh`     | Functions | `dns_`            | Manages local DNS               |
| `python.sh`  | Implicit  | -                 | Aliases Python and Python tools |
| `nmap.sh`    | Functions | `nmap_`           | NMap snippets                   |
| `java.sh`    | Functions | `java`            | Properly bind `java` command    |
| `airport.sh` | Functions | `airport`         | Properly bind `airport` command |
