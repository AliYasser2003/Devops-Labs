#!/bin/bash
# file_processor.sh

for file in *.txt; do
if [ -e "$file" ]; then
line_count=$(wc -l < "$file")
echo "file: $file, lines $line_count"

cp "$file" "$file.bak"
echo "created backup: $file.bak"
else
echo "no .txt files found in current directory"
break
fi
done
