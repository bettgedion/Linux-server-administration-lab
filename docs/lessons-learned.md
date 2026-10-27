# Lab Lessons Learned Log

## 1. Systemd Socket Activation (Ubuntu 24.04+)
* **Issue Encountered:** Modifying `/etc/ssh/sshd_config` to change the listening port had no effect on service restart. The server continued listening on default Port 22.
* **Root Cause Analysis:** Modern Ubuntu platforms use socket activation via `ssh.socket` to manage network bindings, taking precedence over application-level configuration configurations.
* **Resolution Strategy:** Implemented a systemd unit drop-in override via `sudo systemctl edit ssh.socket` to cleanly purge and reallocate the network stream to Port 2222.

## 2. Resource Conflict Management
* **Issue Encountered:** Initial Nginx installation resulted in an emergency crash (`Address already in use`).
* **Root Cause Analysis:** Pre-existing background software layers (Apache) were already actively listening on standard HTTP Port 80.
* **Resolution Strategy:** Migrated the production web application layer to custom development Port 8080, bypassing standard network runtime conflicts completely.

## 3. Automation and Security Contexts
* **Observation:** The custom automation health script failed to render listening network ports when executed by a standard user context.
* **Root Cause Analysis:** Accessing lower-level network interface metrics requires absolute root kernel visualization privileges.
* **Resolution Strategy:** Elevated runtime security credentials using `sudo` to facilitate full automation output parsing.
