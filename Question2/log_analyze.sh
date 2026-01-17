#!/bin/bash

# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Error: Please provide exactly one log file."
    exit 1
fi

logfile=$1

# Validate file exists and readable
if [ ! -f "$logfile" ] || [ ! -r "$logfile" ]; then
    echo "Error: File does not exist or is not readable."
    exit 1
fi

# Count total log entries
total=$(wc -l < "$logfile")
info=$(grep -c "INFO" "$logfile")
warning=$(grep -c "WARNING" "$logfile")
error=$(grep -c "ERROR" "$logfile")

# Most recent ERROR
latest_error=$(grep "ERROR" "$logfile" | tail -1)

# Create report file
report="logsummary_$(date +%Y-%m-%d).txt"

echo "Total log entries: $total" > "$report"
echo "INFO: $info" >> "$report"
echo "WARNING: $warning" >> "$report"
echo "ERROR: $error" >> "$report"
echo "Most recent ERROR: $latest_error" >> "$report"

# Display report
cat "$report"

