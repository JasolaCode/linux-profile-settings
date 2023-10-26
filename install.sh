#!/bin/bash

HMDIR=$(echo ~)
FOLDER=".profile-backup-$(date +%s)"

mkdir "${HMDIR}/${FOLDER}"
echo "- Moving files into ${HMDIR}"
echo "- **Expect more output on success**"

# just a simple copy of existing files, files won't be overwritten unless the first copy works
touch ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh && cp ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh ${HMDIR}/${FOLDER} && cp .vimrc .bashrc .bash_profile .bash_aliases .profile .git-prompt.sh ${HMDIR} && echo "- Successfully copied files"

read -p "Do you wish to copy ~/.ssh/config file? (y/yes/n/no): " COPY_SSH
if [ "$COPY_SSH" = "y" ] || [ "$COPY_SSH" = "yes" ]; then
	read -p "Enter the name of the file: " KEY_NAME
	
	cp .ssh-config ${HMDIR}/.ssh/config && sed -i '/#/d' ${HMDIR}/.ssh/config \
	&& echo "- Copied to ~/.ssh/config" \
	&& sed -i "s/<filename>/$KEY_NAME/g" ${HMDIR}/.ssh/config && echo "- Replaced <filename> in ~/.ssh/config"
else
	echo "- ~/.ssh/config was not set"
fi

