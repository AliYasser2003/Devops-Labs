#!/bin/bash
# text_replace.sh

read -p "input the text:" text
read -p "input the word u want to replace:" old
read -p "input the new word:" new

echo ""
echo "orginal: $text"

first_replace=$(echo "$text" | sed "s/$old/$new/")
all_replace=$(echo "$text" | sed "s/$old/$new/g")

echo "After first replacement: $first_replace"
echo "After all replacements: $all_replace"
