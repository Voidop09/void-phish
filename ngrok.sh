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

# Ngrok configuration
port=$1

echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Starting Ngrok on port $port..."
ngrok http $port > /dev/null &
ngrok_pid=$!
echo $ngrok_pid > ".server/ngrok.pid"

# Wait for ngrok to initialize
sleep 2

# Get the public URL
if command -v curl &> /dev/null; then
    ngrok_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o '"public_url":"[^"]*' | grep -o 'https://[^"]*')
elif command -v wget &> /dev/null; then
    ngrok_url=$(wget -qO- http://127.0.0.1:4040/api/tunnels | grep -o '"public_url":"[^"]*' | grep -o 'https://[^"]*')
else
    echo -e "${RED}[${WHITE}!${RED}]${CYAN} Failed to get ngrok URL. Please install curl or wget."
    exit 1
fi

echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Ngrok URL: $ngrok_url"
echo $ngrok_url > ".server/ngrok_url.txt"
