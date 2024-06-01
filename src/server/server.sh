#!/bin/bash

# Server port
SERVER_PORT=8080

# Log files
MESSAGE_LOG="server.log"
FILE_LOG="files/file_log.txt"

# Start the server
nc -l -p $SERVER_PORT -k > "$MESSAGE_LOG" &
echo "Server started on port $SERVER_PORT. Logs are being written to $MESSAGE_LOG."

while true; do
    action=$(gum choose "View Logs" "Stop Server" "Exit")
    case $action in
        "View Logs")
            gum pager --header "Server Logs" --content "$(cat "$MESSAGE_LOG")"
            ;;
        "Stop Server")
            kill $(jobs -p)
            echo "Server stopped."
            exit 0
            ;;
        "Exit")
            kill $(jobs -p)
            exit 0
            ;;
    esac
done