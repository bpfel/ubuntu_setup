#!/bin/bash
# Define output formatting
RED_bold='\e[1m\e[31m'
GREEN_bold='\e[1m\e[32m'
YELLOW_bold='\e[1m\e[33m'

# Get superuser priveliges but keep the current environment
if [ "$EUID" != 0 ]
then 
    sudo --preserve-env "$0" "$@"
    exit $?
fi

# Test if there is an existing .bashrc
# If so make a backup and remove the original
# If necessary remove write protection first

if [[ -f ~/.bashrc ]]
then
	echo -e "${YELLOW_bold}Existing .bashrc detected"
        echo -e "${YELLOW_bold}Trying to make a backup"
        mv ~/.bashrc ~/bashrc.old
	if [ $? -eq 0 ]
	then
		echo -e "${GREEN_bold}Successifully backed up .bashrc as .bashrc.old"
	else
                echo -e "${YELLOW_bold}This did not work, removing write protection now."
		sudo chattr -i ~/.bashrc
		mv ~/.bashrc ~/bashrc.old
                if [ $? -eq 0 ]
                then
                    echo -e "${GREEN_bold}Successifully backed up .bashrc as .bashrc.old"
                else
                    echo -e "${RED_bold}Could not back up / remove old .bashrc."
                fi
	fi
fi

# move the .bashrc file to the correct place
cp ../files/.bashrc ~/.bashrc
if [ $? -eq 0 ]
then
    echo -e "${GREEN_bold}Successifully placed ubuntu_setup .bashrc"
else
    echo -e "${RED_bold}Could not place ubuntu_setup .bashrc"
fi
    
# protect the .bashrc file from editing to prevent potential exploits
# see: https://wiki.ubuntuusers.de/Bash/bashrc/
sudo chattr +i ~/.bashrc

# move the .vimrc file to the correct place
cp ../files/.vimrc ~/.vimrc
if [ $? -eq 0 ]
then
    echo -e "${GREEN_bold}Successifully placed ubuntu_setup .vimrc"
else
    echo -e "${RED_bold}Could not place ubuntu_setup .vimrc"
fi
