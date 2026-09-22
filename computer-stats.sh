#!/usr/bin/env bash
# Workstation Vital Signs Monitor

clear
echo "=================================================="
echo "          WORKSTATION HEARTBEAT & STATS           "
echo "=================================================="
echo "Timestamp : $(date '+%Y-%m-%d %H:%M:%S')"
echo "Hostname  : $(hostname)"
echo "Uptime    : $(uptime -p)"
echo "Kernel    : $(uname -sr)"
echo "=================================================="

# 1. RAM Utilization
echo -e "\n[+] Memory Usage:"
free -h | awk 'NR==1{print "      "$1"       "$2"       "$3} NR==2{print "RAM:  "$2"     "$3"     "$4}'

# 2. CPU Load Average
echo -e "\n[+] CPU Load (1m, 5m, 15m):"
awk '{print "      " $1 ", " $2 ", " $3}' /proc/loadavg

# 3. Primary Storage Status
echo -e "\n[+] Disk Space (Root Partition):"
df -h / | awk 'NR==1{print "      "$2"     "$3"    "$4"    "$5"  "$6} NR==2{print "Root: "$1"    "$2"    "$3"    "$4"   "$5}'

# 4. Network Status (IP Addresses & Link Status)
echo -e "\n[+] Active Network Interfaces:"
ip -br addr show | grep -v "127.0.0.1" || echo "      No active external IP addresses found."
echo "=================================================="
