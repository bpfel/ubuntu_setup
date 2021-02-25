#!/bin/bash

# Define output formatting
RED_bold='\e[1m\e[31m'
GREEN_bold='\e[1m\e[32m'
YELLOW_bold='\e[1m\e[33m'

# Get superuser priveliges but keep the current environment
echo -e "${YELLOW_bold}Getting root access"
if [ "$EUID" != 0 ]
then 
    sudo --preserve-env "$0" "$@"
    exit $?
fi

echo -e "${YELLOW_bold}Ugrading ubuntu"
apt update
apt upgrade

echo -e "${YELLOW_bold}Installing essential tools"
apt install snap terminator vim -y
snap install opera -y
snap install pycharm-community --classic -y
apt install htop -y

# Place vim
sh -c ./scripts/place_rc_files.sh

# Place scripts
sh -c ./scripts/place_scripts.sh

echo -e "${YELLOW_bold}Installing Cinnamon Desktop"
sudo apt install cinnamon
