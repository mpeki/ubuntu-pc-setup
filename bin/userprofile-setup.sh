#!/bin/bash

set -e

now=$(date +"%s")

#only copy in .ssh if existing .ssh is empty
if [[ -z "$(ls -A ~/.ssh)" ]]; then
#	printf "The .ssh folder is not empty, copying it to .ssh-original_%s/n" ${now}
#	mv ~/.ssh ~/.ssh-original_${now}
	unzip msp.zip -d ~/
	chmod 600 ~/.ssh/id_rsa
	ssh-add
fi

if [[ -f ~/.bash_aliases && -z "$(cat ~/.bash_aliases | grep "#Update & upgrade packages")" ]]; then
	printf "\n\n#Update & upgrade packages\n" >> ~/.bash_aliases
	printf "alias update='sudo apt-get -y dist-upgrade && sudo apt-get -y update&&sudo apt-get -y upgrade && sudo apt-get -y clean && sudo apt-get -y autoclean && sudo apt-get -y autoremove'\n" >> ~/.bash_aliases
	source .bash_aliases
fi
