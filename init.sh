#!/usr/bin/env bash
set -ue

export SETUP_DIR=/tmp/ubuntu-setup

# Prompt the user to enter a username
echo "Please enter a linux username:"
read username

[[ ! -d $SETUP_DIR ]] && mkdir $SETUP_DIR

pushd $SETUP_DIR

ssh-keyscan github.com >> ~/.ssh/known_hosts

echo Fetching linux setup repository...
git clone https://github.com/mpeki/ubuntu-pc-setup.git

pushd ubuntu-pc-setup

./bin/user-setup.sh $username

# Pause for user input before exiting
read -p "Press Enter to exit..."