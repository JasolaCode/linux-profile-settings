#!/bin/bash

HMDIR=$(echo ~)
FOLDER=".profile-backup-$(date +%s)"

mkdir "${HMDIR}/${FOLDER}"
echo "About to move files into ${HMDIR}..."
echo "**Expect more output on success**"

# just a simple copy of existing files, files won't be overwritten unless the first copy works
touch ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh && cp ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh ${HMDIR}/${FOLDER} && cp .vimrc .bashrc .bash_profile .bash_aliases .profile .git-prompt.sh ${HMDIR} && cp .ssh-config ${HMDIR}/.ssh/config && echo "Successfully copied files..." 
