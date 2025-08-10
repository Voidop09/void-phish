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

# Create the .server directory if it doesn't exist
mkdir -p .server

# Create a v3-compatible ngrok config to bypass the disclaimer
cat > .server/ngrok.yml <<EOF
version: "3"
agent:
  authtoken: $(ngrok config get agent.authtoken 2>/dev/null)
  web_addr: 127.0.0.1:4040
tunnels:
  phishing:
    proto: http
    addr: $port
    inspect: false
EOF

# Start ngrok with the custom config
ngrok start --all --config=.server/ngrok.yml > /dev/null &
ngrok_pid=$!
echo $ngrok_pid > ".server/ngrok.pid"

# Wait for ngrok to initialize
sleep 3

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

# Generate QR code for the URL if qrencode is available
if command -v qrencode &> /dev/null; then
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Generating QR code for easy sharing..."
    qrencode -t ANSI $ngrok_url
fi

