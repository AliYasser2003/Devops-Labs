#!/bin/bash
# Test exit codes using ls
echo "listing existing dir (/home):"
ls /home
echo "exit code: $?"

echo "listing non-existing dir (/fake):" 
ls /fake
echo "exit code: $?"

exit 0
