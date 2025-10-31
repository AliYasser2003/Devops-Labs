#!/bin/bash
# Author: Ali Yasser
# Description: Checks file existence and permissions

filename=$1
if [ -z "$filename" ]; then
echo "usage: $0 <filename>"
exit 1
fi

if [ -e "$filename" ]; then
echo "file '$filename' exists"
[ -r "$filename" ] && echo "it is readable" || echo "it is not readable"
[ -w "$filename" ] && echo "it is writable" || echo "it is not writable"
[ -x "$filename" ] && echo "it is executable" || echo "it is not executable"

else

echo "file '$filename' does not exist"
read -p "do u want to create it? (Y/N):" ANSWER

if [[ "$ANSWER" == "Y" || "$ANSWER" == "y" ]]; then
touch "$filename"
echo "file '$filename' created successfully"
else
echo "file not created"
fi
fi
