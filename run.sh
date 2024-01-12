#!/usr/bin/env bash
set -ue

export SETUP_DIR=/tmp/ubuntu-setup

[[ ! -d $SETUP_DIR ]] && mkdir $SETUP_DIR

pushd $SETUP_DIR

echo Fetching linux setup repository...
git clone git@github.com:mpeki/ubuntu-pc-setup.git

