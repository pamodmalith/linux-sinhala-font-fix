#!/bin/bash

# Sinhala Font Uninstaller Script

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}🧹 Sinhala Font Config Removal Script${RESET}"
echo "------------------------------------------"

# User config
USER_CONF="$HOME/.config/fontconfig/conf.d/10-sinhala-prefer.conf"
# System config
SYS_CONF="/etc/fonts/conf.d/10-sinhala-prefer.conf"

# Remove user config
if [ -f "$USER_CONF" ]; then
    echo -e "${YELLOW}🔧 Removing user font config...${RESET}"
    rm "$USER_CONF"
    echo -e "${GREEN}✅ User font config removed.${RESET}"
fi

# Remove system config (with sudo)
if [ -f "$SYS_CONF" ]; then
    echo -e "${YELLOW}🔧 Removing system font config...${RESET}"
    sudo rm "$SYS_CONF"
    echo -e "${GREEN}✅ System font config removed.${RESET}"
fi

# Rebuild font cache
echo -e "${YELLOW}🔄 Rebuilding font cache...${RESET}"
fc-cache -fv

echo -e "${GREEN}✅ Sinhala font override uninstalled successfully.${RESET}"
echo -e "${YELLOW}ℹ️  Please log out and log back in to fully apply removal.${RESET}"

# Wait for user to close
echo -e "${YELLOW}\n📌 Press Enter to exit...${RESET}"
read
