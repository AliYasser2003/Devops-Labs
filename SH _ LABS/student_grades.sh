#!/bin/bash
# student_grades.sh

# Declare associative array
declare -A grades
grades["Ali"]=90
grades["Mohamed"]=80
grades["Mahmoud"]=70
grades["Abdo"]=60
grades["Omar"]=55
echo "student grade:"
for student in "${!grades[@]}"
do
echo "$student: ${grades[$student]}"
done
total=0
count=0
for grade in "${grades[@]}"
do
total=$((total + grade))
count=$((count + 1))
done
average=$((total / count))
echo "average grade: $average"
