#!/bin/bash

HMDIR=$(echo ~)
FOLDER=".vimbash$(date +%s)"

mkdir "${HMDIR}/${FOLDER}"
echo "Moving files into ${HMDIR}..."

# just a simple copy of existing files, files won't be overwritten unless the first copy works
touch ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases && cp ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/${FOLDER} && cp .vimrc .bashrc .bash_profile .bash_aliases ${HMDIR} && echo "Successfully copied files..." 
