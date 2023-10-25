# ~/.bashrc: executed by bash(1) for non-login shells.

# set colour variables to use in the file
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset

# allows the terminal to operate as a vim editor for editing commands
set -o vi

# run below upon opening terminal
#clear

#printf "\n"
#printf "   %s\n" "${grn}IP ADDR:${clr} $(curl ifconfig.me)"
#printf "   %s\n" "${grn}USER:${clr} $(echo $USER)"
#printf "   %s\n" "${ylw}DATE:${clr} $(date)"
#printf "   %s\n" "${cyn}UPTIME:${clr} $(uptime -p)"
#printf "   %s\n" "${grn}HOSTNAME:${clr} $(hostname -f)"
#printf "   %s\n" "${cyn}CPU:${clr} $(awk -F: '/model name/{print $2}' | head -1)"
#printf "   %s\n" "${ylw}KERNEL:${clr} $(uname -rms)"
#printf "   %s\n" "${ylw}PACKAGES:${clr} $(dpkg --get-selections | wc -l)"
#printf "   %s\n" "${ylw}RESOLUTION:${clr} $(xrandr | awk '/\*/{printf $1" "}')"
#printf "   %s\n" "${cyn}MEMORY:${clr} $(free -m -h | awk '/Mem/{print $3"/"$2}')"
#printf "\n"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=2000
HISTTIMEFORMAT="%F %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# comment for a non-colored prompt, only use if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# forming bash prompt, will show on success of command. stderr out to /dev/null.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# if we want colour, color_prompt will be 'yes'        red='\[\033[01;31m\]'
function bash_prompt(){
    if [ "$color_prompt" = yes ]; then
         PS1="[${grn}\u@\h${clr}: ${blu}\w${clr}]${pur}$(parse_git_branch) ${blu}$ ${clr}"
    else
         PS1="\u@\h: \w$(parse_git_branch) $ "
    fi
}
# need this here so it can run after terminal info
bash_prompt

 # enable color support of ls and also add handy aliases
 if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(d    ircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
 
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# optional to add .bash_aliases from repo
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$PATH:$GOPATH/bin


