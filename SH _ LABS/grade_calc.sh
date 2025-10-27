#!/bin/bash
# Author: Ali Yasser
# Description: Calculates letter grade based on score (0–100)

read -p "Enter your score (0-100): " score

# Check if input is a number between 0 and 100
if ! [[ "$score" =~ ^[0-9]+$ ]] || [ "$score" -lt 0 ] || [ "$score" -gt 100 ]; then
    echo "Error: Please enter a valid number between 0 and 100."
    exit 1
fi

# Determine the grade
if [ "$score" -ge 90 ]; then
    grade="A"
    message="Excellent work!"
elif [ "$score" -ge 80 ]; then
    grade="B"
    message="Great job!"
elif [ "$score" -ge 70 ]; then
    grade="C"
    message="Good effort!"
elif [ "$score" -ge 60 ]; then
    grade="D"
    message="You passed, but you can improve."
else
    grade="F"
    message="Sorry, you failed. Try harder next time."
fi

# Display result
echo "Your grade is: $grade"
echo "$message"

