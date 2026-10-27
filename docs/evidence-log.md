# Engineering Evidence Log

## [Module 1] System Engineering & Security Infrastructure

---

### Task 1: Secure OpenSSH Hardening
* **Objective:** Install OpenSSH Server and secure access interfaces against brute-force attacks.
* **Status:** Verified & Active
* **Configuration Location:** `configs/sshd_config` & `configs/ssh_socket_override.conf`

#### Implementation Steps
1. Packages updated via apt package manager and `openssh-server` successfully initialized.
2. Modified application parameters within `/etc/ssh/sshd_config` to explicitly restrict root authorization credentials (`PermitRootLogin no`) and lower error drops (`MaxAuthTries 3`).
3. Overrode underlying systemd socket listener settings to successfully change traffic streams to custom hardened network port `2222`.

#### System Validation Metrics
* **Command Executed:** `sudo ss -tulpn | grep sshd`
* **Output Log Verified:** `tcp LISTEN 0 128 [::]:2222 [::]:* users:(("sshd",pid=...))`

---

### Task 2: Production Web Application Infrastructure
* **Objective:** Deploy an Nginx web engine and resolve existing network interface conflicts.
* **Status:** Verified & Active
* **Configuration Location:** `configs/nginx_default_site`

#### Implementation Steps
1. Initialized Nginx engine deployment. Resolved a critical port contention error (`Address already in use`) caused by a legacy Apache process occupying standard HTTP Port 80.
2. Reconfigured site routing metrics inside Nginx deployment directories to handle traffic on development port `8080`.
3. Created a customized HTML application landing profile reflecting standard administrator verification attributes.

#### System Validation Metrics
* **Command Executed:** `sudo ss -tulpn | grep nginx`
* **Output Log Verified:** `tcp LISTEN 0 511 0.0.0.0:8080 0.0.0.0:* users:(("nginx",pid=...))`
* **Browser Runtime Check:** Verified connection layout at `http://localhost:8080` matches styled template parameters.

---

### Task 3: Kernel Core Diagnostics & Automation
* **Objective:** Develop an automated Shell engine to scrape internal storage, RAM allocation, and network sockets.
* **Status:** Verified & Active
* **Script Location:** `scripts/system_health.sh`

#### Implementation Steps
1. Programmed a native structured Bash script incorporating shebang command parameters and environmental evaluations.
2. Filtered and structured kernel outputs into human-readable format fields utilizing advanced text stream pattern matching tools (`awk`).
3. Applied administrative system privileges modifications (`chmod +x`) to convert the text document into a program executable layer.

#### Automation Outputs Log Summary
* **Command Executed:** `sudo ./scripts/system_health.sh`
* **Reports Gathered:** Storage disk usage metrics parsed, active hardware memory blocks summarized, and working listening port allocations validated dynamically.
