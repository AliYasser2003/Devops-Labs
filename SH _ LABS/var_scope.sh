#!/bin/bash
# Author: Ali Yasser
# Description: Demonstrates shell vs environment variables

LOCAL_VAR="local"
export GLOBAL_VAR="global"
bash child_script.sh
