#!/bin/bash
##########################
#This script is made to install python on coreos in oneshot
#By: Igor Brandao <isca>
#Versao=0.1
##########################
#set -x
#set -e

#Colorize my life
clean="\033[0m"
green="\033[32;40m"
red="\033[31;40m"
blue="\033[34;40m"
yellow="\033[33;40m"
cyan="\033[36;40m"
pink="\033[35;40m"
whiteb="\033[37;1m"
###################

#the best place to get Active Python is: #http://downloads.activestate.com/ActivePython/releases
#Unfortunely this location is constantly moving so its best to download this and place in safe static location
#when you have dided just change repo/version/and download pointint to your file

#Change-me as you need
repo="http://downloads.activestate.com/ActivePython/releases/"
version="$(curl -Lks "$repo"|grep -E 'img.*folder.gif.*DIR.*href'|head -1|awk -F'href=' '{print $2}'|awk -F'/' '{print $1}'|cut -c2-)"
download="$(curl -Lks "$repo""$version"/|grep tar.gz|awk -F'href=' '{print $2}'|awk -F'"' '{print $2}')"
path_src="/opt/src"
path_py="/opt/python"
pkg="python-"$version".tgz"
extract="$(curl -Lks http://downloads.activestate.com/ActivePython/releases/"$version"|grep tar.gz|awk -F'href=' '{print $2}'|awk -F'"' '{print $2}'|awk -F'.tar' '{print $1}')"
optbin="/opt/bin"

#Begin Functions
#################

build(){
	if [ ! -e "$path_py"/bin/python ]
	then
		echo -e "$green"Installing python "$version""$clean"
		mkdir -p {"$path_py","$path_src"}
		wget "$repo""$version"/"$download" -O "$path_src"/"$pkg"
		(cd "$path_src";tar -xvzf "$pkg")
		cd "$path_src"/"$extract"
		./install.sh -I "$path_py"
    mkdir -p "$optbin"
    ln -s "$path_py"/bin/easy_install "$optbin"/easy_install
    ln -s "$path_py"/bin/pip "$optbin"/pip
    ln -s "$path_py"/bin/python "$optbin"/python
    ln -s "$path_py"/bin/python /usr/bin/python
    ln -s "$path_py"/bin/virtualenv "$optbin"/virtualenv
	else
		echo -e "$whiteb"You already have a python installed..."$clean"
	fi
}

destroy(){

	if [ -e "$path_py" ]
	then
		echo -e "
		"$whiteb"Cleaning python installed from pythonize"$clean"
		"
		(rm -rf "$path_src"/"$pkg"; \
			rm -rf "$path_py"; \
			rm -rf "$path_src"; \
      rm -rf "$optbin"/easy_install "$optbin"/pip "$optbin"/python "$optbin"/virtualenv
      rm -rf /usr/bin/python
		)
	else
		echo -e "
			"$yellow"You do not pythonized yet..."$clean"
			"$whiteb"Use: "$0""$clean""$green" install"$clean"
			"
	fi
}

case $1 in

remove)
	destroy
;;

install)
	build
;;
*)
	echo -e "
		"$whiteb"Use:"$clean""$green" install||remove"$clean"
		"
;;
esac

