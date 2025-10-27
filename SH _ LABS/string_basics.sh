#!/bin/bash
# string_basics.sh

read -p "enter a sentence:" sentence

length=${#sentence}
echo "length of the sentencce: $length"
echo "uppercase: ${sentence^^}"
echo "lowercase: ${sentence,,}"
echo "First 10 characters: ${sentence:0:10}"
