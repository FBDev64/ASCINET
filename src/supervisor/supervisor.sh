#!/bin/bash

# Server address and port
SERVER_ADDR=192.168.1.11
SERVER_PORT=8080

# List of authorized supervisor computers
SUPERVISORS=("fbdev")
SUPERVISOR_PASSWORD="3310"

# Connect to the server
exec 3<>/dev/tcp/$SERVER_ADDR/$SERVER_PORT || exit 1
echo "Connected to $SERVER_ADDR:$SERVER_PORT" >&2

# Authenticate supervisor
username=$(gum input --prompt "Enter username: ")
is_supervisor=false
for supervisor in "${SUPERVISORS[@]}"; do
    if [ "$supervisor" == "$username" ]; then
        is_supervisor=true
        break
    fi
done

if $is_supervisor; then
    password=$(gum input --password --prompt "Enter password: ")
    if [ "$password" == "$SUPERVISOR_PASSWORD" ]; then
        echo "Supervisor $username authenticated."
    else
        gum confirm "Incorrect password for $username" --ok-label "Try Again"
        exec 3>&-
        exit 1
    fi
else
    gum confirm "Non-supervisor user" --ok-label "Exit"
    exec 3>&-
    exit 1
fi

while true; do
    action=$(gum choose "Send Message" "Receive Messages" "Send File" "View Files" "Exit")
    echo "$action" >&3
    case $action in
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            echo "send_message" >&3
            echo "$message" >&3
            ;;
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
        "View Files")
            echo "view_files" >&3
            read -r files <&3
            gum pager --header "Files on the Server" --content "$files"
            ;;
        "Exit")
            exec 3>&-
            exit 0
            ;;
    esac
done
