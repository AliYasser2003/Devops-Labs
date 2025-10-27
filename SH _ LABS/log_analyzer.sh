#!/bin/bash

# 1. Make a fake log file
echo "creating log file..."
cat > system.log <<EOF
2025-10-16 09:00:01 INFO  System started successfully
2025-10-16 09:05:14 ERROR Failed to connect to database
2025-10-16 09:10:25 INFO  User login successful
2025-10-16 09:12:30 ERROR Disk space low
2025-10-16 09:15:00 INFO  Backup completed
EOF

# 2. Show only the timestamps (date + time)
echo "Timestamps only:"
cut -d' ' -f1,2 system.log
echo ""

# 3. Count how many ERROR and INFO messages
error_count=$(grep -c "ERROR" system.log)
info_count=$(grep -c "INFO" system.log)

# 4. Show final summary
echo "===== Log Summary ====="
echo "Total lines: $(wc -l < system.log)"
echo "INFO messages: $info_count"
echo "ERROR messages: $error_count"
echo "======================="
