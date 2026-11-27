#!/usr/bin/env bash
# sysinfo.sh - prints basic system information and saves it to a dated file.
# Output file: sysinfo_YYYY-MM-DD.txt (in the directory given by $OUT_DIR, default: script dir)

OUT_DIR="${OUT_DIR:-$(cd "$(dirname "$0")" && pwd)}"
OUT_FILE="$OUT_DIR/sysinfo_$(date +%F).txt"

report() {
  echo "=============================================="
  echo " System Report"
  echo "=============================================="
  echo "Hostname      : $(hostname)"
  echo "Date & time   : $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo "Logged-in user: $(whoami)"
  echo
  echo "--- Disk usage of / ---"
  df -h /
  echo
  echo "--- Memory usage ---"
  free -h
  echo
  echo "--- Top 5 processes by memory ---"
  ps -eo pid,user,%mem,%cpu,comm --sort=-%mem | head -n 6
  echo
}

# Print to screen and append to today's file (hourly cron runs accumulate in one daily file)
report | tee -a "$OUT_FILE"
echo "Saved to: $OUT_FILE"
