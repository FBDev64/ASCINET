#!/bin/bash

# Gum Environment Variables
export GUM_INPUT_CURSOR_FOREGROUND="       #0437F2"
export GUM_INPUT_PROMPT="> "
export GUM_INPUT_WIDTH=80

# Server address and port
SERVER_USER="$(gum input --placeholder="Enter Remote User")"
SERVER_IP="gum input --placeholder="Enter Remote IP")"
SERVER_PORT=8080

# Connect to the Soft-Serve server
exec 3<>/dev/tcp/"$SERVER_IP"/"$SERVER_PORT" || exit 1
gum log --level info "Connected to $SERVER_USER@$SERVER_IP:$SERVER_PORT" >&2

# Send File
send_file() {
    file_path=$(gum file "$(pwd)")
    if [ -n "$file_path" ]; then
        gum log --level info "Sending file: $file_path"
        scp "$file_path" "$SERVER_USER@$SERVER_IP:~/ASCINET/files/"
    else
        gum log --level error "No file selected"
    fi
}

while true; do
    action=$(gum choose "Send Message" "Send File" "Docs" "Quit")
    case "$action" in
        "Send Message")
            message=$(gum input --prompt "Enter the message: ")
            echo "$message" >&3
            gum log --level info "$message"
            ;;
        "Send File")
            send_file
            ;;
        "Docs")
            cd ..
	    soft
	    cd src
            ;;
        "Quit")
            exit 0
            ;;
    esac
done
