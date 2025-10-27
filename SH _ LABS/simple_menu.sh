#!/bin/bash
# Author: Ali Yasser
# Description: Displays a simple menu using case statement

while true; do
    echo "======================"
    echo "     SIMPLE MENU"
    echo "======================"
    echo "1) Show Date and Time"
    echo "2) Show Calendar"
    echo "3) Show Logged-in Users"
    echo "4) Exit"
    echo "======================"
    read -p "Enter your choice [1-4]: " choice

case $choice in

1)echo "current date and time:"
date
;;


2)echo "current month:"
cal
;;

3)echo "current user:"
who
;;

4)echo "bye"
break
;;

*)echo "invalid option choice only from 1 to 4"
;;
esac
done
