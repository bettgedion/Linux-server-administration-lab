# Infrastructure Incident & Resolution Log

## Incident #001: Nginx Service Initialization Failure (Port Contention)
* **Date:** October 27, 2026
* **Severity:** Medium (Service Blocked)
* **Impact:** Nginx web engine failed to boot up, resulting in a `status=1/FAILURE` system error.

### 1. Symptoms & Error Identification
When running `sudo systemctl status nginx`, the service manager reported an emergency bind failure:
`nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)`

### 2. Root Cause Analysis (RCA)
A standard network interface scan revealed that standard HTTP **Port 80** was already actively occupied by a pre-installed Apache background process running inside the kernel environment. 

### 3. Resolution Plan & Action Taken
To avoid interrupting the existing process layout, a strategic decision was made to migrate Nginx to an alternative application development port. 
* Modified `/etc/nginx/sites-available/default` 
* Swapped listening configurations from `80` to **`8080`**.
* Restarted service via `systemctl`. Service state successfully updated to `active (running)`.

---

## Incident #002: SSH Configuration Overrides Ignored (Systemd Socket Precedence)
* **Date:** October 27, 2026
* **Severity:** High (Security Compliance Flaw)
* **Impact:** Modifying security parameters in `sshd_config` failed to alter the server's listening port; the application remained vulnerable on default Port 22.

### 1. Symptoms & Error Identification
Even after making direct edits to `/etc/ssh/sshd_config` and restarting the application daemon, a network socket verification scan (`sudo ss -tulpn | grep sshd`) confirmed the server was still listening on `*:22` instead of the required hardened port `2222`.

### 2. Root Cause Analysis (RCA)
Modern Ubuntu server distributions utilize **Systemd Socket Activation** (`ssh.socket`). The systemd system manager handles the low-level network interface allocation on boot, passing connections to the application later. Changes made directly inside the application-level `sshd_config` file are entirely overridden by the socket manager.

### 3. Resolution Plan & Action Taken
An administrative drop-in configuration override file was built to alter the underlying system core:
* Executed `sudo systemctl edit ssh.socket` to create a dedicated configuration override block.
* Appended empty `ListenStream=` parameters to clear default settings, followed by `ListenStream=2222`.
* Executed a full system kernel daemon reload (`systemctl daemon-reload`) and completely recycled the socket pipeline. 
* Final network validation confirmed complete system migration to **Port 2222**.
