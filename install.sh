#!/bin/bash

HMDIR=$(echo ~)

# just a simple copy of existing files
cp ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.vimbash$(date +%s)

# cp .vimrc .bashrc .bash_profile .bash_aliases $(echo ~ ${USER})
