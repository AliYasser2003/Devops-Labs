#!/bin/bash
# Author: Ali Yasser
# Description: Validates that user input for age is numeric

while true;do
read -p "enter your age:" age
if [[ "$age" =~ ^[0-9]+$ ]]; then
if [ "$age" -lt 13 ]; then
echo "u r  child"
elif [ "$age" -lt 20 ]; then
echo "u r teen"
elif [ "$age" -lt 60 ]; then
echo "u r adult"
else
echo "u r senior"
fi
break
else
echo "invalid input"
fi
done
