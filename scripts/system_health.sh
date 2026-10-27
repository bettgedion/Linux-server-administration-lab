#!/bin/bash

# 1. Header Information
echo "==========================================="
echo "        SERVER HEALTH REPORT - $(date)     "
echo "==========================================="

# 2. Check Disk Space Usage
echo -e "\n[+] Storage Disk Usage:"
df -h / | awk 'NR==2 {print "Used: " $3 " / Total: " $2 " (" $5 " Utilized)"}'

# 3. Check System Memory (RAM) Usage
echo -e "\n[+] System Memory Usage:"
free -h | awk 'NR==2 {print "Used: " $3 " / Total: " $2}'

# 4. Check Network Listening Ports
echo -e "\n[+] Active Admin & Web Ports:"
ss -tulpn | grep -E 'sshd|nginx' | awk '{print "Service Listening on Port: " $5}'
echo "==========================================="


