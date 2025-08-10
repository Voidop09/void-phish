#!/bin/bash

port=$1

echo "[+] Starting ngrok on port $port..."

# Just start ngrok normally with no custom config
ngrok http $port
