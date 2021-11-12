#!/bin/bash

set -e

source ~/.bashrc

if [[ ! -d ~/linux-setup ]]; then
	mkdir ~/linux-setup
fi

cd ~/linux-setup

# Install some tools
if [[ ! -f /etc/apt/sources.list.d/hluk-ubuntu-copyq-impish.list ]]; then
	sudo add-apt-repository ppa:hluk/copyq
fi
sudo apt update && sudo apt upgrade
sudo apt install curl copyq git

# Install Chrome - "Current" version
if [[ ! -f ~/linux-setup/google-chrome-stable_current_amd64.deb ]]; then
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
fi

# Install SDK manager
if [[ ! -d /home/msp/.sdkman ]]; then
	curl -s "https://get.sdkman.io" | bash
fi
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

# Install JetBrains toolbox
if [ ! -d ~/.local/share/JetBrains/Toolbox ]; then

	wget --show-progress -qO ./toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"

	TOOLBOX_TEMP_DIR=$(mktemp -d)

	tar -C "$TOOLBOX_TEMP_DIR" -xf toolbox.tar.gz
	rm ./toolbox.tar.gz

	"$TOOLBOX_TEMP_DIR"/*/jetbrains-toolbox

	rm -r "$TOOLBOX_TEMP_DIR"

fi


# Install Docker https://docs.docker.com/engine/install/ubuntu/
if [[ ! $(docker -v) ]]; then

	sudo apt-get -y install \
	    ca-certificates \
	    curl \
	    gnupg \
	    lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	echo \
  	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  	sudo apt-get update
 	sudo apt-get install docker-ce docker-ce-cli containerd.io

 	#Post install tasks https://docs.docker.com/engine/install/linux-postinstall/
 	sudo groupadd docker
 	sudo usermod -aG docker $USER
	
	newgrp docker

	docker run hello-world

	sudo systemctl enable docker.service
 	sudo systemctl enable containerd.service

fi


# Install IntelliJ EAP version
sudo snap install intellij-idea-ultimate --classic --edge

# Install Sublime Text
if cat /etc/apt/sources.list | grep sublimetext ; then
	printf "Sublime Text repo is already installed"
else
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
fi
sudo apt-get update
sudo apt-get install sublime-text

sudo apt -y autoremove

# Install NVM
if [[ ! -d ${HOME}/.nvm/ && ! -f ${HOME}/.nvm/nvm.sh ]]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
	nvm install node
	npm install --global yarn
	source ~/.bashrc
fi

#Does not work!!!
#if [[ -z "$(echo ${PATH} | grep ~/.local/bin)" && ! -d ~/.local/bin ]]; then
#	mkdir -p ${HOME}/.local/bin
#	printf "\n\nexport PATH=${PATH}:${HOME}/.local/bin\n" >> .bashrc
#	pushd ${HOME}/.local/bin
#	curl -o- https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > git-prompt.sh
#	echo echo #Setting up git-prompt
#	echo source ~/.local/bin/git-prompt.sh >> ~/.bashrc
#	echo export GIT_PS1_SHOWDIRTYSTATE=1 >> ~/.bashrc
#	echo export PS1='\w$(__git_ps1 " (%s)")\$ '	>> ~/.bashrc
#fi


exit 0