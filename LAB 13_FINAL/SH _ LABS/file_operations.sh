#!/bin/bash
# Author: Ali Yasser
# Description: Demonstrates file redirection and error handling

touch output.txt
echo "this the 1st line" > output.txt
echo "this the additional one" >> output.txt
cat output.txt
ls not_exist.txt 2> errors.log

