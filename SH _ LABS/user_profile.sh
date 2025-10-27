#!/bin/bash
# Author: Ali Yasser
# Description: Asks user for personal info and displays it

read -p "enter your name" name
read -p "enter your age" age
read -p "enter your city" city

echo "name is: $name"
echo "age is: $age"
echo "You live in: $city"
