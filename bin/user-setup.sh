#!/bin/bash

set -e

# Prompt the user to enter a username
echo "Please enter a username:"
read username

# Use the id command to check if the user exists
if id "$username" &>/dev/null; then
    echo "User $username exists, skipping"
    exit 0
else
    echo "Creating new user: $username."
    useradd -m -G sudo -s /bin/bash "$username"
    passwd "$username"
    tee /etc/wsl.conf << _EOF
[user]
default=${username}
_EOF
fi

chown -R msp:msp /tmp/ubuntu-setup/ubuntu-pc-setup

exit 0