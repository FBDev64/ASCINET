#!/bin/bash

# Server port
SERVER_PORT=8080

# Log files
MESSAGE_LOG="server.log"

# Start the Soft-Serve server
soft serve

gum log --level info "Server started on port $SERVER_PORT. Logs are being written to $MESSAGE_LOG."

# Function to display logs
display_logs() {
    gum pager < "$MESSAGE_LOG"
}

while true; do
    action=$(gum choose "View Logs" "Stop Server" "Exit")
    case $action in
        "View Logs")
            display_logs
            ;;
        "Stop Server")
            kill $(jobs -p)
            gum log --level info "Server stopped."
            exit 0
            ;;
        "Exit")
            exit 0
            ;;
    esac
done
