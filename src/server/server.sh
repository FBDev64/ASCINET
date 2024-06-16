#!/bin/bash

# Load configuration from config.yaml
CONFIG_FILE="config.yaml"
eval "$(bash parse_yaml.sh "$CONFIG_FILE" "config_")"

# Server address and port
SERVER_PORT=8080

# Start the Soft-Serve server
gum log --level info "Soft-Serve server started on port $SERVER_PORT"
soft serve