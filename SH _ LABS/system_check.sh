#!/bin/bash
# Author: Ali Yasser
# Description: Checks basic system requirements

echo "=== System Requirements Check ==="

# 1. Check free disk space (at least 1GB = 1,048,576 KB)
disk_free=$(df / --output=avail | tail -1)
required_space=$((1024*1024))

if [ "$disk_free" -lt "$required_space" ]; then
    echo "Not enough disk space. Less than 1GB available."
else
    echo "Sufficient disk space available."
fi

# 2. Check if 'curl' or 'git' is installed
if command -v curl >/dev/null 2>&1; then
    echo "'curl' is installed."
else
    echo "'curl' is NOT installed."
fi

if command -v git >/dev/null 2>&1; then
    echo "'git' is installed."
else
    echo "'git' is NOT installed."
fi

# 3. Check if running as root or regular user
if [ "$EUID" -eq 0 ]; then
    echo "You are running this script as ROOT."
else
    echo "Running as a regular user ($USER)."
fi

echo "=== System Check Complete ==="

