#!/bin/bash

# Define Colors
RESET="\e[0m"
BOLD="\e[1m"
CYAN="\e[36m"
GREEN="\e[32m"
YELLOW="\e[33m"
MAGENTA="\e[35m"
BLUE="\e[34m"
RED="\e[31m"
WHITE="\e[97m"
GRAY="\e[90m"

# Get System Info
USER=$(whoami)
HOSTNAME=$(hostname)
OS=$(lsb_release -ds)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)
SHELL=$(basename "$SHELL")
CPU=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ":" -f2 | sed 's/^ //')
RAM=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
DISK=$(df -h / | awk 'NR==2 {print $3 " / " $2}')
GPU=$(lspci | grep -i 'vga\|display' | cut -d ":" -f3 | sed 's/^ //')
PACKAGES=$(dpkg --list | wc -l)
IP=$(hostname -I | awk '{print $1}')
PUBLIC_IP=$(curl -s https://ifconfig.me || echo "N/A")
DE=$(echo "$XDG_CURRENT_DESKTOP")
WM=$(echo "$XDG_SESSION_TYPE")
THEME=$(gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null | tr -d "'")
FONT=$(fc-match | awk -F: '{print $1}')
BIOS_VENDOR=$(sudo dmidecode -s bios-vendor 2>/dev/null || echo "N/A")
BIOS_VERSION=$(sudo dmidecode -s bios-version 2>/dev/null || echo "N/A")
MOTHERBOARD=$(sudo dmidecode -s baseboard-product 2>/dev/null || echo "N/A")
MOTHERBOARD_MANUFACTURER=$(sudo dmidecode -s baseboard-manufacturer 2>/dev/null || echo "N/A")
BATTERY=$(upower -i $(upower -e | grep 'BAT') | grep --color=never -E "percentage" | awk '{print $2}')
CPU_TEMP=$(sensors | grep 'Tctl\|Package id 0' | awk '{print $2}' | head -1)
GPU_TEMP=$(sensors | grep -i 'temp1' | awk '{print $2}' | head -1)
PROCESSES=$(ps aux --no-headers | wc -l)
LOAD_AVG=$(cat /proc/loadavg | awk '{print $1", "$2", "$3}')
DATE_TIME=$(date +"%Y-%m-%d %H:%M:%S %Z")
FILESYSTEM=$(df -T / | awk 'NR==2 {print $2}')
LISTENING_PORTS=$(ss -tuln | awk 'NR>1 {print $5}' | awk -F ":" '{print $NF}' | sort -nu | tr '\n' ' ')

# Network Interfaces
NET_INTERFACES=$(ip -o link show | awk -F': ' '{print $2}')
MAC_ADDRESSES=$(ip link | awk '/ether/ {print $2}')

# ASCII Logo
LOGO="${RED}
   █████▒██▓   █████▒ ██████  ██▓ ██████ 
 ▓██   ▒▓██▒ ▓██   ▒▒██    ▒ ▓██▒██    ▒ 
 ▒████ ░▒██▒ ▒████ ░░ ▓██▄   ▒██░ ▓██▄   
 ░▓█▒  ░░██░ ░▓█▒  ░  ▒   ██▒░██░ ▒   ██▒
 ░▒█░   ░██░ ░▒█░   ▒██████▒▒░██▒██████▒▒
  ▒ ░   ░▓    ▒ ░   ▒ ▒▓▒ ▒ ░░▓ ▒ ▒▓▒ ▒ ░
  ░      ▒ ░  ░     ░ ░▒  ░ ░ ▒ ░░ ░▒  ░ ░
  ░ ░    ▒ ░  ░ ░   ░  ░  ░   ▒ ░░  ░  ░  
         ░              ░   ░        ░  
${RESET}"

# Display the System Info
echo -e "$LOGO"
echo -e "${MAGENTA}╭──────────────────────────────────────────────────────────╮${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}User         ${RESET}: ${YELLOW}$USER@${HOSTNAME}${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}OS           ${RESET}: ${GREEN}$OS${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Kernel       ${RESET}: ${GREEN}$KERNEL${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Uptime       ${RESET}: ${CYAN}$UPTIME${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Shell        ${RESET}: ${RED}$SHELL${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}CPU          ${RESET}: ${CYAN}$CPU${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}CPU Temp     ${RESET}: ${RED}${CPU_TEMP:-N/A}${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}GPU          ${RESET}: ${CYAN}$GPU${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}GPU Temp     ${RESET}: ${RED}${GPU_TEMP:-N/A}${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}RAM Usage    ${RESET}: ${YELLOW}$RAM${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Disk Usage   ${RESET}: ${RED}$DISK${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Processes    ${RESET}: ${GREEN}$PROCESSES Running${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Load Average ${RESET}: ${YELLOW}$LOAD_AVG${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Packages     ${RESET}: ${GREEN}$PACKAGES Installed${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}IP Address   ${RESET}: ${YELLOW}$IP${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Public IP    ${RESET}: ${YELLOW}$PUBLIC_IP${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Battery      ${RESET}: ${GREEN}${BATTERY:-N/A}${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}BIOS Vendor  ${RESET}: ${MAGENTA}$BIOS_VENDOR${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}BIOS Version ${RESET}: ${MAGENTA}$BIOS_VERSION${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Motherboard  ${RESET}: ${CYAN}$MOTHERBOARD ($MOTHERBOARD_MANUFACTURER)${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}File System  ${RESET}: ${WHITE}$FILESYSTEM${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Date & Time  ${RESET}: ${CYAN}$DATE_TIME${RESET}"
echo -e "${MAGENTA}│ ${BOLD}${BLUE}Listening Ports ${RESET}: ${YELLOW}$LISTENING_PORTS${RESET}"
echo -e "${MAGENTA}╰──────────────────────────────────────────────────────────╯${RESET}"

