#!/bin/bash

# Load configuration from config.yaml
CONFIG_FILE="config.yaml"
eval "$(parse_yaml "$CONFIG_FILE" "config_")"

# Server address and port
SERVER_USER="${config_server_remote_user}"
SERVER_IP="${config_server_remote_ip}"
SERVER_PORT=8080

# Start the Soft-Serve server
soft_serve --config config.yaml --bind "$SERVER_IP:$SERVER_PORT"
gum log --level info "Soft-Serve server started on $SERVER_IP:$SERVER_PORT"