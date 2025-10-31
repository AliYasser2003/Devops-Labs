#!/bin/bash
# Backup script for finalproject

timestamp=$(date +"%Y%m%d_%H%M%S")
tar -czvf ~/finalproject/backup/finalproject_$timestamp.tar.gz ~/finalproject

echo "✅ Backup created successfully: finalproject_$timestamp.tar.gz"
