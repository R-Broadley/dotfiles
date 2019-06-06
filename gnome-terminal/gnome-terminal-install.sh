#!/bin/bash

# Get path of repo directory (the one containing this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Get list of current profiles
# > list profiles (they start with :), replace :/ with ',
#   replace new lines with comma, remove trailing comma
PROFILE_LIST=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep "^:" | tr :/ \' | tr "\n" , | sed 's/,*$//g')

# If profile not in profiles list, add it
ONEDARK_ID="ac7a6fc8-f5df-47f6-84fb-dbb4e30350eb"
if [[ $PROFILE_LIST != *"$ONEDARK_ID"* ]]; then
    PROFILE_LIST="$PROFILE_LIST,'$ONEDARK_ID'"
fi

# Load template and set new profile list
DCONF_KEYS=$(<$DIR/dconf.template)
NEW_DCONF_KEYS="${DCONF_KEYS/PROFILE_LIST/[$PROFILE_LIST]}"

# Load new dconf keys
echo "$NEW_DCONF_KEYS" | dconf load /org/gnome/terminal/legacy/profiles:/
