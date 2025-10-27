#!/bin/bash
# multiplication_table.sh
# Create a multiplication table for numbers 1-5

echo "Multiplication Table (1-5)"

for i in {1..5}
do
for j in {1..5}
do
result=$((i*j))
printf "%3d" $result
done
echo
done
