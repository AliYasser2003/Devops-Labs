#!/bin/bash
while true; do
  # Respond with proper HTTP headers and message
  { 
    echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nBackend Response from Ali";
  } | nc -l -p 5000 -q 1
done

