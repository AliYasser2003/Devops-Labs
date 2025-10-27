#!/bin/bash
# Author: Ali Yasser
# Description: Demonstrates default argument values in Bash

username=${1:-guest}
greeting=${2:-hello}

echo "$greeting,$username"
