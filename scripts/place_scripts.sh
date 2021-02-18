#!/bin/bash
DIR="$( cd "$( dirname "$BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd)"

# Define output formatting
RED_bold='\e[1m\e[31m'
GREEN_bold='\e[1m\e[32m'
YELLOW_bold='\e[1m\e[33m'


if [ "$EUID" != 0 ]
then 
    sudo --preserve-env "$0" "$@"
    exit $?
fi

echo -e "${YELLOW_bold}Copying scripts to /usr/local/bin/"

cp $DIR/xx /usr/local/bin/xx
chmod 700 /usr/local/bin/xx
