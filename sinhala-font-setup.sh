#!/bin/bash

# Sinhala Font Config Tool by Pamod
# Interactive script to configure Sinhala font rendering in Linux

# ─────────────── Color Codes ───────────────
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

# ─────────────── Fonts to Check ───────────────
FONTS=("NotoSansSinhala-Regular.ttf" "NotoSerifSinhala-Regular.ttf" "lklug.ttf")

echo -e "${CYAN}🔤 Sinhala Font Configuration Tool${RESET}"
echo "------------------------------------------"

# ─────────────── Ask User Scope ───────────────
while true; do
    echo -e "${YELLOW}Choose configuration scope:${RESET}"
    echo "  1) Configure for current user only"
    echo "  2) Configure system-wide (requires sudo)"
    echo "  0) Exit"
    read -rp "👉 Enter 1, 2 or 0: " SCOPE

    case "$SCOPE" in
    1 | 2) break ;;
    0)
        echo -e "${CYAN}👋 Exiting. No changes made.${RESET}"
        exit 0
        ;;
    *) echo -e "${RED}❌ Invalid input. Please try again.${RESET}" ;;
    esac
done

# ─────────────── Font Checking ───────────────
echo -e "\n${CYAN}🔍 Checking required Sinhala fonts...${RESET}"
MISSING=()
for FONT in "${FONTS[@]}"; do
    if fc-list | grep -q "$FONT"; then
        echo -e "${GREEN}✅ OK: $FONT${RESET}"
    else
        echo -e "${RED}❌ Missing: $FONT${RESET}"
        MISSING+=("$FONT")
    fi
done

# ─────────────── Font Install ───────────────
if [ ${#MISSING[@]} -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Some required fonts are missing.${RESET}"
    read -rp "📦 Install missing fonts now? (y/n): " INSTALL
    if [[ "$INSTALL" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}🔧 Installing fonts...${RESET}"
        sudo apt update
        sudo apt install -y fonts-noto-core fonts-noto-sinhala fonts-lklug-sinhala
    else
        echo -e "${RED}🚫 Fonts not installed. Sinhala rendering may remain broken.${RESET}"
    fi
else
    read -rp "🔁 Fonts are already installed. Reinstall them? (y/n): " REINSTALL
    if [[ "$REINSTALL" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}🔃 Reinstalling Sinhala font packages...${RESET}"
        sudo apt install --reinstall -y fonts-noto-core fonts-noto-sinhala fonts-lklug-sinhala
    fi
fi

# ─────────────── FontConfig XML ───────────────
XML='<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match>
    <test name="lang" compare="contains">
      <string>si</string>
    </test>
    <edit name="family" mode="prepend" binding="strong">
      <string>Noto Sans Sinhala</string>
      <string>Noto Serif Sinhala</string>
      <string>LKLUG</string>
    </edit>
  </match>
</fontconfig>
'

echo -e "\n${CYAN}📝 Applying Sinhala font preference configuration...${RESET}"

# Determine config path
if [[ "$SCOPE" == "1" ]]; then
    CONF_PATH="$HOME/.config/fontconfig/conf.d/10-sinhala-prefer.conf"
    mkdir -p "$(dirname "$CONF_PATH")"
else
    CONF_PATH="/etc/fonts/conf.d/10-sinhala-prefer.conf"
fi

# Check if config exists
if [ -f "$CONF_PATH" ]; then
    echo -e "${YELLOW}⚠️  Config already exists at ${CONF_PATH}${RESET}"
    read -rp "🔄 Overwrite existing config? (y/n): " OVERWRITE
    if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}⏭️  Skipped writing config.${RESET}"
    else
        echo "$XML" | ([[ "$SCOPE" == "1" ]] && cat >"$CONF_PATH" || sudo tee "$CONF_PATH" >/dev/null)
        echo -e "${GREEN}✅ Config overwritten.${RESET}"
    fi
else
    echo "$XML" | ([[ "$SCOPE" == "1" ]] && cat >"$CONF_PATH" || sudo tee "$CONF_PATH" >/dev/null)
    echo -e "${GREEN}✅ Config written to $CONF_PATH${RESET}"
fi

# ─────────────── Rebuild Font Cache ───────────────
echo -e "\n${CYAN}🔃 Rebuilding font cache...${RESET}"
fc-cache -fv

# ─────────────── Verify Sinhala Fonts ───────────────
echo -e "\n${CYAN}🔎 Verifying Sinhala fonts (${GREEN}fc-list :lang=si${CYAN})...${RESET}"
fc-list :lang=si | grep -E "Sinhala|LKLUG|FreeSerif" || echo -e "${RED}❌ No Sinhala fonts found in fc-list! Something went wrong.${RESET}"

# ─────────────── Final Message ───────────────
echo -e "\n${GREEN}🎉 All Done! Sinhala font configuration complete.${RESET}"
echo -e "${YELLOW}ℹ️  Please log out and log back in to apply changes system-wide.${RESET}"

# Prevent terminal from closing
echo -e "${CYAN}\n📌 Press Enter to close this window...${RESET}"
read
