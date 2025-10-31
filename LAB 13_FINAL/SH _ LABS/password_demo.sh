#!/bin/bash
# Author: Ali Yasser
# Description: Demonstrates silent input for passwords

read -p "enter username" username
read -sp "enter password" password

echo "Username entered: $username"
echo "Password is hidden for security."
