#!/bin/bash
#
#install.sh

function usage { # example of a --help parameter which is parsed through to display information
	echo "" # $0 is a default variable used for the filename of script
	echo "Usage: $0 [-u|--user] [-s|--system]" # an understandable layout to display paramaters for script
	echo "Setup linux profile in environment. Copies pre-defined repo files to proper locations."
	echo ""
	echo "Options:" # thi area shows how to parse parameters into the script as intended with brief definitions
	echo "  -u, --user         Define user that profile will be applied to. This is required.)"
	echo "  -s, --system       Define parameter to exclude uppercase alphabet characters from string."
	echo "  -h, --help         Display usage information for this script."
	echo ""
	exit 0 # exit without error
}

function install() {
  	HMDIR="/home/$1"
	FOLDER=".profile-backup-$(date +%s)"
	SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

	mkdir "${HMDIR}/${FOLDER}"
	echo "- Moving files into ${HMDIR}"
	echo "- **Expect more output on success**"

	# just a simple copy of existing files, files won't be overwritten unless the first copy works
	touch ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh && cp ${HMDIR}/.vimrc ${HMDIR}/.bashrc ${HMDIR}/.bash_profile ${HMDIR}/.bash_aliases ${HMDIR}/.profile ${HMDIR}/.git-prompt.sh ${HMDIR}/${FOLDER} && cp .vimrc .bashrc .bash_profile .bash_aliases .profile .git-prompt.sh ${HMDIR} && echo "- Successfully copied files"	

	while true; do
		read -p "Do you wish to copy ~/.ssh/config file? (y/yes/n/no): " COPY_SSH

		case $COPY_SSH in
			[yY] )  read -p "Enter the name of the file: " KEY_NAME
				cp ${SCRIPTDIR}/.ssh-config ${HMDIR}/.ssh/config && sed -i '/#/d' ${HMDIR}/.ssh/config \
				&& echo "- Copied to ${HMDIR}.ssh/config" \
				&& sed -i "s/<filename>/$KEY_NAME/g" ${HMDIR}/.ssh/config \
				&& echo "- Replaced <filename> string in ~/.ssh/config";;
			[nN] )  echo "- ${HMDIR}/.ssh/config was not set";break;;
		esac
	done

	source ${HMDIR}/.bashrc && echo "- Finished source ${HMDIR}/.bashrc"
}

while [[ $# -gt 0 ]]; do # while loop is used to assign paramaters parsed through in command line
	case $1 in # $1 represents a parsed in variable
		-u|--user) # for parameters which accept a value, we use two 'shift'/s
			INUSER="$2" # assigns the value parsed with -u to variable
			shift
			shift;;
		-s|--system)
			INSYS=true # sets variable INSYS to true
			shift
			;;	
		-h|--help) # for parameters that don't require a value, only one 'shift' is required
			usage # calls function usage() to be run
			shift
			;;
		*) # I clearly don't know how to use it... Help me out by showing the usage() function
			echo "$0: incorrect parameter parsed"
		  	usage # calls function usage() to be run
			shift
			;;
	esac # end of $1 case
done # end of $# while

if (( $EUID != 0 )); then # check if script has been run as sudo
	echo "- Run as root/sudo"
	usage; exit 0 # exit without error
fi # end of $EUID if

if [ -z "$INUSER" ]; then # defining required paramaters for script
	echo "Missing required option: -u|--user"
	usage # print for own help
fi # end of STRINGLENGTH if

if id $INUSER > /dev/null 2>&1; then
	echo "- $INUSER exists, proceeding with install"
	install $INUSER
else
  	echo "- $INUSER does not exist, exiting..."; exit 1 # exit with general error
fi
