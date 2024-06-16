#!/bin/bash

# Load configuration from config.yaml
CONFIG_FILE=~/ASCINET/src/server/data/config.yaml
eval "$(parse_yaml "$CONFIG_FILE" "config_")"

# Server address and port
SERVER_USER="${config_server_remote_user}"
SERVER_IP="${config_server_remote_ip}"
SERVER_PORT=8080

# Connect to the Soft-Serve server
exec 3<>/dev/tcp/$SERVER_IP/$SERVER_PORT || exit 1
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

# View Files
view_files() {
    gum log --level info "Listing files on $SERVER_USER@$SERVER_IP:~/ASCINET/files/"
    ssh "$SERVER_USER@$SERVER_IP" "ls -l ~/ASCINET/files/"
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
            glow github.com/fbdev64/ASCINET
            ;;
        "Quit")
            exit 0
            ;;
    esac
done
