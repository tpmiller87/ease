#!/bin/bash

file=$2


#########FUNCTIONS START#########

Help () {
#Display Help
#option h
	echo "Syntax: ./ease.sh [-h|n|c|l|a] <filename>"
	echo "options:"
	echo "-h     Print help!"
	echo "-n     Extract only the NTLM hash."
	echo "-c     Extract the NTLM and users in hash:user format for correlation."
	echo "-l     Extract only usernames."
	echo "-a     Do all options and output each to a new file."
	echo
}

ntlm () {
#Tool format: CME
#Removes machine accounts and gives you the only the NTLM hash.
#Should be used for cracking
#option n (for ntlm)
	grep -v "[]$+*[]" $file | awk -F ' ' '{print $4}' | awk -F ':::' '{print $1}' | cut -d ':' -f 4
}

hashuser () {
#Tool format: CME
#Removes machine accounts and gives you 'hash:user'
#Should be used for correlating cracked hashes from hashtopolis.
#option c (for correlate, lame)
	grep -v "[]$+*[]" $file | awk -F ' ' '{print $4}' | awk -F ':::' '{print $1}' | awk -F : '{print $4,":",$1}' | tr -d ' ' | sed 's/:.*\\/:/'
}

userlist () {
#Tool format: CME
#Removes machine accounts and only username without domain attached.
#Should be used for making user lists
#option l (for list!)
	grep -v "[]$+*[]" $file | awk -F ' ' '{print $4}' | awk -F ':::' '{print $1}' | awk -F : '{print $1}' | cut -d '\' -f 2
}

all () {
#option a
	ntlm > ntlm.txt
	hashuser > hash_user.txt
	userlist > users.txt
}

#########FUNCTIONS END#########


while getopts ":hncla:" flag; do
	case $flag in
		h) Help
		   exit;;
		n) ntlm
		   exit;;
		c) hashuser
		   exit;;
		l) userlist
		   exit;;
		a) all
		   exit;;
	   \?) echo "Invalid option, please choose a valid option or use '-h' for help"
		   exit;;
	esac
done