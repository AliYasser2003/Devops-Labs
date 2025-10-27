#!/bin/bash
# Author: Ali Yasser
# Description: Demonstrates basic debugging with set -x

set -x

mkdir demo

cd demo

touch file.txt

cd ..

set +x

echo "Debugging complete"
