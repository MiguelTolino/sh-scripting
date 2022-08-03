#!/bin/bash

TAR=false
DELETE=false

#Usage message

usage()
{
	echo -e "Usage: $0 [-dra] USER [USERN]\n"
	echo -e "Disable a local Linux account\n"
	echo -e "-r \t Removes the home directory associated with the account(s)."
	echo -e "-d \t Deletes accounts instead of disabling them."
	echo -e "-a \t Creates an archive of the home directory associated with the accounts(s) and                         store the archive in /archives directory\n"
	exit 1
}

#Allow root executed

if [[ $(id -u) -ne 0 ]]
then
	echo "Warning: You must be root to execute this script" >&2
	exit 1
fi	

#Options in command line

while getopts "dra" OP;
do
	case $OP in
	d)
		DELETE="true"
	;;
	r)
		REMOVE="-r"
	;;
	a)
		TAR="true"
	;;
	*)
	usage
	;;
	esac
shift
done

#Check user exits

if [[ $# -lt 1 ]]
then
	usage
fi


if [[ $DELETE=true ]]
then
	COMMAND="userdel $REMOVE"
else
	COMMAND="passwd -l"
fi

for i in $@
do
	ID_USER=$(id -u $i)
	if  [[ $? -eq 1 ]]
	then
		echo  "Error: There were a problem" >&2
		exit 1
	else
		echo "The account ($i) was deleted or locked"
	fi
	echo "processing user: $i" 

	if [[ $ID_USER -lt 1000 ]]
	then
		echo "Id accounts lower than  1000  cannot be executed"
		exit 1
	fi

	# Create an archive if requested to do so
	if [[ ${TAR}=true ]]
	then
		mkdir -p /archives
		tar -cvf /archives/${i}.tar /home/${i}
	fi
	

	$COMMAND $i

	if  [[ $? -eq 1 ]]
	then
		echo  "Error: There were a problem" >&2
		exit 1
	else
		echo "The account ($i) was deleted or locked"
	fi
 done

exit 0
