#!/bin/bash
# Author: Ali Yasser
# Description: Compares two numbers given as arguments

num1=$1
num2=$2

if [ $# -ne 2 ]; then
echo "usage: $0 <num1> <num2>"
exit 1
fi

if ! [[ "$num1" =~ ^-?[0-9]+$ && "$num2" =~ ^-?[0-9]+$ ]]; then
echo "error both numbers are valid"
exit 1
fi

if [ "$num1" -gt "$num2" ]; then

echo "$num1" is greater than "$num2"
elif [ "$num2" -gt "$num1" ]; then

echo "$num2" is greater than "$num1"
else
echo "both numbers are equal"
 fi
