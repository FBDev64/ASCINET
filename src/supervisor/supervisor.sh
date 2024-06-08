#!/bin/bash

# Server address and port

SERVER_USER=$(gum input --placeholder="Remote user")
SERVER_IP=$(gum input --placeholder="Remote IP")
SERVER_PORT=8080

# List of authorized supervisor computers
SUPERVISORS=("fbdev")
SUPERVISOR_PASSWORD="3310"

# Connect to the server
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
else
    gum confirm "Non-supervisor user" --affirmative "Exit" || exit 1
fi

while true; do
    action=$(gum choose "Alert" "Send Message" "Send File" "View Files" "Help" "Quit")
    case "$action" in
        "Alert")
            ALERT_MSG=$(gum input --placeholder="Alert Message: ")
            gum log --level warn "$ALERT_MSG"
            ;;
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            echo "$message" > /dev/tty
            gum log --level info "$message"
            ;;
        "Send File")
            file_path=$(gum file "$(pwd)")
            gum log --level info "Wrote file at remote server in /files/ folder." | ssh "$SERVER_USER"@"$SERVER_IP" -p "$SERVER_PORT" -T "cat > /file/"$file_path""
            ;;
        "View Files")
            ssh "$SERVER_HOSTNAME" -p "$SERVER_PORT" -T "cat > /file/"$file_path"" | chosen = $(gum file --all $SERVER_ADDR)
            gum pager < "$chosen"
            ;;
        "Help")
            glow github.com/FBDev64/ASCINET/
            ;;
        "Quit")
            exit 0
            ;;
    esac
done
