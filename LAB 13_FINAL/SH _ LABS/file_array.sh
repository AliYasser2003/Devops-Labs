files=(*)
file_count=0
dir_count=0

for f in "${files[@]}"
do
if [ -f "$f" ]; then
size=$(stat -c%s "$f")
echo "file: $f, size: $size bytes"
file_count=$((file_count + 1))
elif [ -d "$f" ]; then
echo "directory: $f"
dir_count=$((dir_count + 1))
fi
done
echo "Total regular files: $file_count"
echo "Total directories: $dir_count"
