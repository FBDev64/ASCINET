#!/bin/bash

# Server address and port
SERVER_ADDR=
SERVER_PORT=8080

# Connect to the server
exec 3<>/dev/tcp/$SERVER_ADDR/$SERVER_PORT || exit 1
echo "Connected to $SERVER_ADDR:$SERVER_PORT" >&2

while true; do
    action=$(gum choose "Receive Messages" "Send File" "Exit")
    echo "$action" >&3
    case $action in
        "Receive Messages")
            echo "receive_messages" >&3
            read -r messages <&3
            gum pager --header "Received Messages" --content "$messages"
            ;;
        "Send File")
            echo "send_file" >&3
            file_path=$(gum file --folder "$(pwd)")
            cat "$file_path" >&3
            ;;
        "Exit")
            exec 3>&-
            exit 0
            ;;
    esac
done