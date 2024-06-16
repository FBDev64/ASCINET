#!/bin/bash

# Server address and port
SERVER_USER=$(gum input --placeholder="Remote user")
SERVER_IP=$(gum input --placeholder="Remote IP")
SERVER_PORT=8080

# List of authorized supervisor computers
SUPERVISORS=("fbdev")
SUPERVISOR_PASSWORD="3310"

# Connect to the Soft-Serve server
exec 3<>/dev/tcp/$SERVER_IP/$SERVER_PORT || exit 1
gum log --level info "Connected to $SERVER_USER@$SERVER_IP:$SERVER_PORT" >&2

# Authenticate supervisor
username=$(gum input --placeholder="Enter Supervisor Username")
is_supervisor=false
for supervisor in "${SUPERVISORS[@]}"; do
    if [ "$supervisor" == "$username" ]; then
        is_supervisor=true
        break
    fi
done

if $is_supervisor; then
    password=$(gum input --password --placeholder="Enter Supervisor Password")
    if [ "$password" == "$SUPERVISOR_PASSWORD" ]; then
        echo "Supervisor $username authenticated."
    else
        gum confirm "Incorrect password for $username" --affirmative "Try Again" || exit 1
    fi
fi

while true; do
    action=$(gum choose "Alert" "Send Message" "Send File" "View Files" "Docs" "Quit")
    case "$action" in
        "Alert")
            ALERT_MSG=$(gum input --placeholder="Alert Message: ")
            gum log --level warn "$ALERT_MSG"
            # Send the alert message to the server
            echo "$ALERT_MSG" >&3
            ;;
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            # Send the message to the server
            echo "$message" >&3
            gum log --level info "$message"
            ;;
        "Send File")
            file_path=$(gum file /)
            gum log --level info "Sending file: $file_path"
            scp -r "$file_path" "$SERVER_USER@$SERVER_IP:~/ASCINET/files/"
            ;;
        "View Files")
            # Send a command to the server to list files
            echo "/list_files" >&3
            # Read the server response
            while read -r line; do
                echo "$line"
            done <&3
            ;;
        "Docs")
            glow github.com/fbdev64/ASCINET
            ;;
        "Quit")
            exit 0
            ;;
    esac
done
