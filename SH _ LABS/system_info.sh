#!/bin/bash
# Displays system information using command substitution

current_date=$(date)
username=$(whoami)
number_of_files=$(ls | wc -l)
homedir_usage=$(du -sh)




echo "Current Date and Time:$current_date"

echo "Your Username:$username"

echo "Number of files in the current directory:$number_of_files"

echo "Current disk usage of the home directory:$homedir_usage"

