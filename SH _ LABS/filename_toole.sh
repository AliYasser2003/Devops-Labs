#!/bin/bash
# filename_tools.sh

read -p "Enter a filename (document.pdf.backup): " filename

BASE="${filename%%.*}"
EXTENSION="${filename##*.}"
NO_LAST_EXTENSION="${filename%.*}"

echo "Base name: $BASE"
echo "Extension: $EXTENSION"
echo "without last extension: $NO_LAST_EXTENSION"
