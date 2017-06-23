#!/bin/bash
##########################
#This script is made to customize profile user in CoreOS
#Place me on /etc/profile.d/
#By: <isca>
#Versao=0.1
##########################

#Colorize my life
clean="\033[0m"
green="\033[32;40m"
red="\033[31;40m"
blue="\033[34;40m"
yellow="\033[33;40m"
cyan="\033[36;40m"
pink="\033[35;40m"
whiteb="\033[37;1m"

#Aliases Field
alias ls="ls --color"
alias l="ls -la"
alias ll="ls -laF"
alias la="ls -a"
alias cp="cp -v"
alias rm="rm -i"
alias mv="mv -v"

#Test pythonized
if [ -e /opt/python/bin/python ]
then
	export PATH="$PATH":/opt/python/bin
fi

if [ -d /opt/bin ]
then
	export PATH="$PATH":/opt/bin
fi

