#!/bin/bash
# guessing_game.sh

target=$((RANDOM % 10 + 1))
attempts=0
guess=0

echo "welcome to guessing game"
echo "i have chosen no. between 1 and 10. can u guesss it?"

while [ "$guess" -ne "$target" ]
do
read -p "enter your guess" guess
attempts=$((attempts+1))

if [ "$guess" -lt "$target" ]; then
echo "higher"

elif [ "$guess" -gt "$target" ]; then
echo "lower"
 else
echo "congratulations u guessed in $attempts attempts."
fi
done
