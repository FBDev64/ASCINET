#!/bin/bash

# Server address and port
SERVER_USER=$(gum input --placeholder="Remote user")
SERVER_IP=$(gum input --placeholder="Remote IP")
SERVER_PORT=8080

# Connect to the Soft-Serve server
exec 3<>/dev/tcp/$SERVER_IP/$SERVER_PORT || exit 1
gum log --level info "Connected to $SERVER_USER@$SERVER_IP:$SERVER_PORT" >&2

while true; do
    action=$(gum choose "Send Message" "Send File" "Docs" "Quit")
    case "$action" in
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            # Send the message to the server
            echo "$message" >&3
            gum log --level info "$message"
            ;;
        "Send File")
            file_path=$(gum file ~)
            gum log --level info "Sending file: $file_path"
            scp -r "$file_path" "$SERVER_USER@$SERVER_IP:~/ASCINET/files/"
            ;;
        "Docs")
            glow github.com/FBDev64/ASCINET/
            ;;
        "Quit")
            exit 0
            ;;
    esac
done
