#!/bin/bash
# service_monitor.sh

process_name="dummy_process.sh"
timeout=60   # maximum wait time in seconds
interval=5   # check every 5 seconds
elapsed=0

# Start the dummy process if not already running
if ! pgrep -f "$process_name" > /dev/null; then
    echo "Starting $process_name..."
    ./dummy_process.sh &
fi

echo "Waiting for process '$process_name' to start..."

until pgrep -f "$process_name" > /dev/null
do
    sleep $interval
    elapsed=$((elapsed + interval))

    if [ $elapsed -ge $timeout ]; then
        echo "Error: Process '$process_name' did not start within $timeout seconds."
        exit 1
    fi
done

echo "Process '$process_name' is now running!"
