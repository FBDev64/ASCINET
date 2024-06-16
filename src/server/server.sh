#!/bin/bash

# Server port
SERVER_PORT=8080

# Log files
MESSAGE_LOG="server.log"

# Start the Soft-Serve server
gum log --level info "Server started on port $SERVER_PORT. Logs are being written to $MESSAGE_LOG."
soft serve

# Function to display logs
display_logs() {
    gum pager < "$MESSAGE_LOG"
}

while true; do
    display_logs
done
