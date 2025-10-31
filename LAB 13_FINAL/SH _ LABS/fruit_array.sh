#!/bin/bash
# fruit_array.sh
# Create an array of 5 fruits
fruits=("banana" "apple" "watermelon" "mango" "orage")
echo "all fruits ${fruits[@]}"
echo "number of all fruits ${#fruits[@]}"
echo "1st item of fruit ${fruits[0]}"
echo "last item of fruit ${fruits[4]}"

