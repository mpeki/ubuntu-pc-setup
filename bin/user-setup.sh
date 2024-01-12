#!/bin/bash

set -e

username="@1"

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