#!/bin/bash
# dynamic_array.sh

# Start with an empty array
items=()

echo "Enter items to add to the list (type 'done' to finish):"

# Keep asking the user until they type "done"
while true
do
    read -p "Add item: " input
    if [ "$input" == "done" ]; then
        break
    fi
    items+=("$input")   # Add new item to the array
done

echo
echo "Final list of items:"
echo "${items[@]}"      # Display all items

# Ask the user which index to remove
read -p "Enter number start from zero to remove item: " index

# Check if the index is valid
if [ "$index" -ge 0 ] && [ "$index" -lt "${#items[@]}" ]; then
    unset 'items[index]'    # Remove the item
    echo "Item removed successfully."
else
    echo "Invalid index."
fi

echo
echo "Updated list of items:"
echo "${items[@]}"

