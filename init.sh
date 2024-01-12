#!/usr/bin/env bash
set -ue

export SETUP_DIR=/tmp/ubuntu-setup
export PROJECT_NAME=ubuntu-pc-setup

## Prompt the user to enter a username
#echo "Please enter a linux username:"
#read username

[[ ! -d $SETUP_DIR ]] && mkdir $SETUP_DIR

pushd $SETUP_DIR

ssh-keyscan github.com >> ~/.ssh/known_hosts

echo Fetching linux setup repository...
if [[ -d "${SETUP_DIR}/${PROJECT_NAME}" && -d "${SETUP_DIR}/${PROJECT_NAME}/.git" ]]; then
  pushd $PROJECT_NAME
  git pull
else
  git clone https://github.com/mpeki/ubuntu-pc-setup.git
  pushd ubuntu-pc-setup
fi

# The line you want to insert into .bashrc
line_to_insert="\n\n## INITIAL USER SETUP\n/tmp/ubuntu-setup/ubuntu-pc-setup/bin/user-setup.sh; exit\n"

# Use sed to insert the line into .bashrc
sed -i '$a '"$line_to_insert" ~/.bashrc