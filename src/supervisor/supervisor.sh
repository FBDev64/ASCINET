#!/bin/bash

# Server address and port
SERVER_ADDR=$(gum input --placeholder="Server IP")
SERVER_USER=$(gum input --placeholder="Remote Username")
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
        gum confirm "Incorrect password for $username" --affirmative "Try Again" || exit 1
    fi
else
    gum confirm "Non-supervisor user" --affirmative "Exit" || exit 1
fi

while true; do
    action=$(gum choose "Send Message" "Receive Messages" "Send File" "View Files" "Exit")
    case "$action" in
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            echo $message >> messages.txt
            scp messages.txt "$SERVER_USER"@"$SERVER_ADDR":/files/
            ;;
        "Receive Messages")
            echo "receive_messages" >&3
            gum pager < messages.txt
            ;;
        "Send File")
            file_path=$(gum file "$(pwd)")
             scp $file_path "$SERVER_USER"@"$SERVER_ADDR":/files/
            ;;
        "View Files")
            chosen = $(gum file --all $SERVER_ADDR)
            gum pager > $chosen
            ;;
        "Exit")
            exec 3>&-
            exit 0
            ;;
    esac
done
