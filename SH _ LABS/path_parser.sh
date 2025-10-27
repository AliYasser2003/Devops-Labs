#!/bin/bash
# path_parser.sh



read -p "Enter a full file path: " filepath

dirpath="${filepath%/*}"

filename="${filepath##*/}"

if [[ "$filepath" == /* ]]; then
    type="Absolute Path"
else
    type="Relative Path"
fi

echo ""
echo "Directory path: $dirpath"
echo "Filename: $filename"
echo "Path type: $type"
