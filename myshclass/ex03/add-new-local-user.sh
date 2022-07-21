#!/bin/bash

USERNAME=$(whoami)
NEWUSER=$1
COMMENT=$2

#Check if we are root user

if [[ "$USERNAME" != "root" ]]
then
	echo "You need to execute this script with root privileges"
	exit 1
fi

# Right usage
if [[ $# -ne 2 ]]
then
	echo "Usage: $0 username comment"
	exit 1
fi


#Create a new password
PASSWORD=$(date +%s%N | sha256sum | head -c32)

#Create a new user and set a password
useradd -c ${COMMENT} ${NEWUSER}
echo "${PASSWORD}" | passwd --stdin $NEWUSER

#Configure password expires
passwd -e $NEWUSER

#In case any error, exit 1
if [[ $? -eq 1 ]]
then
	echo "Error..."
	exit 1
fi

#Display user data
echo -e "\nData information:\n"
echo "Username: $NEWUSER"
echo "Comment: $COMMENT"
echo "Password: $PASSWORD"
echo "HOST: $(hostname)"
