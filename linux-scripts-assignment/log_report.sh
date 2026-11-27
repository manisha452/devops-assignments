#!/usr/bin/env bash
# log_report.sh - summarises a web server access log (Apache/Nginx common or combined format).
# Usage: ./log_report.sh <logfile>

if [ $# -lt 1 ]; then
  echo "Usage: $0 <logfile>"
  echo "Example: $0 sample_access.log"
  exit 1
fi

LOG="$1"

if [ ! -f "$LOG" ] || [ ! -r "$LOG" ]; then
  echo "Error: '$LOG' does not exist or is not readable." >&2
  exit 2
fi

total=$(wc -l < "$LOG")
# In common/combined log format the status code is field 9
errors_404=$(awk '$9 == 404' "$LOG" | wc -l)

echo "=============================================="
echo " Log Report: $LOG"
echo "=============================================="
echo "Total requests : $total"
echo "404 errors     : $errors_404"
echo
echo "Top 3 IP addresses (count  IP):"
awk '{print $1}' "$LOG" | sort | uniq -c | sort -rn | head -n 3
