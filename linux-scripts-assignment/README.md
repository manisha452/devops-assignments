# Assignment 1: Linux Shell Scripting and Git

Two Bash scripts:

 Script 
What it does |git clone https://github.com/<your-username>/linux-scripts-assignment.git

 `sysinfo.sh` ---- Prints hostname, date/time, logged-in user, disk usage of `/`, memory usage and the top 5 processes by memory. Also saves the output to `sysinfo_YYYY-MM-DD.txt`. 
`log_report.sh` ----  Takes an access log and prints total requests, number of 404 errors and the top 3 IP addresses. 

## How to run

```bash

cd linux-scripts-assignment
chmod +x sysinfo.sh log_report.sh     # already executable in the repo

./sysinfo.sh
./log_report.sh sample_access.log
./log_report.sh                       # no file -> prints usage message
```

## Sample output: `./sysinfo.sh`



```
==============================================
 System Report
==============================================
Hostname      : DESKTOP-7QGVLHF
Date & time   : 2026-11-27 10:29:31 UTC
Logged-in user: manisha

--- Disk usage of / ---
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc       1007G  2.7G  954G   1% /

--- Memory usage ---
               total        used        free      shared  buff/cache   available
Mem:           5.7Gi       573Mi       4.9Gi       3.0Mi       452Mi       5.1Gi
Swap:          2.0Gi          0B       2.0Gi

--- Top 5 processes by memory ---
    PID USER     %MEM %CPU COMMAND
    202 root      0.3  0.1 unattended-upgr
     52 root      0.2  0.1 systemd-journal
    170 root      0.2  0.1 wsl-pro-service
      1 root      0.2  0.4 systemd
    143 systemd+  0.2  0.0 systemd-resolve

Saved to: /mnt/d/devops-assignments/linux-scripts-assignment/sysinfo_2026-11-27.txt
```

## Sample output: `./log_report.sh sample_access.log`

```
==============================================
 Log Report: sample_access.log
==============================================
Total requests : 10
404 errors     : 4

Top 3 IP addresses (count  IP):
      4 192.168.1.10
      3 10.0.0.5
      2 172.16.0.7
```

## Sample output: no argument (bonus)

```
Usage: ./log_report.sh <logfile>
Example: ./log_report.sh sample_access.log
```
