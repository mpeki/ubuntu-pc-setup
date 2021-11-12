#!/bin/bash

set -e
source tia-project.env

PROJECT_DIR=~/Dev/tia/${BASE_GIT_URL/git@/}
mkdir -p ${PROJECT_DIR}

if [[ -f ~/.bash_aliases && -z "$(cat ~/.bash_aliases | grep "#Tia project shortcuts")" ]]; then
	printf "\n\n#Tia project shortcuts\n" >> ~/.bash_aliases
	printf "alias gdev='cd ~/Dev'\n" >> ~/.bash_aliases
	printf "alias gtia='gdev; cd tia'\n" >> ~/.bash_aliases
	printf "alias ggit='gtia; cd ${BASE_GIT_URL/git@/}'\n" >> ~/.bash_aliases
fi


#Clone projects listed in tia-project.env
for group in "${!GIT_PROJECTS[@]}"; do
	mkdir -p ${PROJECT_DIR}/${group}/
   	projects="${GIT_PROJECTS[$group]}"
	for project in ${projects//,/ }
	do
		pushd "${PROJECT_DIR}/${group}"
		if [[ ! -d  "${PROJECT_DIR}/${group}/${projct}" ]]; then
			git clone ${BASE_GIT_URL}:${project}
		fi
	done
	pushd ${PROJECT_DIR}   
done

#Add project shortcuts
for group in "${!GIT_PROJECTS[@]}"; do
	if [[ -z "$(cat ~/.bash_aliases | grep ${group})" ]]; then
		printf "alias g${group}='ggit; cd ${group}'\n" >> ~/.bash_aliases
	fi
	projects="${GIT_PROJECTS[$group]}"
	for project in ${projects//,/ }
	do
		PNAME=$(echo ${project} | sed 's/^.*\/\(.*\).git$/\1/')
		if [[ -z "$(cat ~/.bash_aliases | grep ${PNAME})" ]]; then
			printf "alias g${PNAME}='g${group}; cd ${PNAME}'\n" >> ~/.bash_aliases		
		fi
	done
done

source ~/.bash_aliases